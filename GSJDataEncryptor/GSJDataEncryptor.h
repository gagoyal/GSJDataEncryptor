//
//  GSJDataEncryptor.h
//  GSJDataEncryptor
//
//  Created by Gaurav, Seema and Jasvinder on 7/5/14.
//  Copyright (c) 2014 GSJ. All rights reserved.
//

/** Documentation

 Link your target with security.framework

 In appDelegate.m add method:
 + (void) initialize
 {
        [GSJDataEncryptor setupEncryptorWithPassword:@"YourPassword"];
 }

 In your CoreDataModel, specify the following keys in Transformer Value Name:
 -For String                                        : GSJStringValueTransformer
 -For Float/Int/Bool/Signed/Unsigned/Any NSNumber   : GSJNumberValueTransformer
 -For Date                                          : GSJDateValueTransformer

 **/

#import <Foundation/Foundation.h>

extern NSString *const GSJStringValueTransformer;
extern NSString *const GSJNumberValueTransformer;
extern NSString *const GSJDateValueTransformer;

@interface GSJDataEncryptor : NSObject

+ (void)setupEncryptorWithPassword:(NSString *)password;

@end
