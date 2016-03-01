//
//  Theme.m
//
//  Created by Tomas Hakel on 28/01/2016.
//  Copyright © 2016 Inloop. All rights reserved.
//

#import "INLTheme.h"
#import "INLThemeElement.h"

@implementation INLTheme

-(instancetype)initWithThemeDict:(NSDictionary *)themeDict {

	if (self = [super init]) {
		NSMutableDictionary * uiElements = [@{} mutableCopy];
		for (NSString * elementId in themeDict.keyEnumerator) {
			uiElements[elementId] = [INLThemeElement elementWithDictionary:themeDict[elementId]];
		}
		self.uiElements = uiElements;
	}
	return self;
}

+(instancetype)themeWithPlist:(NSString *)plistName {

	NSDictionary * themeDict = nil;
	NSString * plistPath = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
	if (plistPath) {
		themeDict = [NSDictionary dictionaryWithContentsOfFile:plistPath];
	}
	return [[INLTheme alloc] initWithThemeDict:themeDict];
}

+(instancetype)themeWithJSONData:(NSData *)jsonData {

	NSDictionary * themeDict = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
	return [[INLTheme alloc] initWithThemeDict:themeDict];
}

+(instancetype)themeWithJSON:(NSString *)json {

	return [self themeWithJSONData:[json dataUsingEncoding:NSUTF8StringEncoding]];
}


@end
