//
//  SplashViewController.m
//  MyDeviceInventory
//
//  Created by Katterishetty, Sai Krishna on 12/23/12.
//  Copyright (c) 2012 Katterishetty, Sai Krishna. All rights reserved.
//

#import "SplashViewController.h"
#import "DeviceDataAccessService.h"

@interface SplashViewController ()

    @property (strong,nonatomic) NSTimer *timer;
    -(void) checkAndSetupData;

@end

@implementation SplashViewController
@synthesize timer = _timer;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.applicationLoader.progress = 0;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateApplicationProgressBar) userInfo:nil repeats:YES];
    [self checkAndSetupData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillDisappear:(BOOL)animated
{
    self.applicationLoader.progress = 1;
}

-(void) updateApplicationProgressBar
{
    if(self.applicationLoader.progress < 1)
    {
        self.applicationLoader.progress += 0.33;
    }
}

-(void) dismissSplashScreen
{
    [self dismissViewControllerAnimated:YES completion:
    ^(void)
    {
        self.loadingStatus.text = @"Done";
    }];
    
}

-(void) checkAndSetupData
{
    DeviceDataAccessService *deviceDataSvc = [DeviceDataAccessService sharedInstance];
    if(![deviceDataSvc isDataSetup])
    {
        NSLog(@"Device Data not found, setting up devices");
        [deviceDataSvc setupCurrentDevices];
    }
    
}

- (void)dealloc {
    [_applicationLoader release];
    [_timer dealloc];
    [_loadingStatus release];
    [super dealloc];
}
@end
