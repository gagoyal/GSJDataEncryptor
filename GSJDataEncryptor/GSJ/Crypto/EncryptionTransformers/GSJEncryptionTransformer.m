//
//  GSJEncryptionTransformer.m
//  GSJDataEncryptor
//
//  Created by Gaurav, Seema and Jasvinder on 7/5/14.
//  Copyright (c) 2014 GSJ. All rights reserved.
//

#import "GSJEncryptionTransformer.h"
#import "NSData+AES256.h"

@implementation GSJEncryptionTransformer

- (instancetype)init {
    self = [super init];
    if (self) {
        _key = @"JasvinderSeemaGaurav";
    }

    return self;
}

+ (Class)transformedValueClass {
    return [NSData class];
}

+ (BOOL)allowsReverseTransformation {
    return YES;
}

- (NSString *)key {
    return _key;
}

- (id)transformedValue:(NSData *)data {
    // If there's no key, don't try to transform the data
    if ([self key] == nil || data == nil) return data;

    NSData *iv = nil;
    NSData *salt = nil;
    NSError *err = nil;

    NSData *encryptedData = [data encryptedDataWithPassword:[self key] iv:&iv salt:&salt error:&err];

//    NSLog(@"Iv: %@",iv);
//    NSLog(@"Salt: %@",salt);

    // Prepend IV to the encrypted data
    NSMutableData *mutableData = [NSMutableData dataWithData:iv];
    [mutableData appendData:salt];
    [mutableData appendData:encryptedData];
    return mutableData;
}

- (id)reverseTransformedValue:(NSData *)data {
    // If there's no key, don't try to transform the data
    if ([self key] == nil || data == nil) return data;

    // The IV was stored in the first 128bits of the data
    NSData *iv = [data subdataWithRange:NSMakeRange(0, kCCBlockSizeAES128)];
    NSData *salt = [data subdataWithRange:NSMakeRange(kCCBlockSizeAES128, 8)];

//    NSLog(@"Iv: %@",iv);
//    NSLog(@"Salt: %@",salt);

    // Remove the IV from the encrypted data
    NSMutableData *mutableData = [NSMutableData dataWithData:data];
    [mutableData replaceBytesInRange:NSMakeRange(0, kCCBlockSizeAES128 + 8) withBytes:NULL length:0];

    // Decrypt remaining data
    NSError *err = nil;
    NSData *decrypted = [mutableData decryptedDataWithPassword:[self key] iv:iv salt:salt error:&err];
    return decrypted;
}

@end