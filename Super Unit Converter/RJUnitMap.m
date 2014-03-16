//
//  RJUnitMap.m
//  Super Unit Converter
//
//  Created by Robert Lane on 3/14/14.
//  Copyright (c) 2014 Robert J Lane. All rights reserved.
//

#import "RJUnitMap.h"

@implementation RJUnitMap

-(id) init {
    self = [super init];
    
    if (self) {
        unitDictionary = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

-(RJUnit*) unitNamed:(NSString *)name {
    return [unitDictionary objectForKey:name];
}

-(void) registerUnit:(RJUnit *)unit withName:(NSString *)name {
    [unitDictionary setObject:unit forKey:name];
}


@end
