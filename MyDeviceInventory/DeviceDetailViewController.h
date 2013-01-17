//
//  DeviceDetailViewController.h
//  MyDeviceInventory
//
//  Created by Katterishetty, Sai Krishna on 12/28/12.
//  Copyright (c) 2012 Katterishetty, Sai Krishna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Device.h"

@interface DeviceDetailViewController : UIViewController <UITableViewDataSource , UITableViewDelegate>

@property (retain, nonatomic) IBOutlet UIImageView *deviceImageView;
@property (retain, nonatomic) IBOutlet UITableView *deviceDetails;

@property (retain) Device *device;

@end
