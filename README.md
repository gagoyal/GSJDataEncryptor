# GSJDataEncryptor
GSJDataEncryptor is an Objective C data encryption framework. The project compiles to create a GSJDataEncryptor.framework which can be included in iOS or Mac OS X project.

### Features
- Link your projects with GSJDataEncryptor.framework just like any standard iOS framework.
- GSJDataEncryptor.framework is built for armv7, armv7s and arm64 architectures. It also has support for simulators.
- Supports NSString, NSNumber, NSDate, NSData and it has methods to encrypt complete files.
- Can be used with CoreData to encrypt .sqlite files.
- Fast fetching of data using fetch requests. For even faster results, use NSFetchedResultsController.
- Support updates to core data models in future releases of your apps.
- Unit tests included to test all the transformers. 
- Built with latest XCode SDK and on latest Mac OS X platform.

###How to use
Link your target with Security.framework and GSJDataEncryptor.framework

In appDelegate.m add method:
`+ (void) initialize {
    [GSJDataEncryptor setupEncryptorWithPassword:@"YourPassword"];
}`

In your CoreDataModel, specify the following keys in Transformer Value Name:
- For String use `GSJStringValueTransformer`
- For Float/Int/Bool/Signed/Unsigned/Any NSNumber use `GSJNumberValueTransformer`
- For Date use `GSJDateValueTransformer`
- For Data use `GSJDataValueTransformer`

Set the following options on your Entity attributes
- Set `Attribute Type` to `Transformable`
- Set `Name` to any suitable key from the above specified keys, according to the type of data. 
For example set `Name` to `GSJStringValueTransformer`
 
### Authors
GSJ: Gaurav, Seema and Jasvinder
