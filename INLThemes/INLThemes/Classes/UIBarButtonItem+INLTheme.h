//
//  INLThemedBarButtonItem.h
//
//  Created by Tomas Hakel on 01/02/2016.
//  Copyright © 2016 Inloop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+INLTheme.h"

@interface UIBarItem (INLTheme)<INLThemedView>

@property (nonatomic) IBInspectable NSString * __nonnull elementId;

@end
