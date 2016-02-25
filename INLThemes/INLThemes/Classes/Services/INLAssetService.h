//
//  INLAssetService.h
//  INLAssetService
//
//  Created by Tomas Hakel on 24/02/2016.
//  Copyright © 2016 Inloop. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXPORT double INLAssetServiceVersionNumber;
FOUNDATION_EXPORT const unsigned char INLAssetServiceVersionString[];


@interface INLAssetService : NSObject

@property(nonatomic, strong, readonly) NSURLSession * imageSession;
@property(nonatomic, strong, readonly) NSOperationQueue * operationQueue;

+(instancetype)sharedService;

#pragma - mark Assets

+(NSURLSessionTask *)downloadAndStoreAssetWithURL:(NSURL *)url
										  encoder:(NSData *(^)(id))encode
										  decoder:(id (^)(NSData *))decode
										  success:(void (^)(id asset))success
										  failure:(void (^)(NSError * error))failure;

+(NSURLSessionTask *)downloadAssetWithURL:(NSURL *)url
								  decoder:(id (^)(NSData *))decode
								  success:(void (^)(id asset))success
								  failure:(void (^)(NSError * error))failure;


+(id)assetNamed:(NSString *)assetName decoder:(id (^)(NSData *))decode;
+(void)storeAsset:(id)asset named:(NSString *)assetName encoder:(NSData *(^)(id))encode;

#pragma - mark Images

+(void)downloadImages:(NSArray<NSString *> *)imageNames
			  baseURL:(NSURL *)baseURL
		   completion:(void (^)(NSArray<UIImage *> *))completion;

+(void)downloadAndStoreImages:(NSArray<NSString *> *)imageNames
					  baseURL:(NSURL *)baseURL
				   completion:(void (^)(NSArray<UIImage *> *))completion;

+(void)downloadImages:(NSArray<NSString *> *)imageNames
			  baseURL:(NSURL *)baseURL
			  onImage:(void (^)(UIImage *, NSString *))onImage
		   completion:(void (^)(NSArray<UIImage *> *))completion;

+(void)downloadAndStoreImages:(NSArray<NSString *> *)imageNames
					  baseURL:(NSURL *)baseURL
					  onImage:(void (^)(UIImage *, NSString *))onImage
				   completion:(void (^)(NSArray<UIImage *> *))completion;

+(NSURLSessionTask *)downloadImageWithURL:(NSURL *)url
								  success:(void (^)(UIImage *image))success
								  failure:(void (^)(NSError *error))failure;

+(NSURLSessionTask *)downloadAndStoreImageWithURL:(NSURL *)url
										  success:(void (^)(UIImage * image))success
										  failure:(void (^)(NSError * error))failure;

+(UIImage *)imageNamed:(NSString *)imageName;
+(void)storeImage:(UIImage *)image named:(NSString *)imageName;

@end


