//
//  RJUnitMap.h
//  Super Unit Converter
//
//  Created by Robert Lane on 3/14/14.
//  Copyright (c) 2014 Robert J Lane. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RJUnit.h"

@interface RJUnitMap : NSObject  {
    NSMutableDictionary *unitDictionary;
}

-(RJUnit*) unitNamed:(NSString*) name;
-(void) registerUnit:(RJUnit*) unit withName:(NSString*) name;

@end
