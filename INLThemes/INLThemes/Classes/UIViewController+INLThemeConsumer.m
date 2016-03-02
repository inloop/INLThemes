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
	[self collectTabbarThemableViewsInto:themedViews];
	return themedViews;
}

-(void)collectNavbarThemableViewsInto:(NSMutableArray<id<INLThemedView>> *)themedViews {
	if ([self.navigationController.navigationBar isThemable]) {
		[themedViews addObject:self.navigationController.navigationBar];
	}
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
	if ([self.tabBarController.tabBar isThemable]) {
		[themedViews addObject:(id)self.tabBarController.tabBar];
	}
	for (UIViewController * tabVC in self.tabBarController.viewControllers) {
		if ([tabVC.tabBarItem isThemable]) {
			[themedViews addObject:(id)tabVC.tabBarItem];
		}
	}
}

@end


@implementation UIView (INLThemeConsumer)

-(NSArray<id<INLThemedView>> *)themedViews {
	NSMutableArray<id<INLThemedView>> * themedViews = [@[] mutableCopy];
	if ([self isThemable]) {
		[themedViews addObject:(id)self];
	}
	[self collectLayoutConstraintsInto:themedViews];
	[self collectStylableViewsInView:self into:themedViews];
	return themedViews;
}

-(void)collectStylableViewsInView:(UIView *)superview into:(NSMutableArray<id<INLThemedView>> *)themedViews {
	for (UIView * view in superview.subviews) {
		if ([view isThemable]) {
			[themedViews addObject:(id)view];
		}
		[view collectLayoutConstraintsInto:themedViews];
		[self collectStylableViewsInView:view into:themedViews];
	}
}

-(void)collectLayoutConstraintsInto:(NSMutableArray<id<INLThemedView>> *)themedViews {
	for (NSLayoutConstraint * constraint in self.constraints) {
		if ([constraint isThemable]) {
			[themedViews addObject:constraint];
		}
	}
}

@end
