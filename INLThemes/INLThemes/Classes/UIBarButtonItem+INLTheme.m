//
//  INLThemedBarButtonItem.m
//
//  Created by Tomas Hakel on 01/02/2016.
//  Copyright © 2016 Inloop. All rights reserved.
//

#import "UIBarButtonItem+INLTheme.h"
#import "UIColor+Hex.h"
#import "INLAssetService.h"

@implementation UIBarItem (INLTheme)

synthesizeElementId

-(void)applyTheme:(INLThemeElement *)theme {

}

@end


@implementation UITabBarItem (INLTheme)

-(void)applyTheme:(INLThemeElement *)theme {

	NSString * title = [theme valueForKey:@"title"];
	if (title) {
		self.title = title;
	}

	NSString * imageSrc = [theme valueForKey:@"image"];
	if (imageSrc) {
		self.selectedImage = [INLAssetService imageNamed:imageSrc];
		self.image = [INLAssetService imageNamed:imageSrc];
	}
}

@end


@implementation UIBarButtonItem (INLTheme)

- (NSNumber *)hasThemeGeneratedCustomView {
	return objc_getAssociatedObject(self, @selector(hasThemeGeneratedCustomView));
}

- (void)setHasThemeGeneratedCustomView:(NSNumber *)hasCustomView {
	objc_setAssociatedObject(self, @selector(hasThemeGeneratedCustomView), hasCustomView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)applyTheme:(INLThemeElement *)theme {
	if ([self.customView conformsToProtocol:@protocol(INLThemedView)]) {
		[((id<INLThemedView>)self.customView) applyTheme:theme];
	}

	NSString * imageSrc = [theme valueForKey:@"image"];
	if (imageSrc) {
		self.image = [INLAssetService imageNamed:imageSrc];
	}

	if (!self.customView || self.hasThemeGeneratedCustomView.boolValue) {
		self.hasThemeGeneratedCustomView = @YES;
		self.image = [INLAssetService imageNamed:imageSrc];

		UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.image.size.width, self.image.size.height)];
		[button addTarget:self.target action:self.action forControlEvents:UIControlEventTouchUpInside];
		[button setImage:[self.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
		self.customView = button;
	}

	NSString * color = [theme valueForKey:@"color"];
	if (color) {
		if ([self.customView respondsToSelector:@selector(imageView)]) {
			[self.customView imageView].tintColor = [UIColor colorWithHex:color];
		}
		else {
			[self.customView setTintColor:[UIColor colorWithHex:color]];
		}
	}
}

@end
