//
//  Theme.h
//
//  Created by Tomas Hakel on 28/01/2016.
//  Copyright © 2016 Inloop. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INLThemeElement.h"

NS_ASSUME_NONNULL_BEGIN

@interface INLTheme : NSObject

@property (strong, nonatomic) NSDictionary<NSString *, INLThemeElement *> * uiElements;

+ (instancetype)themeWithPlist:(NSString * __nonnull)plistName;
+ (instancetype)themeWithJSONData:(NSData * __nonnull)jsonData;
+ (instancetype)themeWithJSONFile:(NSString * __nonnull)jsonName;
+ (instancetype)themeWithJSON:(NSString * __nonnull)json;

@end

NS_ASSUME_NONNULL_END
