//
//  UIViewController+INLThemeConsumer.m
//
//  Created by Tomas Hakel on 29/01/2016.
//  Copyright © 2016 Inloop. All rights reserved.
//

#import "UIViewController+INLThemeConsumer.h"


@implementation UIViewController (INLThemeConsumer)

-(NSArray<id<INLThemedView>> *)themedViews {
	NSMutableArray<id<INLThemedView>> * themedViews = [[self.view themedViews] mutableCopy];
	[self collectNavbarThemableViewsInto:themedViews];
	return themedViews;
}

-(void)collectNavbarThemableViewsInto:(NSMutableArray<id<INLThemedView>> *)themedViews {
	if ([self.navigationItem.titleView isThemable]) {
		[themedViews addObject:(id)self.navigationItem.titleView];
	}
	NSArray * barButtonItems = [self.navigationItem.leftBarButtonItems arrayByAddingObjectsFromArray:
								self.navigationItem.rightBarButtonItems];
	for (UIBarButtonItem * item in barButtonItems) {
		if (item.isThemable) {
			[themedViews addObject:(id)item];
		}
	}
}

-(void)collectTabbarThemableViewsInto:(NSMutableArray<id<INLThemedView>> *)themedViews {

	// TODO: style tabbar
}

@end


@implementation UIView (INLThemeConsumer)

-(NSArray<id<INLThemedView>> *)themedViews {
	NSMutableArray<id<INLThemedView>> * themedViews = [@[] mutableCopy];
	if ([self isThemable]) {
		[themedViews addObject:(id)self];
	}
	[self collectStylableViewsInView:self into:themedViews];
	return themedViews;
}

-(void)collectStylableViewsInView:(UIView *)superview into:(NSMutableArray<id<INLThemedView>> *)themedViews {
	for (UIView * view in superview.subviews) {
		if ([view isThemable]) {
			[themedViews addObject:(id)view];
		}
		[self collectStylableViewsInView:view into:themedViews];
	}
}

@end
