//
//  Theme.h
//
//  Created by Tomas Hakel on 28/01/2016.
//  Copyright © 2016 Inloop. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INLThemeElement.h"

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(Theme)
@interface INLTheme : NSObject

@property (strong, nonatomic) NSDictionary<NSString *, INLThemeElement *> * uiElements;

+ (instancetype)themeWithPlist:(NSString *)plistName;
+ (instancetype)themeWithJSONData:(NSData *)jsonData;
+ (instancetype)themeWithJSONFile:(NSString *)jsonName;
+ (instancetype)themeWithJSON:(NSString *)json;

@end

NS_ASSUME_NONNULL_END
