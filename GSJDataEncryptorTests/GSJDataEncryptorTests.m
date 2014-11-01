//
//  GSJDataEncryptorTests.m
//  GSJDataEncryptorTests
//
//  Created by Gaurav, Seema and Jasvinder on 7/5/14.
//  Copyright (c) 2014 GSJ. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface GSJDataEncryptorTests : XCTestCase

@end

@implementation GSJDataEncryptorTests

- (void)setUp {
    [super setUp];

    NSLog(@"Setup");
    [GSJDataEncryptor setupEncryptorWithPassword:@"YourPassword"];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    NSLog(@"Tear Down");
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testStrings {
    NSValueTransformer *transformer = [NSValueTransformer valueTransformerForName:GSJStringValueTransformer];
    NSString *value = @"Gaurav, Seema, Jasvinder";
    NSData *transformedValue = [transformer transformedValue:value];
    NSString *revTransformedValue = [transformer reverseTransformedValue:transformedValue];

    XCTAssertEqualObjects(value, revTransformedValue, @"Failed for String transformer");
}

- (void)testNumbers {
    NSValueTransformer *transformer = [NSValueTransformer valueTransformerForName:GSJNumberValueTransformer];

    NSNumber *value = @42;  // equivalent to [NSNumber numberWithInt:42]
    NSData *transformedValue = [transformer transformedValue:value];
    NSNumber *revTransformedValue = [transformer reverseTransformedValue:transformedValue];
    XCTAssertEqualObjects(value, revTransformedValue, @"Failed for Number 42");

//    value = @42.141592654F;  // equivalent to [NSNumber numberWithFloat:42.141592654F]
//    transformedValue = [transformer transformedValue:value];
//    revTransformedValue = [transformer reverseTransformedValue:transformedValue];
//    XCTAssertEqualObjects(value, revTransformedValue, @"Failed for Number 42.141592654F");

    value = @42.1415926535;   // equivalent to [NSNumber numberWithDouble:42.1415926535]
    transformedValue = [transformer transformedValue:value];
    revTransformedValue = [transformer reverseTransformedValue:transformedValue];
    XCTAssertEqualObjects(value, revTransformedValue, @"Failed for Number 42.1415926535");

    value = @42U;    // equivalent to [NSNumber numberWithUnsignedInt:42U]
    transformedValue = [transformer transformedValue:value];
    revTransformedValue = [transformer reverseTransformedValue:transformedValue];
    XCTAssertEqualObjects(value, revTransformedValue, @"Failed for Number @42U");

    value = @42L;        // equivalent to [NSNumber numberWithLong:42L]
    transformedValue = [transformer transformedValue:value];
    revTransformedValue = [transformer reverseTransformedValue:transformedValue];
    XCTAssertEqualObjects(value, revTransformedValue, @"Failed for Number @42L");

    value = @42LL;   // equivalent to [NSNumber numberWithLongLong:42LL]
    transformedValue = [transformer transformedValue:value];
    revTransformedValue = [transformer reverseTransformedValue:transformedValue];
    XCTAssertEqualObjects(value, revTransformedValue, @"Failed for Number @42LL");

    value = @YES;           // equivalent to [NSNumber numberWithBool:YES]
    transformedValue = [transformer transformedValue:value];
    revTransformedValue = [transformer reverseTransformedValue:transformedValue];
    XCTAssertEqualObjects(value, revTransformedValue, @"Failed for Number YES");

    value = @NO;             // equivalent to [NSNumber numberWithBool:NO]
    transformedValue = [transformer transformedValue:value];
    revTransformedValue = [transformer reverseTransformedValue:transformedValue];
    XCTAssertEqualObjects(value, revTransformedValue, @"Failed for Number NO");
}

- (void)testDates {
    NSValueTransformer *transformer = [NSValueTransformer valueTransformerForName:GSJDateValueTransformer];
    NSDate *value = [NSDate date];
    NSData *transformedValue = [transformer transformedValue:value];
    NSDate *revTransformedValue = [transformer reverseTransformedValue:transformedValue];
    XCTAssertNotNil(transformer, @"Transformer should not be nil");
    XCTAssertEqualObjects(value, revTransformedValue, @"Failed for String transformer");
}

@end
