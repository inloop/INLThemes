//
//  INLThemeProvider.m
//
//  Created by Tomas Hakel on 28/01/2016.
//  Copyright © 2016 Inloop. All rights reserved.
//

#import "INLThemeService.h"
#import "INLAssetService.h"
#import "UIViewController+INLThemeConsumer.h"


@interface INLThemeService ()

@property (strong, nonatomic) INLTheme * currentTheme;
@property (strong, nonatomic) NSMutableArray<id<INLThemeConsumer>> * themeConsumers;

@end


@implementation INLThemeService

+(instancetype)sharedService {
	static INLThemeService * sharedService = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedService = [[INLThemeService alloc] init];
		sharedService.themeConsumers = [@[] mutableCopy];
	});
	return sharedService;
}

#pragma mark - Register theme consumer

-(void)registerThemeConsumer:(id<INLThemeConsumer>)themeConsumer {
	[self.themeConsumers addObject:themeConsumer];
	[self applyTheme:self.currentTheme to:themeConsumer];
}

-(void)removeThemeConsumer:(id<INLThemeConsumer>)themeConsumer {
	[self.themeConsumers removeObject:themeConsumer];
}

#pragma mark - Apply theme

-(void)applyTheme:(INLTheme *)theme {
	self.currentTheme = theme;
	for (id<INLThemeConsumer> themeConsumer in self.themeConsumers) {
		[self applyTheme:theme to:themeConsumer];
	}
}

-(void)applyTheme:(INLTheme *)theme to:(id<INLThemeConsumer>)themeConsumer {
	[self applyTheme:theme toViews:[themeConsumer themedViews]];
}

-(void)applyTheme:(INLTheme *)theme toViews:(NSArray<id<INLThemedView>> *)themedViews {
	for (id<INLThemedView> view in themedViews) {
		INLThemeElement * themeElement = theme.uiElements[view.elementId];
		if (themeElement) {
			[view applyTheme:themeElement];
		}
	}
}

#pragma mark - Convinience

+(void)registerThemeConsumer:(id<INLThemeConsumer>)themeConsumer {
	[[INLThemeService sharedService] registerThemeConsumer:themeConsumer];
}

+(void)removeThemeConsumer:(id<INLThemeConsumer>)themeConsumer {
	[[INLThemeService sharedService] removeThemeConsumer:themeConsumer];
}

+(void)applyTheme:(INLTheme *)theme {
	[[INLThemeService sharedService] applyTheme:theme];
}

+(void)applyTheme:(INLTheme *)theme to:(id<INLThemeConsumer>)themeConsumer {
	[[INLThemeService sharedService] applyTheme:theme to:themeConsumer];
}

@end
