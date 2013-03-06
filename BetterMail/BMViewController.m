//
//  BMViewController.m
//  BetterMail
//
//  Created by Sebastian Obermüller on 08.02.13.
//  Copyright (c) 2013 MobileMinds. All rights reserved.
//

#import "BMViewController.h"
#import "iCarousel.h"
#import "MBProgressHUD.h"

@interface BMViewController () {
  MBProgressHUD *_hud;
}

@end

@implementation BMViewController

@synthesize appSettingsViewController;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  self.title = @"Liste";
  _hud = [[MBProgressHUD alloc] initWithView:self.view];
  [_hud setLabelText:@"laden ..."];
  [_hud setMode:MBProgressHUDModeIndeterminate];
//  [_hud setRemoveFromSuperViewOnHide:YES];
  DDLogInfo(@"add hud subview");
  [self.view addSubview:_hud];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonTapped:(id)sender
{
  NSLog(@"Loglevel %d", ddLogLevel);
  
  [_hud show:YES];
  [_hud setMode:MBProgressHUDModeDeterminate];
  
  // play around with dispatch_async and dispatch queues:
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
    // do something in th background
    for (int i=0; i<100000; i++) {
      dispatch_async(dispatch_get_main_queue(), ^{
        [_hud setProgress:((float)i/100000.0f)];
        
      });
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
      [_hud hide:YES afterDelay:2];
    });
    
  });

}

- (IBAction)settingsButtontapped:(id)sender
{
  appSettingsViewController = [[IASKAppSettingsViewController alloc] init];
  appSettingsViewController.delegate = self;
  BOOL enabled = [[NSUserDefaults standardUserDefaults] boolForKey:@"AutoConnect"];
  appSettingsViewController.hiddenKeys = enabled ? nil : [NSSet setWithObjects:@"AutoConnectLogin", @"AutoConnectPassword", nil];
  
  UINavigationController *aNavController = [[UINavigationController alloc] initWithRootViewController:self.appSettingsViewController];
//  [appSettingsViewController setShowCreditsFooter:NO];   // Uncomment to not display InAppSettingsKit credits for creators.
  // But we encourage you not to uncomment. Thank you!
  self.appSettingsViewController.showDoneButton = YES;
  [self presentModalViewController:aNavController animated:YES];
  
}

- (void)settingsViewControllerDidEnd:(IASKAppSettingsViewController*)sender
{
  NSNumber *logLevel = [[NSUserDefaults standardUserDefaults] objectForKey:@"prefsLogLevel"];
  if (logLevel)
//    [BMViewController ddSetLogLevel:logLevel.intValue];
    
// !!!: Achtung
#if !TARGET_IPHONE_SIMULATOR
  //set the global loglevel 
  for (Class class in [DDLog registeredClasses]) { // [DDLog registeredClasses] crashes in the simulator!!
    DDLogInfo(@"%@", [class description]);
    [DDLog setLogLevel:logLevel.intValue forClass:class];
  }
  
  DDLogInfo(@"BMDataModel: log level %d", [DDLog logLevelForClassWithName:@"BMDataModel"]);
  DDLogInfo(@"BMAppDelegate: log level %d", [DDLog logLevelForClassWithName:@"BMAppDelegate"]);
#endif
  
  [self dismissViewControllerAnimated:YES completion:nil];
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
