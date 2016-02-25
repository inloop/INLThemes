//
//  Theme.h
//
//  Created by Tomas Hakel on 28/01/2016.
//  Copyright © 2016 Inloop. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INLThemeElement.h"

@interface INLTheme : NSObject

@property (strong, nonatomic) NSDictionary<NSString *, INLThemeElement *> * uiElements;

+(instancetype)themeWithPlist:(NSString *)plistName;
// TODO: themeWithJSON

@end
