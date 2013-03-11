//
//  BMAppDelegate.m
//  BetterMail
//
//  Created by Sebastian Obermüller on 08.02.13.
//  Copyright (c) 2013 MobileMinds. All rights reserved.
//

#import "BMAppDelegate.h"
#import "BMDataModel.h"
#import "Email.h"
#import "Contact.h"

#import "PDDebugger.h"


@implementation BMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  [self setupLogging];
  
#if DEBUG
  [self setupPonyDebugger];
#endif
  
  NSManagedObjectContext *context = [[BMDataModel sharedDataModel] mainContext];
  if (context) {
    NSLog(@"context ready");
    
    Contact *c = [Contact insertInManagedObjectContext:context];
    c.name = @"Hans Dampf2";
    c.emailAddress = @"ha.da2@da.de";
    
    Email *email = [Email insertInManagedObjectContext:context];
    email.recipient = c;
    email.sender = @"me";
    email.body = @"test text mail";
    
    
    NSError *err = nil;
    [context save:&err];
    
    if (err) {
      DDLogError(@"Uppss!");
    }
    
  }else {
    DDLogError(@"context nil!");
  }
  
  DDLogInfo(@"BMDataModel: log level %d", [DDLog logLevelForClassWithName:@"BMDataModel"]);
  DDLogInfo(@"BMAppDelegate: log level %d", [DDLog logLevelForClassWithName:@"BMAppDelegate"]);
  
 
#if !TARGET_IPHONE_SIMULATOR
  for (Class class in [DDLog registeredClasses]) { // [DDLog registeredClasses] crashes in the simulator!!
    DDLogInfo(@"%@", [class description]);
    [DDLog logLevelForClass:class];
    if ([class.description isEqualToString:@"BMDataModel"]) {
      [DDLog setLogLevel:LOG_LEVEL_WARN forClass:class];
    }
  }

  DDLogInfo(@"BMDataModel: log level %d", [DDLog logLevelForClassWithName:@"BMDataModel"]);
  DDLogInfo(@"BMAppDelegate: log level %d", [DDLog logLevelForClassWithName:@"BMAppDelegate"]);
#endif
  
  return YES;
}


- (void)setupLogging
{
  ddLogLevel = LOG_LEVEL_VERBOSE;
  [DDLog addLogger:[DDASLLogger sharedInstance]];
  [DDLog addLogger:[DDTTYLogger sharedInstance]];
}


- (void)applicationWillResignActive:(UIApplication *)application
{
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  DDLogInfo(@"app did become active!");
}

- (void)applicationWillTerminate:(UIApplication *)application
{
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

+ (int)ddLogLevel
{
  return ddLogLevel;
}

+ (void)ddSetLogLevel:(int)logLevel
{
  ddLogLevel = logLevel;
}


- (void)setupPonyDebugger
{
  PDDebugger *debugger = [PDDebugger defaultInstance];
  [debugger connectToURL:[NSURL URLWithString:@"ws://localhost:9000/device"]];
  [debugger enableNetworkTrafficDebugging];
  [debugger forwardAllNetworkTraffic];
  
  [debugger enableCoreDataDebugging];
  NSManagedObjectContext *context = [[BMDataModel sharedDataModel] mainContext];
  [debugger addManagedObjectContext:context withName:@"Main Context"];
  
  [debugger enableViewHierarchyDebugging];
}

@end
