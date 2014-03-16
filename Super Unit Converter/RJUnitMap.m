//
//  RJUnitMap.m
//  Super Unit Converter
//
//  Created by Robert Lane on 3/14/14.
//  Copyright (c) 2014 Robert J Lane. All rights reserved.
//

#import "RJUnitMap.h"

@interface RJUnitMap ()

-(void) _sortUnitLabels;

@end

@implementation RJUnitMap

-(id) init {
    self = [super init];
    
    if (self) {
        unitDictionary = [[NSMutableDictionary alloc] init];
        unitLabels = [[NSMutableOrderedSet alloc] init];
    }
    
    return self;
}

-(id) initWithContentsOfFile:(NSString *)path {
    self = [super init];
    
    if (self) {
        unitDictionary = [[NSMutableDictionary alloc] init];
        NSArray *unitDefinitionSet = [NSArray arrayWithContentsOfFile:path];
        for (NSDictionary *unitMapEntry in unitDefinitionSet) {
            //Get ratio property for new property as a double
            double ratio = ((NSNumber*)[unitMapEntry
                                        objectForKey:@"ratio"]).doubleValue;
            //create and register unit
            RJUnit *newUnit = [[RJUnit alloc] initWithRatio:ratio];
            [self registerUnit:newUnit withName:[unitMapEntry
                                                 objectForKey:@"name"]];
        }
    }
    
    return self;
}

-(RJUnit*) unitAtIndex:(unsigned int)index {
    return [self unitNamed:[self labelAtIndex:index]];
}

-(NSString*) labelAtIndex:(unsigned int)index {
    return [unitLabels objectAtIndex:index];
}

-(unsigned int) count {
    return [unitLabels count];
}

-(RJUnit*) unitNamed:(NSString *)name {
    return [unitDictionary objectForKey:name];
}

-(void) registerUnit:(RJUnit *)unit withName:(NSString *)name {
    [unitDictionary setObject:unit forKey:name];
    if ( [unitLabels containsObject:name] == NO) {
        [unitLabels addObject:name];
        [self _sortUnitLabels];
    }
}

-(void) _sortUnitLabels {
    [unitLabels sortUsingComparator: ^NSComparisonResult(id label1, id label2) {
        return [label1 compare:label2];
    }];
}


@end
