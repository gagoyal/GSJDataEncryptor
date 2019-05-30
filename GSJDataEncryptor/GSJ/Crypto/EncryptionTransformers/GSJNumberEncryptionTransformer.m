//
//  GSJNumberEncryptionTransformer.m
//  GSJDataEncryptor
//
//  Created by Gaurav, Seema and Jasvinder on 7/5/14.
//  Copyright (c) 2014 GSJ. All rights reserved.
//

#import "GSJNumberEncryptionTransformer.h"

@implementation GSJNumberEncryptionTransformer
+ (Class)transformedValueClass {
    return [NSNumber class];
}

- (NSData *)transformedValue:(NSNumber *)numberValue {
    NSData *data = [super transformedValue:[numberValue description]];
    return data;
}

- (NSNumber *)reverseTransformedValue:(NSData *)data {
    if (nil == data) return nil;

    NSString *finalString = [super reverseTransformedValue:data];

    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *finalValue = [numberFormatter numberFromString:finalString];

    return finalValue;
}

@end
