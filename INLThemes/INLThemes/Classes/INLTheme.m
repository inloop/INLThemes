//
//  Theme.m
//
//  Created by Tomas Hakel on 28/01/2016.
//  Copyright © 2016 Inloop. All rights reserved.
//

#import "INLTheme.h"
#import "INLThemeElement.h"

@implementation INLTheme

- (instancetype)initWithThemeDict:(NSDictionary *)themeDict {
	if (self = [super init]) {
		NSDictionary * aliasDict = themeDict[@"INLThemeAlias"];

		NSMutableDictionary * uiElements = [@{} mutableCopy];
		for (NSString * elementId in themeDict.keyEnumerator) {
			if ([elementId isEqualToString:@"INLThemeAlias"]) {
				continue;
			}
			NSMutableDictionary * values = [themeDict[elementId] mutableCopy];
			for (NSString * key in [themeDict[elementId] keyEnumerator]) {
				if ([aliasDict objectForKey:values[key]] != nil) {
					values[key] = aliasDict[values[key]];
				}
			}
			uiElements[elementId] = [INLThemeElement elementWithDictionary:values];
		}

		self.uiElements = uiElements;
	}
	return self;
}

+ (instancetype)themeWithPlist:(NSString *)plistName {
	NSDictionary * themeDict = nil;
	NSString * plistPath = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
	if (plistPath) {
		themeDict = [NSDictionary dictionaryWithContentsOfFile:plistPath];
	}
	return [[INLTheme alloc] initWithThemeDict:themeDict];
}

+ (instancetype)themeWithJSONData:(NSData *)jsonData {
	NSDictionary * themeDict = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
	return [[INLTheme alloc] initWithThemeDict:themeDict];
}

+ (instancetype)themeWithJSONFile:(NSString *)jsonName {
	NSString * jsonPath = [[NSBundle mainBundle] pathForResource:jsonName ofType:@"json"];
	return [self themeWithJSONData:[NSData dataWithContentsOfFile:jsonPath]];
}

+ (instancetype)themeWithJSON:(NSString *)json {
	return [self themeWithJSONData:[json dataUsingEncoding:NSUTF8StringEncoding]];
}

@end
