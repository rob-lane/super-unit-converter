//
//  RJUnitConverterTests.m
//  Super Unit Converter
//
//  Created by Robert Lane on 3/10/14.
//  Copyright (c) 2014 Robert J Lane. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RJUnitConverter.h"
#import "RJConversionStrategy.h"

@interface RJUnitConverterTests : XCTestCase {
    RJUnitConverter *defaultConverter;
    RJUnitConverter *sampleConverter;
    RJConversionStrategy *sampleStrategy;
    NSString *sampleStrategyName;
}

@property (nonatomic) NSNumber* testWholeNumber;

@end

@implementation RJUnitConverterTests

- (void)setUp
{
    [super setUp];
    self.testWholeNumber = @15;
    defaultConverter = [[RJUnitConverter alloc] init];
    sampleStrategy = [[RJConversionStrategy alloc] init];
    sampleStrategyName = @"sampleStrategy";
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testInitWithNumberPersistsNumber {
    sampleConverter = [[RJUnitConverter alloc]
                       initWithNumber:self.testWholeNumber];
    XCTAssertEqual(sampleConverter.currentValue, self.testWholeNumber,
                   @"The number provided to the initializer should persist in "
                   "the converters currentValue property.");
}

- (void)testInitWithoutNumberDefaultsToZero {
    XCTAssertEqual(defaultConverter.currentValue, @0, @"Initialized without a value "
                   "should default the currentvalue property to zero");
}

- (void)testRegisterStrategyPersistsStrategy {
    [defaultConverter registerStrategy:sampleStrategy withName:sampleStrategyName];
    XCTAssertEqualObjects(sampleStrategy,
                          [defaultConverter getStrategyByName:sampleStrategyName],
                          @"Registered strategy should persist by provided name");
}

- (void)testUnregisterStrategyRemovesStrategy {
    [defaultConverter registerStrategy:sampleStrategy withName:sampleStrategyName];
    [defaultConverter unregisterStrategyWithName:sampleStrategyName];
    XCTAssertNil([defaultConverter getStrategyByName:sampleStrategyName],
                 @"Unregistered stategies should not persist in the converter");
}

- (void)testConvertWithSampleStrategyReturnsValue {
    [sampleConverter registerStrategy:sampleStrategy withName:sampleStrategyName];
    XCTAssertEqual(sampleConverter.currentValue, [sampleConverter convert],
                   @"The default strategy should return the converters current value");
}



@end
