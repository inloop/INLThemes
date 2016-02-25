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
}

@end


@implementation UIButton (INLTheme)

-(void)applyTheme:(INLThemeElement *)theme {
	NSString * color = [theme valueForKey:@"color"];
	if (color) {
		self.imageView.tintColor = [UIColor colorWithHex:color];
	}
	NSString * backgroundColor = [theme valueForKey:@"backgroundColor"];
	if (backgroundColor) {
		self.backgroundColor = [UIColor colorWithHex:backgroundColor];
	}
	NSString * textColor = [theme valueForKey:@"textColor"];
	if (textColor) {
		[self setTitleColor:[UIColor colorWithHex:textColor] forState:UIControlStateNormal];
	}
	NSString * text = [theme valueForKey:@"text"];
	if (text) {
		[self setTitle:text forState:UIControlStateNormal];
	}
	NSString * image = [theme valueForKey:@"image"];
	if (image) {
		[self setImage:[INLAssetService imageNamed:image] forState:UIControlStateNormal];
	}
}

@end


@implementation UIImageView (INLTheme)

-(void)applyTheme:(INLThemeElement *)theme {
	NSString * backgroundColor = [theme valueForKey:@"backgroundColor"];
	if (backgroundColor) {
		self.backgroundColor = [UIColor colorWithHex:backgroundColor];
	}
	self.image = [INLAssetService imageNamed:[theme valueForKey:@"image"]];
}

@end


@implementation UILabel (INLTheme)

-(void)applyTheme:(INLThemeElement *)theme {
	NSString * textColor = [theme valueForKey:@"textColor"];
	if (textColor) {
		self.textColor = [UIColor colorWithHex:textColor];
	}
	NSString * text = [theme valueForKey:@"text"];
	if (text) {
		self.text = text;
	}
}

@end


@implementation UIPageControl (INLTheme)

-(void)applyTheme:(INLThemeElement *)theme {
	NSString * color = [theme valueForKey:@"color"];
	if (color) {
		self.currentPageIndicatorTintColor = [UIColor colorWithHex:color];
	}
	NSString * inactiveColor = [theme valueForKey:@"inactiveColor"];
	if (inactiveColor) {
		self.pageIndicatorTintColor = [UIColor colorWithHex:inactiveColor];
	}
}

@end


@implementation UITextField (INLTheme)

-(void)applyTheme:(INLThemeElement *)theme {
	NSString * textColor = [theme valueForKey:@"textColor"];
	if (textColor) {
		self.textColor = [UIColor colorWithHex:textColor];
	}
	NSString * inactiveColor = [theme valueForKey:@"inactiveColor"];
	if (inactiveColor) {
		self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHex:inactiveColor]}];
	}
}

@end


@implementation UITextView (INLTheme)

-(void)applyTheme:(INLThemeElement *)theme {
	NSString * textColor = [theme valueForKey:@"textColor"];
	if (textColor) {
		self.textColor = [UIColor colorWithHex:textColor];
	}
}

@end


@implementation NSObject (INLThemable)

-(BOOL)isThemable {
	return [self conformsToProtocol:@protocol(INLThemedView)];
}

@end
