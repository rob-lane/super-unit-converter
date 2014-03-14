//
//  RJUnit.m
//  Super Unit Converter
//
//  Created by Robert Lane on 3/14/14.
//  Copyright (c) 2014 Robert J Lane. All rights reserved.
//

#import "RJUnit.h"

@implementation RJUnit

-(id) initWithRatio:(double)ratio {
    self = [super init];
    
    if (self) {
        self.baseRatio = ratio;
        self.value = 0.0f;
    }
    
    return self;
}

-(double) convert {
    return (self.value * (self.baseRatio));
}

-(void) updateWithBaseValue:(double)baseValue {
    self.value = (baseValue * (1.0f / self.baseRatio));
}

@end
