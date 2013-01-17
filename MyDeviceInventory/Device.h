//
//  Device.h
//  MyDeviceInventory
//
//  Created by Katterishetty, Sai Krishna on 12/28/12.
//  Copyright (c) 2012 Katterishetty, Sai Krishna. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Device : NSManagedObject

@property (nonatomic, retain) NSDate * datePurchased;
@property (nonatomic, retain) NSNumber * deviceId;
@property (nonatomic, retain) NSString * deviceName;
@property (nonatomic, retain) NSString * deviceType;
@property (nonatomic, retain) NSString * dimensions;
@property (nonatomic, retain) NSString * diskCapacity;
@property (nonatomic, retain) NSString * graphicsCard;
@property (nonatomic, retain) NSString * hardDiskType;
@property (nonatomic, retain) NSString * memory;
@property (nonatomic, retain) NSString * networkcard;
@property (nonatomic, retain) NSString * operatingSystem;
@property (nonatomic, retain) NSString * processor;
@property (nonatomic, retain) NSNumber * webcam;
@property (nonatomic, retain) NSString * deviceImage;

@end
