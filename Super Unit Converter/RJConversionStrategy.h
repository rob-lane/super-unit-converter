//
//  RJConversionStrategy.h
//  Super Unit Converter
//
//  Created by Robert Lane on 3/12/14.
//  Copyright (c) 2014 Robert J Lane. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RJConversionStrategy : NSObject

-(double) convert:(double) value;
-(double) reverseConvert:(double) value;

@end
