//
//  RJUnit.h
//  Super Unit Converter
//
//  Created by Robert Lane on 3/14/14.
//  Copyright (c) 2014 Robert J Lane. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RJUnit : NSObject

@property double baseRatio;
@property double value;

-(id) initWithRatio:(double) ratio;

-(double) convert;
-(void) updateWithBaseValue:(double) baseValue;

@end
