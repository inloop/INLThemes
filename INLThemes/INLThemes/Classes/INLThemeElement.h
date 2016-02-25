//
//  INLThemeElement.h
//
//  Created by Tomas Hakel on 28/01/2016.
//  Copyright © 2016 Inloop. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface INLThemeElement : NSObject

@property (strong, nonatomic) NSDictionary * values;

+(instancetype)elementWithDictionary:(NSDictionary *)dict;

-(NSString *)valueForKey:(NSString *)key;

@end
