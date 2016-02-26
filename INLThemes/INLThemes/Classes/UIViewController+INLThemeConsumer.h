//
//  UIViewController+INLThemeConsumer.h
//
//  Created by Tomas Hakel on 29/01/2016.
//  Copyright © 2016 Inloop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "INLThemeElement.h"
#import "UIView+INLTheme.h"


@protocol INLThemeConsumer<NSObject>

-(NSArray<id<INLThemedView>> * __nonnull)themedViews;

@end


@interface UIViewController (INLThemeConsumer)<INLThemeConsumer>

-(NSArray<id<INLThemedView>> * __nonnull)themedViews;

@end


@interface UIView (INLThemeConsumer)<INLThemeConsumer>

-(NSArray<id<INLThemedView>> * __nonnull)themedViews;

@end
