// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Email.m instead.

#import "_Email.h"

const struct EmailAttributes EmailAttributes = {
	.body = @"body",
	.sender = @"sender",
};

const struct EmailRelationships EmailRelationships = {
	.recipient = @"recipient",
};

const struct EmailFetchedProperties EmailFetchedProperties = {
};

@implementation EmailID
@end

@implementation _Email

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Email" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Email";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Email" inManagedObjectContext:moc_];
}

- (EmailID*)objectID {
	return (EmailID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic body;






@dynamic sender;






@dynamic recipient;

	






@end
