//
//  TabletsViewController.m
//  MyDeviceInventory
//
//  Created by Katterishetty, Sai Krishna on 11/20/12.
//  Copyright (c) 2012 Katterishetty, Sai Krishna. All rights reserved.
//

#import "TabletsViewController.h"

@interface TabletsViewController ()

@end

@implementation TabletsViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.tabBarItem = [[UITabBarItem alloc] init];
        self.tabBarItem.title = @"Tablets";
        self.title = @"Tablet";
        self.tabBarItem.image = [UIImage imageNamed:@"tablet"];

    }
    return self;
}

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
