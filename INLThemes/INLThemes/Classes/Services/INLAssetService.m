//
//  INLAssetService.m
//  INLAssetService
//
//  Created by Tomas Hakel on 24/02/2016.
//  Copyright © 2016 Inloop. All rights reserved.
//

#import "INLAssetService.h"


@implementation INLAssetService

+(instancetype)sharedService {
	static INLAssetService * sharedService = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedService = [[INLAssetService alloc] init];
	});
	return sharedService;
}

-(id)init {
	if (self = [super init]) {
		_operationQueue = [[NSOperationQueue alloc] init];
		_operationQueue.maxConcurrentOperationCount = 4;

		NSURLSessionConfiguration * sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
		sessionConfiguration.timeoutIntervalForResource = 60;
		sessionConfiguration.HTTPMaximumConnectionsPerHost = 3;
		sessionConfiguration.requestCachePolicy = NSURLRequestUseProtocolCachePolicy;

		_imageSession = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:nil delegateQueue:_operationQueue];
	}
	return self;
}

#pragma mark - Asset download

-(void)downloadImages:(NSArray<NSString *> *)imageNames
			  baseURL:(NSURL *)baseURL
			  onImage:(void (^)(UIImage *, NSString *))onImage
		   completion:(void (^)(NSArray<UIImage *> *))completion
{
	NSMutableArray<UIImage *> * images = [@[] mutableCopy];
	NSMutableArray<NSString *> * downloadTasks = [@[] mutableCopy];

	void (^taskComplete)(NSString *) = ^(NSString * task) {
		[downloadTasks removeObject:task];
		if (downloadTasks.count == 0 && completion) {
			completion(images);
		}
	};

	for (NSString * imageName in imageNames) {
		[self downloadImageWithURL:[baseURL URLByAppendingPathComponent:imageName]
			success:^(UIImage * image) {
				[images addObject:image];

				if (onImage) {
					onImage(image, imageName);
				}
				taskComplete(imageName);
			}
			failure:^(NSError * error) {
				NSLog(@"%@", error);
				taskComplete(imageName);
			}];

		[downloadTasks addObject:imageName];
	}
}

-(void)downloadAndStoreImages:(NSArray<NSString *> *)imageNames
					  baseURL:(NSURL *)baseURL
					  onImage:(void (^)(UIImage *, NSString *))onImage
				   completion:(void (^)(NSArray<UIImage *> *))completion
{
	void (^onImageDownloaded)(UIImage *, NSString *) = ^(UIImage * image, NSString * imageName) {

		[self storeImage:image named:imageName];

		if (onImage) {
			onImage(image, imageName);
		}
	};

	[self downloadImages:imageNames baseURL:baseURL onImage:onImageDownloaded completion:completion];

}

-(NSURLSessionTask *)downloadAssetWithURL:(NSURL *)url
								  decoder:(id (^)(NSData *))decode
								  success:(void (^)(id asset))success
								  failure:(void (^)(NSError * error))failure
{
	NSURLSessionTask * task = [self.imageSession dataTaskWithURL:url
		completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
			if (error && failure) {
				failure(error);
			}
			else if (response) {
				dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
				id asset = decode(data);
				dispatch_async(dispatch_get_main_queue(), ^{
					if (asset) {
						success(asset);
					}
					else if (failure) {
						failure([NSError errorWithDomain:@"Unable to decode image" code:0 userInfo:nil]);
					}
				});
			});
		}
	}];
	[task resume];
	return task;
}

-(NSURLSessionTask *)downloadImageWithURL:(NSURL *)url
								  success:(void (^)(UIImage * image))success
								  failure:(void (^)(NSError * error))failure
{
	return [self downloadAssetWithURL:url
							  decoder:^id (NSData * data) { return [UIImage imageWithData:data]; }
							  success:success
							  failure:failure];
}

-(NSURLSessionTask *)downloadAndStoreAssetWithURL:(NSURL *)url
										  encoder:(NSData *(^)(id))encode
										  decoder:(id (^)(NSData *))decode
										  success:(void (^)(id asset))success
										  failure:(void (^)(NSError * error))failure
{
	void (^downloadSuccess)(id) = ^(id asset) {

		[self storeAsset:asset named:[url lastPathComponent] encoder:encode];

		if (success) {
			success(asset);
		}
	};

	return [self downloadAssetWithURL:url decoder:decode success:downloadSuccess failure:failure];

}

-(NSURLSessionTask *)downloadAndStoreImageWithURL:(NSURL *)url
										  success:(void (^)(UIImage * image))success
										  failure:(void (^)(NSError * error))failure
{
	void (^downloadSuccess)(UIImage *) = ^(UIImage * image) {

		[self storeImage:image named:[url lastPathComponent]];

		if (success) {
			success(image);
		}
	};

	return [self downloadImageWithURL:url success:downloadSuccess failure:failure];
}

