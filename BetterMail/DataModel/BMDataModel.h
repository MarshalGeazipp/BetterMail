//
//  BMDataModel.h
//  BetterMail
//
//  Created by Sebastian Obermüller on 08.02.13.
//  Copyright (c) 2013 MobileMinds. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface BMDataModel : NSObject

+ (id)sharedDataModel;

@property (nonatomic, readonly) NSManagedObjectContext *mainContext;
@property (nonatomic, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (NSString *)modelName;
- (NSString *)pathToModel;
- (NSString *)storeFilename;
- (NSString *)pathToLocalStore;

@end
