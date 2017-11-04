//
//  INLThemeElement.h
//
//  Created by Tomas Hakel on 28/01/2016.
//  Copyright © 2016 Inloop. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(ThemeElement)
@interface INLThemeElement : NSObject

@property (strong, nonatomic) NSDictionary * values;

+ (instancetype)elementWithDictionary:(NSDictionary *)dict;

- (NSString *)valueForKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
