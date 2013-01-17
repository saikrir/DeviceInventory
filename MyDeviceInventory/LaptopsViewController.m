//
//  ViewController.m
//  MyDeviceInventory
//
//  Created by Katterishetty, Sai Krishna on 11/17/12.
//  Copyright (c) 2012 Katterishetty, Sai Krishna. All rights reserved.
//

#import "LaptopsViewController.h"

@interface LaptopsViewController ()

@end

@implementation LaptopsViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Laptops";
        self.tabBarItem.title = @"Laptops";
        self.tabBarItem.image = [UIImage imageNamed:@"laptop"];
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"Background Color %@" ,self.view.backgroundColor);
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
