//
//  Theme.m
//
//  Created by Tomas Hakel on 28/01/2016.
//  Copyright © 2016 Inloop. All rights reserved.
//

#import "INLTheme.h"
#import "INLThemeService.h"
#import "INLThemeElement.h"

@implementation INLTheme

+(instancetype)themeWithPlist:(NSString *)plistName {
	INLTheme * theme = [[INLTheme alloc] init];
	NSMutableDictionary * uiElements = [@{} mutableCopy];

	NSString * plistPath = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
	if (plistPath) {
		NSDictionary * dict = [NSDictionary dictionaryWithContentsOfFile:plistPath];

		for (NSString * elementId in dict.keyEnumerator) {
			uiElements[elementId] = [INLThemeElement elementWithDictionary:dict[elementId]];
		}
	}
	theme.uiElements = uiElements;
	return theme;
}

@end
