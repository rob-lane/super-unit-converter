//
//  RJUnitConverter.h
//  Super Unit Converter
//
//  Created by Robert Lane on 3/10/14.
//  Copyright (c) 2014 Robert J Lane. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RJConversionStrategy.h"

@interface RJUnitConverter : NSObject {
    RJConversionStrategy *currentStrategy;
    NSMutableDictionary *strategyMap;
}

@property (nonatomic, retain) NSNumber* currentValue;
@property (nonatomic, retain) NSString* currentType;

-(id) initWithNumber:(NSNumber*) value;

-(void) registerStrategy:(RJConversionStrategy*) strategy
                withName:(NSString*) name;
-(void) unregisterStrategyWithName:(NSString*) name;
-(RJConversionStrategy*) getStrategyByName:(NSString*) name;

-(NSNumber*) convert;

@end
