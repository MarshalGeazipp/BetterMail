// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Email.h instead.

#import <CoreData/CoreData.h>


extern const struct EmailAttributes {
	__unsafe_unretained NSString *body;
	__unsafe_unretained NSString *sender;
} EmailAttributes;

extern const struct EmailRelationships {
	__unsafe_unretained NSString *recipient;
} EmailRelationships;

extern const struct EmailFetchedProperties {
} EmailFetchedProperties;

@class Contact;




@interface EmailID : NSManagedObjectID {}
@end

@interface _Email : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (EmailID*)objectID;





@property (nonatomic, strong) NSString* body;



//- (BOOL)validateBody:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* sender;



//- (BOOL)validateSender:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) Contact *recipient;

//- (BOOL)validateRecipient:(id*)value_ error:(NSError**)error_;





@end

@interface _Email (CoreDataGeneratedAccessors)

@end

@interface _Email (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveBody;
- (void)setPrimitiveBody:(NSString*)value;




- (NSString*)primitiveSender;
- (void)setPrimitiveSender:(NSString*)value;





- (Contact*)primitiveRecipient;
- (void)setPrimitiveRecipient:(Contact*)value;


@end
