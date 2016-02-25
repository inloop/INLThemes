//
//  UIColor+Hex.m
//
//  Created by Tomas Hakel on 29/01/2016.
//  Copyright © 2016 Inloop. All rights reserved.
//

#import "UIColor+Hex.h"

@implementation UIColor (Hex)

+(instancetype)colorWithHex:(NSString *)hexString {
	unsigned rgbValue = 0;
	[[NSScanner scannerWithString:[hexString substringFromIndex:1]] scanHexInt:&rgbValue];

	return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0
						   green:((rgbValue & 0x00FF00) >> 8)/255.0
							blue:(rgbValue & 0x0000FF)/255.0
						   alpha:1.0];
}

@end