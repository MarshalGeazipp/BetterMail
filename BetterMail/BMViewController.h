//
//  BMViewController.h
//  BetterMail
//
//  Created by Sebastian Obermüller on 08.02.13.
//  Copyright (c) 2013 MobileMinds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IASKAppSettingsViewController.h"

@interface BMViewController : UIViewController <IASKSettingsDelegate>

@property (nonatomic, retain) IASKAppSettingsViewController *appSettingsViewController;

- (IBAction)buttonTapped:(id)sender;
- (IBAction)settingsButtontapped:(id)sender;
- (IBAction)toastBtnTapped:(id)sender;

@end
