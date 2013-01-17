//
//  DeviceDataAccessService.m
//  MyDeviceInventory
//
//  Created by Katterishetty, Sai Krishna on 11/27/12.
//  Copyright (c) 2012 Katterishetty, Sai Krishna. All rights reserved.
//

#import "DeviceDataAccessService.h"
#import "Device.h"
#define K_DEVICE_TYPE_LAPTOP @"LT"
#define K_DEVICE_TYPE_TABLET @"TB"
#define K_DEVICE_TYPE_PERSONAL_DEVICE @"PD"
#define K_DISK_TYPE_SOLID_STATE @"SSD"
#define K_DISK_TYPE_MECHANICAL @"MEC"


@interface DeviceDataAccessService(Private)
    - (NSURL *) applicationDocumentsDirectory;
@end


    
@implementation DeviceDataAccessService

@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;

static DeviceDataAccessService *sharedInstance = nil;


- (id)init
{
    self = [super init];
    if (self) {
        //[self setupCurrentDevices];
    }
    return self;
}

+(DeviceDataAccessService *) sharedInstance
{
    if(! sharedInstance)
    {
        sharedInstance = [[DeviceDataAccessService alloc] init];
    }
    
    return sharedInstance;
}


#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (__managedObjectContext != nil) {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil) {
        return __managedObjectModel;
    }
   // NSURL *modelURL = [[NSBundle mainBundle] URLForResource:DB_STORE_NAME withExtension:@"mom"];
    __managedObjectModel =  [[NSManagedObjectModel mergedModelFromBundles:nil] retain];
    return __managedObjectModel;
}



// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil) {
        return __persistentStoreCoordinator;
    }
    
    NSString *dbName = [NSString stringWithFormat:@"%@.sqlite", DB_STORE_NAME];
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:dbName];
    
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,[NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
    
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return __persistentStoreCoordinator;
}

- (void)dealloc
{
    [sharedInstance release];
    [self.managedObjectContext release];
    [self.managedObjectModel release];
    [self.persistentStoreCoordinator release];
    [super dealloc];
}

# pragma mark - Delegate Implementation Methods

-(NSArray *) getAllLaptops
{
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *devices = [NSEntityDescription entityForName:@"Device" inManagedObjectContext:managedObjectContext];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"deviceType = %@",K_DEVICE_TYPE_LAPTOP];
    [request setPredicate:predicate];
    [request setEntity:devices];
    NSError *error = nil;
    NSArray *mutableFetchResults = [managedObjectContext executeFetchRequest:request error:&error];
    
    if (!mutableFetchResults) {
        NSLog(@"Failed to fetch data %@", [error description]);
    }
    else
    {
        NSLog(@"Obtained Data %d", [mutableFetchResults count]);
    }
    
    [request release];
    
    return  [mutableFetchResults autorelease];
}


-(NSArray *) getAllTablets
{
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *devices = [NSEntityDescription entityForName:@"Device" inManagedObjectContext:managedObjectContext];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"deviceType = %@",K_DEVICE_TYPE_TABLET];
    [request setPredicate:predicate];
    [request setEntity:devices];
    NSError *error = nil;
    NSArray *mutableFetchResults = [managedObjectContext executeFetchRequest:request error:&error];
    
    if (!mutableFetchResults) {
        NSLog(@"Failed to fetch data %@", [error description]);
    }
    else
    {
        NSLog(@"Obtained Data %d", [mutableFetchResults count]);
    }
    
    [request release];
    
    return  [mutableFetchResults autorelease];

}

-(NSArray *) getAllMobileDevice
{
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *devices = [NSEntityDescription entityForName:@"Device" inManagedObjectContext:managedObjectContext];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"deviceType = %@",K_DEVICE_TYPE_PERSONAL_DEVICE];
    [request setPredicate:predicate];
    [request setEntity:devices];
    NSError *error = nil;
    NSArray *mutableFetchResults = [managedObjectContext executeFetchRequest:request error:&error];
    
    if (!mutableFetchResults) {
        NSLog(@"Failed to fetch data %@", [error description]);
    }
    else
    {
        NSLog(@"Obtained Data %d", [mutableFetchResults count]);
    }
    
    [request release];
    
    return  [mutableFetchResults autorelease];

}

