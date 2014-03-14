//
//  RJUnitConverter.m
//  Super Unit Converter
//
//  Created by Robert Lane on 3/10/14.
//  Copyright (c) 2014 Robert J Lane. All rights reserved.
//

#import "RJUnitConverter.h"

@implementation RJUnitConverter

-(id) init {
    self = [super init];
    
    if (self) {
        self.currentValue = @0;
        currentStrategy = nil;
        strategyMap = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

-(id) initWithNumber:(NSNumber *)value {
    self = [super init];
    
    if (self) {
        self.currentValue = value;
        currentStrategy = nil;
        strategyMap = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

-(void) setCurrentType:(NSString *)currentType {
    if ([self.currentType compare:currentType] != NSOrderedSame) {
        self.currentType = [NSString stringWithString:currentType];
        RJConversionStrategy *strategy = [strategyMap objectForKey:currentType];
        if (strategy != nil) {
            currentStrategy = strategy;
        }
    }
}
    
-(void) registerStrategy:(RJConversionStrategy*) strategy withName:(NSString*) name {
    [strategyMap setObject:strategy forKey:name];
}

-(void) unregisterStrategyWithName:(NSString *)name {
    [strategyMap removeObjectForKey:name];
}

-(RJConversionStrategy*) getStrategyByName:(NSString *)name {
    return (RJConversionStrategy*)[strategyMap objectForKey:name];
}

-(NSNumber*) convert {
    NSNumber* result = [NSNumber numberWithDouble:
                        [currentStrategy convert:self.currentValue.doubleValue]];
    if (result != nil) {
        return result;
    } else {
        return nil;
    }
}

@end
