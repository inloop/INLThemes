//
//  INLThemedView.m
//
//  Created by Tomas Hakel on 01/02/2016.
//  Copyright © 2016 Inloop. All rights reserved.
//

#import "UIView+INLTheme.h"
#import "INLAssetService.h"
#import "UIColor+Hex.h"
#import "UIViewController+INLThemeConsumer.h"


@implementation UIView (INLTheme)

synthesizeElementId

-(void)applyTheme:(INLThemeElement *)theme {
	NSString * backgroundColorHex = [theme valueForKey:@"backgroundColor"];
	if (backgroundColorHex) {
		self.backgroundColor = [UIColor colorWithHex:backgroundColorHex];
	}

	NSString * tintColorHex = [theme valueForKey:@"tintColor"];
	if (tintColorHex) {
		self.tintColor = [UIColor colorWithHex:tintColorHex];
	}

	NSNumber * hidden = theme.values[@"hidden"];
	if (hidden) {
		self.hidden = [hidden boolValue];
	}

	NSNumber * alpha = theme.values[@"alpha"];
	if (alpha) {
		self.alpha = [hidden boolValue];
	}

	NSNumber * cornerRadius = theme.values[@"cornerRadius"];
	if (cornerRadius) {
		self.layer.cornerRadius = [cornerRadius floatValue];
	}
}

@end


@implementation NSObject (INLThemable)

-(BOOL)isThemable {
	return [self conformsToProtocol:@protocol(INLThemedView)];
}

@end
