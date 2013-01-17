//
//  PersonalDevicesViewController.m
//  MyDeviceInventory
//
//  Created by Katterishetty, Sai Krishna on 11/20/12.
//  Copyright (c) 2012 Katterishetty, Sai Krishna. All rights reserved.
//

#import "PersonalDevicesViewController.h"

@interface PersonalDevicesViewController ()

@end

@implementation PersonalDevicesViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.tabBarItem = [[UITabBarItem alloc] init];
        self.title = @"Cell Phones";
        self.tabBarItem.image = [UIImage imageNamed:@"phones"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