-(NSMutableArray *) searchDevices : (NSString *) srchStr
{
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *devices = [NSEntityDescription entityForName:@"Device" inManagedObjectContext:managedObjectContext];
    NSString *wildcardedString = [NSString stringWithFormat:@"*%@*", srchStr];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"deviceName like [c]%@",wildcardedString];
    [request setPredicate:predicate];
    [request setEntity:devices];
    NSError *error = nil;
    NSMutableArray *mutableFetchResults = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    
    if (!mutableFetchResults) {
        NSLog(@"Failed to fetch data %@", [error description]);
    }

    [request release];
    
    return  [mutableFetchResults autorelease];
}

-(BOOL) isDataSetup
{
    BOOL dataReady = NO;
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *devices = [NSEntityDescription entityForName:@"Device" inManagedObjectContext:managedObjectContext];
    [request setEntity:devices];
    NSError *error = nil;
    NSMutableArray *mutableFetchResults = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    
    if (!mutableFetchResults) {
        NSLog(@"Failed to fetch data %@", [error description]);
    }
    
    [request release];
    dataReady = ([mutableFetchResults count] > 0);
    [mutableFetchResults release];
    return dataReady;
}


#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


-(void) setupCurrentDevices
{
    NSURL *jsonFilePath = [[NSBundle mainBundle] URLForResource:@"Devices" withExtension:@"json"];
    NSString *path = [jsonFilePath path];
    NSData *data = [[NSFileManager defaultManager] contentsAtPath:path];
    
    NSError *jsonParsingError = nil;
    NSArray *devices = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonParsingError];
    
    if(jsonParsingError)
    {
        NSLog(@"JSON File Parsing error occured");
        return;
    }
    
    Device *deviceModel = nil;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    for(NSDictionary *deviceDict in devices)
    {
        NSManagedObjectContext *ctx = [self managedObjectContext];
        
        deviceModel = [NSEntityDescription
                                        insertNewObjectForEntityForName:@"Device"
                                        inManagedObjectContext:ctx];
        NSNumber *deviceId = [NSNumber numberWithInt:[[deviceDict objectForKey:@"_Device__deviceId"] integerValue]];
        BOOL webcam = [[deviceDict objectForKey:@"_Device__webcam"] boolValue];
        deviceModel.deviceId = deviceId;
        deviceModel.datePurchased = [dateFormatter dateFromString:[deviceDict objectForKey:@"_Device__datePurchased"]];
        deviceModel.deviceName = [deviceDict objectForKey:@"_Device__deviceName"];
        deviceModel.deviceType = [deviceDict objectForKey:@"_Device__deviceType"];
        [deviceModel setDimensions:[deviceDict objectForKey:@"_Device__dimensions"]];
        [deviceModel setGraphicsCard:[deviceDict objectForKey:@"_Device__graphicsCard"]];
        [deviceModel setMemory:[deviceDict objectForKey:@"_Device__memory"]];
        [deviceModel setNetworkcard:[deviceDict objectForKey:@"_Device__networkcard"]];
        [deviceModel setOperatingSystem:[deviceDict objectForKey:@"_Device__operatingSystem"]];
        [deviceModel setProcessor:[deviceDict objectForKey:@"_Device__processor"]];
        [deviceModel setWebcam: [NSNumber numberWithBool:webcam]];
        [deviceModel setDiskCapacity:[deviceDict objectForKey:@"_Device__diskCapacity"]];
        [deviceModel setHardDiskType:[deviceDict objectForKey:@"_Device__hardDiskType"]];
        [deviceModel setDeviceImage:[deviceDict objectForKey:@"_Device__deviceImage"]];
        
        NSError *error;
        
        if (![ctx save:&error]) {
            NSLog(@"Failed to save: %@", [error localizedDescription]);
        }
        else{
            NSLog(@"Saved %@", [deviceModel deviceName]);
        }
    }

}

@end
