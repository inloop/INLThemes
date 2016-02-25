//
//  INLThemeElement.m
//
//  Created by Tomas Hakel on 28/01/2016.
//  Copyright © 2016 Inloop. All rights reserved.
//

#import "INLThemeElement.h"

@implementation INLThemeElement

+(instancetype)elementWithDictionary:(NSDictionary *)dict {
	INLThemeElement * element = [[INLThemeElement alloc] init];
	element.values = dict;
	return element;
}

-(NSString *)valueForKey:(NSString *)key {
	return self.values[key];
}

@end
