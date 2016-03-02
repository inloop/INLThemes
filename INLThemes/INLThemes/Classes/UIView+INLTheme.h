//
//  INLThemedView.h
//
//  Created by Tomas Hakel on 01/02/2016.
//  Copyright © 2016 Inloop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "INLThemeElement.h"


@protocol INLThemedView <NSObject>

@property (nonatomic) NSString * __nonnull elementId;

-(void)applyTheme:(INLThemeElement * __nonnull)theme;

@end


@interface UIView (INLTheme)<INLThemedView>

@property (nonatomic) IBInspectable NSString * __nonnull elementId;

@end


@interface NSObject (INLThemable)

-(BOOL)isThemable;

@end


@interface NSLayoutConstraint (INLTheme)<INLThemedView>

@property (nonatomic) IBInspectable NSString * __nonnull elementId;

@end


#define synthesizeElementId \
	- (NSString *)elementId { \
		return objc_getAssociatedObject(self, @selector(elementId)); \
	} \
	- (void)setElementId:(NSString *)elementId { \
		objc_setAssociatedObject(self, @selector(elementId), elementId, OBJC_ASSOCIATION_RETAIN_NONATOMIC); \
	}