//
//  GSJDataEncryptor.h
//  GSJDataEncryptor
//
//  Created by Gaurav, Seema and Jasvinder on 7/5/14.
//  Copyright (c) 2014 GSJ. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for GSJDataEncryptor.
FOUNDATION_EXPORT double GSJDataEncryptorVersionNumber;

//! Project version string for GSJDataEncryptor.
FOUNDATION_EXPORT const unsigned char GSJDataEncryptorVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <GSJDataEncryptor/PublicHeader.h>

/** Documentation

 Link your target with security.framework

 In appDelegate.m add method:
 + (void) initialize
 {
        [GSJDataEncryptor setupEncryptorWithPassword:@"YourPassword"];
 }

 In your CoreDataModel, specify the following keys in Transformer Value Name:
 -For NSString                                        : GSJStringValueTransformer
 -For NSNumber (Float/Int/Bool/Signed/Unsigned/Any)   : GSJNumberValueTransformer
 -For NSDate                                          : GSJDateValueTransformer
 -For NSData                                          : GSJDataValueTransformer
 **/

#import <Foundation/Foundation.h>

extern NSString *const GSJStringValueTransformer;
extern NSString *const GSJNumberValueTransformer;
extern NSString *const GSJDateValueTransformer;
extern NSString *const GSJDataValueTransformer;

@interface GSJDataEncryptor : NSObject

//Required to set a password.
+ (void)setupEncryptorWithPassword:(NSString *)password;

//Helper methods for standalone encryption/decryption
+ (NSData *)encryptString:(NSString *)aString;
+ (NSString *)decryptedStringFromData:(NSData *)aData;

+ (NSData *)encryptNumber:(NSNumber *)aNumber;
+ (NSNumber *)decryptedNumberFromData:(NSData *)aData;

+ (NSData *)encryptDate:(NSDate *)aDate;
+ (NSDate *)decryptedDateFromData:(NSData *)aData;

+ (NSData *)encryptData:(NSData *)aData;
+ (NSData *)decryptedDataFromData:(NSData *)aData;

+ (NSString *)encryptFileAtPath:(NSString *)filePath shouldOverwriteFile:(BOOL)flag;
+ (NSString *)decryptFileAtPath:(NSString *)filePath shouldOverwriteFile:(BOOL)flag;

@end
