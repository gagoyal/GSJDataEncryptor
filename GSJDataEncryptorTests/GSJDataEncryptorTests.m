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

- (void)testTransformersAreRegistered {
    NSValueTransformer *transformer = [NSValueTransformer valueTransformerForName:GSJStringValueTransformer];
    XCTAssertNotNil(transformer, @"String Transformer should not be nil");

    transformer = [NSValueTransformer valueTransformerForName:GSJNumberValueTransformer];
    XCTAssertNotNil(transformer, @"Number Transformer should not be nil");

    transformer = [NSValueTransformer valueTransformerForName:GSJDateValueTransformer];
    XCTAssertNotNil(transformer, @"Date Transformer should not be nil");

    transformer = [NSValueTransformer valueTransformerForName:GSJDataValueTransformer];
    XCTAssertNotNil(transformer, @"Data Transformer should not be nil");
}

- (void)testStrings {
    NSString *value = @"Gaurav, Seema, Jasvinder";
    NSData *transformedValue = [GSJDataEncryptor encryptString:value];
    NSString *revTransformedValue = [GSJDataEncryptor decryptedStringFromData:transformedValue];
    XCTAssertEqualObjects(value, revTransformedValue, @"Failed for String transformer");
}

- (void)testNumbers {
    NSNumber *value = @42;  // equivalent to [NSNumber numberWithInt:42]
    NSData *transformedValue = [GSJDataEncryptor encryptNumber:value];
    NSNumber *revTransformedValue = [GSJDataEncryptor decryptedNumberFromData:transformedValue];
    XCTAssertEqualObjects(value, revTransformedValue, @"Failed for Number 42");

//    value = @42.141592654F;  // equivalent to [NSNumber numberWithFloat:42.141592654F]
//    transformedValue = [GSJDataEncryptor encryptNumber:value];
//    revTransformedValue = [GSJDataEncryptor decryptedNumberFromData:transformedValue];
//    XCTAssertEqualObjects(value, revTransformedValue, @"Failed for Number 42.141592654F");

    value = @42.1415926535;   // equivalent to [NSNumber numberWithDouble:42.1415926535]
    transformedValue = [GSJDataEncryptor encryptNumber:value];
    revTransformedValue = [GSJDataEncryptor decryptedNumberFromData:transformedValue];
    XCTAssertEqualObjects(value, revTransformedValue, @"Failed for Number 42.1415926535");

    value = @42U;    // equivalent to [NSNumber numberWithUnsignedInt:42U]
    transformedValue = [GSJDataEncryptor encryptNumber:value];
    revTransformedValue = [GSJDataEncryptor decryptedNumberFromData:transformedValue];
    XCTAssertEqualObjects(value, revTransformedValue, @"Failed for Number @42U");

    value = @42L;        // equivalent to [NSNumber numberWithLong:42L]
    transformedValue = [GSJDataEncryptor encryptNumber:value];
    revTransformedValue = [GSJDataEncryptor decryptedNumberFromData:transformedValue];
    XCTAssertEqualObjects(value, revTransformedValue, @"Failed for Number @42L");

    value = @42LL;   // equivalent to [NSNumber numberWithLongLong:42LL]
    transformedValue = [GSJDataEncryptor encryptNumber:value];
    revTransformedValue = [GSJDataEncryptor decryptedNumberFromData:transformedValue];
    XCTAssertEqualObjects(value, revTransformedValue, @"Failed for Number @42LL");

    value = @YES;           // equivalent to [NSNumber numberWithBool:YES]
    transformedValue = [GSJDataEncryptor encryptNumber:value];
    revTransformedValue = [GSJDataEncryptor decryptedNumberFromData:transformedValue];
    XCTAssertEqualObjects(value, revTransformedValue, @"Failed for Number YES");

    value = @NO;             // equivalent to [NSNumber numberWithBool:NO]
    transformedValue = [GSJDataEncryptor encryptNumber:value];
    revTransformedValue = [GSJDataEncryptor decryptedNumberFromData:transformedValue];
    XCTAssertEqualObjects(value, revTransformedValue, @"Failed for Number NO");
}

- (void)testDates {
    NSDate *value = [NSDate date];
    NSData *transformedValue = [GSJDataEncryptor encryptDate:value];
    NSDate *revTransformedValue = [GSJDataEncryptor decryptedDateFromData:transformedValue];
    XCTAssertEqualObjects(value, revTransformedValue, @"Failed for Date transformer");
}

- (void)testFiles {
    NSString *filePath = [[[NSBundle bundleForClass:[self class]] bundlePath] stringByAppendingPathComponent:@"Info.plist"];

    NSString *copyFilePath = [[NSString stringWithFormat:@"%@_Copy", [filePath stringByDeletingPathExtension]] stringByAppendingPathExtension:[filePath pathExtension]];

    [[NSFileManager defaultManager] copyItemAtPath:filePath
                                            toPath:copyFilePath
                                             error:nil];

    NSString *encryptedFilePath = [GSJDataEncryptor encryptFileAtPath:filePath shouldOverwriteFile:NO];
    NSString *decryptedFilePath = [GSJDataEncryptor decryptFileAtPath:encryptedFilePath shouldOverwriteFile:NO];

    BOOL areFilesSame = [[NSFileManager defaultManager] contentsEqualAtPath:filePath andPath:decryptedFilePath];
    XCTAssertTrue(areFilesSame, @"Failed for File transformer with shouldOverwriteFile = NO");

    areFilesSame = [[NSFileManager defaultManager] contentsEqualAtPath:encryptedFilePath andPath:filePath];
    XCTAssertFalse(areFilesSame, @"Failed for File transformer with shouldOverwriteFile = NO");

    encryptedFilePath = [GSJDataEncryptor encryptFileAtPath:filePath shouldOverwriteFile:YES];
    areFilesSame = [[NSFileManager defaultManager] contentsEqualAtPath:encryptedFilePath andPath:copyFilePath];
    XCTAssertFalse(areFilesSame, @"Failed for File transformer with shouldOverwriteFile = YES");

    decryptedFilePath = [GSJDataEncryptor decryptFileAtPath:encryptedFilePath shouldOverwriteFile:YES];
    areFilesSame = [[NSFileManager defaultManager] contentsEqualAtPath:copyFilePath andPath:decryptedFilePath];
    XCTAssertTrue(areFilesSame, @"Failed for File transformer with shouldOverwriteFile = YES");
}

@end
