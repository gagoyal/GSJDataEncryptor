//
//  NSStringEncryptionTransformer.m
//  GSJDataEncryptor
//
//  Created by Gaurav, Seema and Jasvinder on 7/5/14.
//  Copyright (c) 2014 GSJ. All rights reserved.
//

#import "GSJDateEncryptionTransformer.h"

@implementation GSJDateEncryptionTransformer
+ (Class)transformedValueClass {
    return [NSDate class];
}

- (NSData *)transformedValue:(NSDate *)dateValue {
    NSData *data = [super transformedValue:@([dateValue timeIntervalSinceReferenceDate])];
    return data;
}

- (NSDate *)reverseTransformedValue:(NSData *)data {
    if (nil == data) return nil;
    NSNumber *transformedValue = [super reverseTransformedValue:data];
    NSDate *finalValue = [NSDate dateWithTimeIntervalSinceReferenceDate:[transformedValue doubleValue]];

    return finalValue;
}

@end
