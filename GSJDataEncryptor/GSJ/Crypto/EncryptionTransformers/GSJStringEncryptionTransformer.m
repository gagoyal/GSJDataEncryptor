//
//  GSJStringEncryptionTransformer.m
//  GSJDataEncryptor
//
//  Created by Gaurav, Seema and Jasvinder on 7/5/14.
//  Copyright (c) 2014 GSJ. All rights reserved.
//

#import "GSJStringEncryptionTransformer.h"

@implementation GSJStringEncryptionTransformer
+ (Class)transformedValueClass {
    return [NSString class];
}

- (NSData *)transformedValue:(NSString *)string {
    NSData *data = [string dataUsingEncoding:NSASCIIStringEncoding];
    data = [super transformedValue:data];
    return data;
}

- (NSString *)reverseTransformedValue:(NSData *)data {
    if (nil == data) return nil;

    data = [super reverseTransformedValue:data];
    NSString *final = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    return final;
}

@end
