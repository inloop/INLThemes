//
//  INLThemeProvider.h
//
//  Created by Tomas Hakel on 28/01/2016.
//  Copyright © 2016 Inloop. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INLTheme.h"
#import "UIViewController+INLThemeConsumer.h"
#import "UIView+INLTheme.h"
#import "UIBarButtonItem+INLTheme.h"

@interface INLThemeService : NSObject

+(instancetype)sharedService;

+(void)registerThemeConsumer:(id<INLThemeConsumer>)themeConsumer;
+(void)removeThemeConsumer:(id<INLThemeConsumer>)themeConsumer;

+(void)applyTheme:(INLTheme *)theme;
+(void)applyTheme:(INLTheme *)theme to:(id<INLThemeConsumer>)themeConsumer;

@end
