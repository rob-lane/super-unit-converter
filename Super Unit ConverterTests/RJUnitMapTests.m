//
//  RJUnitMapTests.m
//  Super Unit Converter
//
//  Created by Robert Lane on 3/16/14.
//  Copyright (c) 2014 Robert J Lane. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RJUnitMap.h"

@interface RJUnitMapTests : XCTestCase

@property (nonatomic, retain) NSString* sampleUnitMapFile;
@property (nonatomic, retain) RJUnitMap* sampleUnitMap;

@end

@implementation RJUnitMapTests

- (void)setUp
{
    [super setUp];
    self.sampleUnitMapFile = @"sampleUnitmap.plist";
    self.sampleUnitMap = [[RJUnitMap alloc] initWithContentsOfFile:self.sampleUnitMapFile];
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (NSArray*) testUnitMapEntries {
    NSArray *testEntries = [NSArray arrayWithContentsOfFile:self.sampleUnitMapFile];
    return [testEntries sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2];
    }];
}

- (void) testInitWithFileAddsAllEntries {
    for (NSDictionary *mapEntry in [self testUnitMapEntries]) {
        NSString *testName = [mapEntry objectForKey:@"name"];
        RJUnit* unit = [self.sampleUnitMap unitNamed:testName];
        XCTAssertNotNil(unit, @"Init with contents of a file should add a unit "
                              "map entry for each dictionary found in the file.");
    }
}

- (void) testUnitAtIndexReturnsInAlphabeticalOrder {
    NSArray *testUnitMapEntries = [self testUnitMapEntries];
    for (unsigned int i = 0; i < testUnitMapEntries.count; i++) {
        RJUnit *sampleUnit = [self.sampleUnitMap unitAtIndex:i];

        NSString *testUnitName = [[testUnitMapEntries objectAtIndex:i] objectForKey:@"name"];
        RJUnit *testUnit = [self.sampleUnitMap unitNamed:testUnitName];
        XCTAssertEqualObjects(sampleUnit, testUnit, @"Accessing units by index "
                              "should return units in alphabetical order based "
                              "on the specified name");
    }
}

-(void) testLabelAtIndexReturnsInAlphabeticalOrder {
    NSString *previousLabel = nil;
    for (int i = 0; i < [self.sampleUnitMap count]; i++) {
        NSString *currentLabel = [self.sampleUnitMap labelAtIndex:i];
        if (previousLabel == nil) {
            previousLabel = currentLabel;
            continue;
        } else {
            XCTAssertTrue([previousLabel compare:currentLabel] == NSOrderedSame,
                          "Unit labels should be returned in alphabetical order "
                          "based on name of unit");
            previousLabel = currentLabel;
        }
    }
}

-(void) testUnitMapCountReturnsCorrectCount {
    unsigned int testMapCount = [self testUnitMapEntries].count;
    unsigned int sampleMapCount = [self.sampleUnitMap count];
    
    XCTAssertEqual(testMapCount, sampleMapCount, @"Unit map count method should "
                   "return the correct number, expected count: %i, returned: %i",
                   testMapCount, sampleMapCount);
}

-(void) testUnitByNameReturnsCorrectUnit {
    for (NSDictionary *mapEntry in [self testUnitMapEntries]) {
        NSString *testUnitName = [mapEntry objectForKey:@"name"];
        NSNumber *testUnitRatio = [mapEntry objectForKey:@"ratio"];
        RJUnit *testUnit = [self.sampleUnitMap unitNamed:testUnitName];
        XCTAssertEqual(testUnitRatio.doubleValue, testUnit.baseRatio,
                       "Accessing units by name should return the correct unit. "
                       "Expected unit with name %@ to contain ratio: %f.  Unit "
                       "has actual ratio of: %f", testUnitName,
                       testUnitRatio.doubleValue, testUnit.baseRatio);
    }
}

-(void) testUnitRegistrationPersistsUnit {
    double testRatio = 4.5f;
    NSString *testUnitName = @"Test";
    RJUnit *testUnit = [[RJUnit alloc] initWithRatio:testRatio];
    
    [self.sampleUnitMap registerUnit:testUnit withName:testUnitName];
    RJUnit *sampleUnit = [self.sampleUnitMap unitNamed:testUnitName];
    XCTAssertNotNil(sampleUnit, @"Registering a new unit should persist the "
                    "object in the unit map and return it under it's original "
                    "registration name");
    XCTAssertEqualObjects(sampleUnit, testUnit, @"Unit registration should "
                          "persist the object under the correct name and return "
                          "the correct object by name");
}

-(void) testUnitRegistrationPersistsUnitInCorrectOrder {
    NSString *testUnitAName = @"ATest";
    RJUnit *testUnitA = [[RJUnit alloc] initWithRatio:14.5f];
    
    NSString *testUnitBName = @"BTest";
    RJUnit *testUnitB = [[RJUnit alloc] initWithRatio:7.3f];
    
    RJUnitMap *testUnitMap = [[RJUnitMap alloc] init];

    //Explicitly register unit B first
    [testUnitMap registerUnit:testUnitB withName:testUnitBName];
    [testUnitMap registerUnit:testUnitA withName:testUnitAName];

    RJUnit *sampleUnitA = [testUnitMap unitAtIndex:0];
    RJUnit *sampleUnitB = [testUnitMap unitAtIndex:1];
    
    XCTAssertEqualObjects(sampleUnitA, testUnitA, @"Unit registration should "
                          "result in unit access in alphabetical order based on "
                          "registration name");
    XCTAssertEqualObjects(sampleUnitB, testUnitB, @"Unit registration should "
                          "result in unit access in alphabetical order based on "
                          "registration name");
    
}

@end
