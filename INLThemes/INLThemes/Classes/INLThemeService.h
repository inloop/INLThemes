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

+(instancetype __nonnull)sharedService;

+(void)registerThemeConsumer:(id<INLThemeConsumer> __nonnull)themeConsumer;
+(void)removeThemeConsumer:(id<INLThemeConsumer> __nonnull)themeConsumer;

+(void)applyTheme:(INLTheme * __nonnull)theme;
+(void)applyTheme:(INLTheme * __nonnull)theme to:(id<INLThemeConsumer> __nonnull)themeConsumer;

@end
