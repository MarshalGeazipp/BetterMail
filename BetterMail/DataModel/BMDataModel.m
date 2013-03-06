//
//  BMDataModel.m
//  BetterMail
//
//  Created by Sebastian Obermüller on 08.02.13.
//  Copyright (c) 2013 MobileMinds. All rights reserved.
//

#import "BMDataModel.h"

@interface BMDataModel ()

@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
- (NSString *)documentsDirectory;

@end


@implementation BMDataModel

@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize mainContext = _mainContext;

+ (id)sharedDataModel {
  static BMDataModel *__instance = nil;
  if (__instance == nil) {
    __instance = [[BMDataModel alloc] init];
    
    DDLogVerbose(@"BMDataModel instantiated");
  }
  
  return __instance;
}

- (NSString *)modelName {
  return @"Model";
}

- (NSString *)pathToModel {
  return [[NSBundle mainBundle] pathForResource:[self modelName]
                                         ofType:@"momd"];
}

- (NSString *)storeFilename {
  return [[self modelName] stringByAppendingPathExtension:@"sqlite"];
}

- (NSString *)pathToLocalStore {
  return [[self documentsDirectory] stringByAppendingPathComponent:[self storeFilename]];
}

- (NSString *)documentsDirectory {
  NSString *documentsDirectory = nil;
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  documentsDirectory = paths[0];
  return documentsDirectory;
}

- (NSManagedObjectContext *)mainContext {
  if (_mainContext == nil) {
    _mainContext = [[NSManagedObjectContext alloc] init];
    _mainContext.persistentStoreCoordinator = [self persistentStoreCoordinator];
  }
  
  return _mainContext;
}

- (NSManagedObjectModel *)managedObjectModel {
  if (_managedObjectModel == nil) {
    NSURL *storeURL = [NSURL fileURLWithPath:[self pathToModel]];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:storeURL];
  }
  
  return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
  if (_persistentStoreCoordinator == nil) {
    DDLogVerbose(@"SQLITE STORE PATH: %@", [self pathToLocalStore]);
    NSURL *storeURL = [NSURL fileURLWithPath:[self pathToLocalStore]];
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc]
                                         initWithManagedObjectModel:[self managedObjectModel]];
    NSDictionary *options = @{NSMigratePersistentStoresAutomaticallyOption: @YES,
                              NSInferMappingModelAutomaticallyOption: @YES};
    NSError *e = nil;
    if (![psc addPersistentStoreWithType:NSSQLiteStoreType
                           configuration:nil
                                     URL:storeURL
                                 options:options
                                   error:&e]) {
      
      NSDictionary *userInfo = @{NSUnderlyingErrorKey: e};
      NSString *reason = @"Could not create persistent store.";
      NSException *exc = [NSException exceptionWithName:NSInternalInconsistencyException
                                                 reason:reason
                                               userInfo:userInfo];
      @throw exc;
    }
    
    _persistentStoreCoordinator = psc;
  }
  
  return _persistentStoreCoordinator;
}

+ (int)ddLogLevel
{
  return ddLogLevel;
}

+ (void)ddSetLogLevel:(int)logLevel
{
  ddLogLevel = logLevel;
}


@end
