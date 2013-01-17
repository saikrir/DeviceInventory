//
//  DeviceDataAccessDelegate.h
//  MyDeviceInventory
//
//  Created by Katterishetty, Sai Krishna on 11/27/12.
//  Copyright (c) 2012 Katterishetty, Sai Krishna. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DeviceDataAccessDelegate <NSObject>

@required
-(NSArray *) getAllLaptops;
-(NSArray *) getAllTablets;
-(NSArray *) getAllMobileDevice;
-(BOOL) isDataSetup;

@optional
-(NSArray *) getAllSupportedCatgories;

@end
