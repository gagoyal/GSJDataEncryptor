GSJDataEncryptor
================

GSJDataEncryptor is a data encryption framework. The project compiles to create a GSJDataEncryptor.framework which can be included in iOS projects. 

The features of this project are:

-> Link your projects with GSJDataEncryptor.framework just like any standard iOS framework.

-> GSJDataEncryptor.framework is built for armv7, armv7s and arm64 architectures.

-> Supports NSString, NSNumber and NSDate

-> Can be used with CoreData to encrypt .sqlite files.

-> Fast fetching of data using fetch requests.

-> Support updates to core data models in future releases of your apps.

-> Unit tests included to test all the transformers


How to use
================
Link your target with Security.framework and GSJDataEncryptor.framework

In appDelegate.m add method:

\+ (void) initialize

{

  [GSJDataEncryptor setupEncryptorWithPassword:@"YourPassword"];

}


In your CoreDataModel, specify the following keys in Transformer Value Name:

-For String use GSJStringValueTransformer

-For Float/Int/Bool/Signed/Unsigned/Any NSNumber use GSJNumberValueTransformer

-For Date use GSJDateValueTransformer


