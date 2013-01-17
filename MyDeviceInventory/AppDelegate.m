//
//  AppDelegate.m
//  MyDeviceInventory
//
//  Created by Katterishetty, Sai Krishna on 11/17/12.
//  Copyright (c) 2012 Katterishetty, Sai Krishna. All rights reserved.
//

#import "AppDelegate.h"

#import "LaptopsViewController.h"
#import "TabletsViewController.h"
#import "PersonalDevicesViewController.h"
#import "DeviceDataAccessService.h"
#import "SearchViewController.h"
#import "SplashViewController.h"

@interface AppDelegate ()

    @property (strong, nonatomic) NSTimer *timer;

    @property (strong, nonatomic)SplashViewController *splashViewController;

    -(void) showApplication;

@end



@implementation AppDelegate
@synthesize timer = _timer;
@synthesize splashViewController = _splashViewController;


- (void)dealloc
{
    [_window release];
    [_mainController release];
    [_splashViewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.mainController = [[UITabBarController alloc] init];
    
    UIColor *appBgcolor = [UIColor colorWithRed:0.18266 green:0.18266 blue:0.18266 alpha:1];
    

    
    UINavigationController *laptopController = [[UINavigationController alloc] initWithRootViewController:[[LaptopsViewController alloc] initWithNibName:@"LaptopsViewController" bundle:nil]];
    
    [laptopController.navigationBar setTintColor:appBgcolor];
    
    UINavigationController *searchController = [[UINavigationController alloc] initWithRootViewController:[[SearchViewController alloc] initWithNibName:@"SearchViewController" bundle:nil]];
    
    [searchController.navigationBar setTintColor:appBgcolor];
    
    
    NSArray *viewControllers = [NSArray arrayWithObjects: searchController,laptopController ,[[TabletsViewController alloc] init],[[PersonalDevicesViewController alloc]init], nil];
    
    [self.mainController setViewControllers:viewControllers animated:YES];
    
    
    self.splashViewController = [[SplashViewController alloc] initWithNibName:@"SplashViewController" bundle:nil];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(showApplication) userInfo:nil repeats:NO];

    self.window.rootViewController = self.splashViewController;
    [self.window makeKeyAndVisible];
    return YES;
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
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void) showApplication
{
    [self.splashViewController dismissSplashScreen];
    self.window.rootViewController = self.mainController;
    [self.window makeKeyAndVisible];
}

@end
