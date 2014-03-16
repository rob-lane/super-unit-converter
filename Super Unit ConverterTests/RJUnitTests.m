//
//  RJUnitTests.m
//  Super Unit Converter
//
//  Created by Robert Lane on 3/14/14.
//  Copyright (c) 2014 Robert J Lane. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RJUnit.h"

@interface RJUnitTests : XCTestCase

@property double sampleRatio;
@property double sampleConvertValue;
@property (nonatomic, retain) RJUnit* sampleUnit;

@end

@implementation RJUnitTests

- (void)setUp
{
    self.sampleRatio = 3.5;
    self.sampleConvertValue = 5.0;
    self.sampleUnit = [[RJUnit alloc] initWithRatio:self.sampleRatio];
    self.sampleUnit.value = self.sampleConvertValue;
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testRatioFromInitIsPersisted {
    XCTAssertEqual(self.sampleRatio, self.sampleUnit.baseRatio, @"Ratio provieded"
                   @" on init should be persisted in baseRatio property."
                   @" Expected: %f, Actual: %f", self.sampleRatio,
                   self.sampleUnit.baseRatio);
}

- (void)testConvertMutlipliesValueWithBase {
    XCTAssertEqual(self.sampleConvertValue * self.sampleRatio,
                   [self.sampleUnit convert], @"Conversion should return the "
                   @"unit value multiplied by the base ratio");
}

- (void)testUpdateWithBaseValueUpdatesValue {
    [self.sampleUnit updateWithBaseValue:2.0f];
    XCTAssertNotEqual(self.sampleConvertValue, self.sampleUnit.value,
                      @"Updating the units base value should update the value"
                      @" property.");
}

- (void)testUpdateWithBaseValueMultipliesValueByRatioFraction {
    double testUpdatedValue = 2.0f * (1.0f / self.sampleRatio);
    [self.sampleUnit updateWithBaseValue:2.0f];
    XCTAssertEqual(testUpdatedValue, self.sampleUnit.value, @"Updating the units"
                   @" base value should multiply the provided value by 1 / the"
                   @" unit's ratio.  Expected: %f, Actual: %f", testUpdatedValue,
                   self.sampleUnit.value);
}

@end