#pragma mark - Local storage

-(id)assetNamed:(NSString *)assetName decoder:(id (^)(NSData *))decode {

	NSString * path = [self pathForFilename:assetName];

	if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
		return decode([NSData dataWithContentsOfFile:path]);
	}
	return nil;
}

-(UIImage *)imageNamed:(NSString *)imageName {
	NSString * path = [self pathForFilename:imageName];

	if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
		return [UIImage imageWithData:[NSData dataWithContentsOfFile:path]];
	}
	return [UIImage imageNamed:imageName];
}

-(void)storeAsset:(id)asset named:(NSString *)assetName encoder:(NSData *(^)(id))encode {
	[[NSFileManager defaultManager] createFileAtPath:[self pathForFilename:assetName]
											contents:encode(asset)
										  attributes:nil];
}

-(void)storeImage:(UIImage *)image named:(NSString *)imageName {
	[self storeAsset:image named:imageName encoder:^NSData *(UIImage * image) {
		BOOL isJPG = [@[@"jpg", @"jpeg"] containsObject:imageName.lowercaseString];
		return isJPG ? UIImageJPEGRepresentation(image, .9) : UIImagePNGRepresentation(image);
	}];
}

-(NSString *)pathForFilename:(NSString *)filename {
	return [[self storageDirectory] stringByAppendingPathComponent:filename];
}

-(NSString *)storageDirectory {
	return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
}

#pragma mark - Convinience

+(void)downloadImages:(NSArray<NSString *> *)imageNames
			  baseURL:(NSURL *)baseURL
		   completion:(void (^)(NSArray<UIImage *> *))completion
{
	[self downloadImages:imageNames baseURL:baseURL onImage:nil completion:completion];
}

+(void)downloadAndStoreImages:(NSArray<NSString *> *)imageNames
					  baseURL:(NSURL *)baseURL
				   completion:(void (^)(NSArray<UIImage *> *))completion
{
	[self downloadAndStoreImages:imageNames baseURL:baseURL onImage:nil completion:completion];
}

+(NSURLSessionTask *)downloadAndStoreAssetWithURL:(NSURL *)url
										  encoder:(NSData *(^)(id))encode
										  decoder:(id (^)(NSData *))decode
										  success:(void (^)(id asset))success
										  failure:(void (^)(NSError * error))failure
{
	return [self downloadAndStoreAssetWithURL:url encoder:encode decoder:decode success:success failure:failure];
}

+(NSURLSessionTask *)downloadAssetWithURL:(NSURL *)url
								  decoder:(id (^)(NSData *))decode
								  success:(void (^)(id asset))success
								  failure:(void (^)(NSError * error))failure
{
	return [[self sharedService] downloadAssetWithURL:url decoder:decode success:success failure:failure];
}

+(void)downloadImages:(NSArray<NSString *> *)imageNames
			  baseURL:(NSURL *)baseURL
			  onImage:(void (^)(UIImage *, NSString *))onImage
		   completion:(void (^)(NSArray<UIImage *> *))completion
{
	[[self sharedService] downloadImages:imageNames baseURL:baseURL onImage:onImage completion:completion];
}

+(void)downloadAndStoreImages:(NSArray<NSString *> *)imageNames
					  baseURL:(NSURL *)baseURL
					  onImage:(void (^)(UIImage *, NSString *))onImage
				   completion:(void (^)(NSArray<UIImage *> *))completion
{
	[[self sharedService] downloadAndStoreImages:imageNames baseURL:baseURL onImage:onImage completion:completion];
}

+(NSURLSessionTask *)downloadImageWithURL:(NSURL *)url
								  success:(void (^)(UIImage *image))success
								  failure:(void (^)(NSError *error))failure
{
	return [[self sharedService] downloadImageWithURL:url success:success failure:failure];
}

+(NSURLSessionTask *)downloadAndStoreImageWithURL:(NSURL *)url
										  success:(void (^)(UIImage * image))success
										  failure:(void (^)(NSError * error))failure
{
	return [[self sharedService] downloadAndStoreImageWithURL:url success:success failure:failure];
}

+(id)assetNamed:(NSString *)assetName decoder:(id (^)(NSData *))decode {
	return [[self sharedService] assetNamed:assetName decoder:decode];
}

+(UIImage *)imageNamed:(NSString *)imageName {
	return [[self sharedService] imageNamed:imageName];
}

+(void)storeImage:(UIImage *)image named:(NSString *)imageName {
	[[self sharedService] storeImage:image named:imageName];
}

+(void)storeAsset:(id)asset named:(NSString *)assetName encoder:(NSData *(^)(id))encode {
	[[self sharedService] storeAsset:asset named:assetName encoder:encode];
}

@end