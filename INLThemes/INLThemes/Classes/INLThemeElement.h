//
//  INLThemeElement.h
//
//  Created by Tomas Hakel on 28/01/2016.
//  Copyright © 2016 Inloop. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface INLThemeElement : NSObject

@property (strong, nonatomic) NSDictionary * __nonnull values;

+(instancetype __nonnull)elementWithDictionary:(NSDictionary * __nonnull)dict;

-(NSString * __nullable)valueForKey:(NSString * __nonnull)key;

@end
