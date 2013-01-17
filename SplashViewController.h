//
//  SplashViewController.h
//  MyDeviceInventory
//
//  Created by Katterishetty, Sai Krishna on 12/23/12.
//  Copyright (c) 2012 Katterishetty, Sai Krishna. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SplashViewController : UIViewController

@property (retain, nonatomic) IBOutlet UIProgressView *applicationLoader;
@property (retain, nonatomic) IBOutlet UILabel *loadingStatus;

-(void) dismissSplashScreen;

@end
