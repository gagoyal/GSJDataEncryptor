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
}

@end
