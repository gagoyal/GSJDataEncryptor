//
//  GSJEncryptionTransformer.h
//  GSJDataEncryptor
//
//  Created by Gaurav, Seema and Jasvinder on 7/5/14.
//  Copyright (c) 2014 GSJ. All rights reserved.
//

@interface GSJEncryptionTransformer : NSValueTransformer

/**
 * The key used for encrypting / decrypting values during transformation.
 */
@property (nonatomic, strong) NSString *key;


@end