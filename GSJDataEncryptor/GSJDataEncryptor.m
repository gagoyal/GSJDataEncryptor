//
//  GSJDataEncryptor.m
//  GSJDataEncryptor
//
//  Created by Gaurav, Seema and Jasvinder on 7/5/14.
//  Copyright (c) 2014 GSJ. All rights reserved.
//

#import "GSJDataEncryptor.h"
#import "GSJStringEncryptionTransformer.h"
#import "GSJNumberEncryptionTransformer.h"
#import "GSJDateEncryptionTransformer.h"

NSString *const GSJStringValueTransformer = @"GSJStringValueTransformer";
NSString *const GSJNumberValueTransformer = @"GSJNumberValueTransformer";
NSString *const GSJDateValueTransformer = @"GSJDateValueTransformer";
NSString *const GSJDataValueTransformer = @"GSJDataValueTransformer";

@implementation GSJDataEncryptor

+ (void)setupEncryptorWithPassword:(NSString *)password {
    GSJEncryptionTransformer *transformer = [GSJStringEncryptionTransformer new];
    transformer.key = password;
    [NSValueTransformer setValueTransformer:transformer
                                    forName:GSJStringValueTransformer];

    transformer = [GSJNumberEncryptionTransformer new];
    transformer.key = password;
    [NSValueTransformer setValueTransformer:transformer
                                    forName:GSJNumberValueTransformer];

    transformer = [GSJDateEncryptionTransformer new];
    transformer.key = password;
    [NSValueTransformer setValueTransformer:transformer
                                    forName:GSJDateValueTransformer];

    transformer = [GSJEncryptionTransformer new];
    transformer.key = password;
    [NSValueTransformer setValueTransformer:transformer
                                    forName:GSJDataValueTransformer];
}

+ (NSData *)encryptString:(NSString *)aString {
    NSValueTransformer *transformer = [NSValueTransformer valueTransformerForName:GSJStringValueTransformer];
    NSData *transformedValue = [transformer transformedValue:aString];

    return transformedValue;
}

+ (NSString *)decryptedStringFromData:(NSData *)aData {
    NSValueTransformer *transformer = [NSValueTransformer valueTransformerForName:GSJStringValueTransformer];
    NSString *revTransformedValue = [transformer reverseTransformedValue:aData];

    return revTransformedValue;
}

+ (NSData *)encryptNumber:(NSNumber *)aNumber {
    NSValueTransformer *transformer = [NSValueTransformer valueTransformerForName:GSJNumberValueTransformer];
    NSData *transformedValue = [transformer transformedValue:aNumber];

    return transformedValue;
}

+ (NSNumber *)decryptedNumberFromData:(NSData *)aData {
    NSValueTransformer *transformer = [NSValueTransformer valueTransformerForName:GSJNumberValueTransformer];
    NSNumber *revTransformedValue = [transformer reverseTransformedValue:aData];

    return revTransformedValue;
}

+ (NSData *)encryptDate:(NSDate *)aDate {
    NSValueTransformer *transformer = [NSValueTransformer valueTransformerForName:GSJDateValueTransformer];
    NSData *transformedValue = [transformer transformedValue:aDate];

    return transformedValue;
}

+ (NSDate *)decryptedDateFromData:(NSData *)aData {
    NSValueTransformer *transformer = [NSValueTransformer valueTransformerForName:GSJDateValueTransformer];
    NSDate *revTransformedValue = [transformer reverseTransformedValue:aData];

    return revTransformedValue;
}

+ (NSData *)encryptData:(NSData *)aData {
    NSValueTransformer *transformer = [NSValueTransformer valueTransformerForName:GSJDataValueTransformer];
    NSData *transformedValue = [transformer transformedValue:aData];

    return transformedValue;
}

+ (NSData *)decryptedDataFromData:(NSData *)aData {
    NSValueTransformer *transformer = [NSValueTransformer valueTransformerForName:GSJDataValueTransformer];
    NSData *revTransformedValue = [transformer reverseTransformedValue:aData];

    return revTransformedValue;
}

//will check for file existance
//wil return nil in case encryppted file is not created
//Tilde are expanded internally.

+ (NSString *)encryptFileAtPath:(NSString *)filePath shouldOverwriteFile:(BOOL)flag {
    NSString *absFilePath = [filePath stringByExpandingTildeInPath];
    if (absFilePath && ![[NSFileManager defaultManager] fileExistsAtPath:absFilePath]) {
        return nil;
    }

    NSData *data = [NSData dataWithContentsOfFile:absFilePath];
    data = [GSJDataEncryptor encryptData:data];

    NSString *transformedFilePath;
    if (flag) {
        transformedFilePath = [absFilePath copy];
    }
    else {
        transformedFilePath = [[NSString stringWithFormat:@"%@_Encrypted", [absFilePath stringByDeletingPathExtension]] stringByAppendingPathExtension:[absFilePath pathExtension]];
    }

    [[NSFileManager defaultManager] removeItemAtPath:transformedFilePath error:nil];
    [data writeToFile:transformedFilePath atomically:YES];

    return transformedFilePath;
}

+ (NSString *)decryptFileAtPath:(NSString *)filePath shouldOverwriteFile:(BOOL)flag {
    NSString *absFilePath = [filePath stringByExpandingTildeInPath];
    if (absFilePath && ![[NSFileManager defaultManager] fileExistsAtPath:absFilePath]) {
        return nil;
    }

    NSData *data = [NSData dataWithContentsOfFile:absFilePath];
    data = [GSJDataEncryptor decryptedDataFromData:data];

    NSString *revTransformedFilePath;
    if (flag) {
        revTransformedFilePath = [absFilePath copy];
    }
    else {
        revTransformedFilePath = [[NSString stringWithFormat:@"%@_Decrypted", [absFilePath stringByDeletingPathExtension]] stringByAppendingPathExtension:[absFilePath pathExtension]];
    }

    [[NSFileManager defaultManager] removeItemAtPath:revTransformedFilePath error:nil];
    [data writeToFile:revTransformedFilePath atomically:YES];

    return revTransformedFilePath;
}

@end
