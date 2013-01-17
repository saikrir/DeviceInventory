//
//  DeviceDataAccessService.h
//  MyDeviceInventory
//
//  Created by Katterishetty, Sai Krishna on 11/27/12.
//  Copyright (c) 2012 Katterishetty, Sai Krishna. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "DeviceDataAccessDelegate.h"

#define DB_STORE_NAME @"DeviceDB"


@interface DeviceDataAccessService : NSObject<DeviceDataAccessDelegate>


@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;


-(NSMutableArray *) searchDevices:(NSString *) srchStr;
-(void) setupCurrentDevices;

+(DeviceDataAccessService *) sharedInstance;

@end
