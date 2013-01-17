//
//  DeviceDetailViewController.m
//  MyDeviceInventory
//
//  Created by Katterishetty, Sai Krishna on 12/28/12.
//  Copyright (c) 2012 Katterishetty, Sai Krishna. All rights reserved.
//

#import "DeviceDetailViewController.h"

@interface DeviceDetailViewController ()
    @property (retain, nonatomic) NSMutableDictionary *deviceAttributes;
    @property (retain,nonatomic) NSMutableArray *deviceProperties;

    -(void) populateDeviceAttributes;
@end

@implementation DeviceDetailViewController

@synthesize device = _device;
@synthesize deviceImageView = _deviceImageView;
@synthesize deviceDetails = _deviceDetails;
@synthesize deviceAttributes = _deviceAttributes;
@synthesize deviceProperties = _deviceProperties;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.deviceAttributes = [[NSMutableDictionary alloc]init];
        self.deviceProperties = [NSArray arrayWithObjects:@"deviceName",@"datePurchased",@"processor",@"memory",@"diskCapacity",@"hardDiskType",@"graphicsCard",@"networkcard",@"operatingSystem",@"webcam", nil];
        [self populateDeviceAttributes];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self populateDeviceAttributes];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *simpleTableIdentifier = @"DefaultCell";
    NSString *imageViewCell = @"ImageViewCell";
    UITableViewCell *cell = nil;
    
    if(indexPath.section == 0)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
        if (cell == nil)
        {
         cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:simpleTableIdentifier] autorelease];
         NSString *property = [_deviceProperties objectAtIndex:indexPath.row];
         cell.textLabel.text = [property uppercaseString];
         cell.detailTextLabel.text = [_deviceAttributes objectForKey:property];
        }
    }
    else
    {
        CGRect frame = CGRectMake(0, 0, 480, 320); // cell for row height takes height's precedence
        cell = [tableView dequeueReusableCellWithIdentifier:imageViewCell];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:imageViewCell] autorelease];
            cell.frame = frame;
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:cell.frame];
            imageView.image = [UIImage imageNamed:_device.deviceImage];
            imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;//Very Important
            [cell.contentView addSubview:imageView];
        }
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rowCount = 10;
    
    if(section == 1)
    {
        rowCount = 1;
    }
    
    return rowCount;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionHeader = [[NSString alloc] init];
    
    if(section == 0)
    {
        sectionHeader = @"Device Details";
    }
    else
    {
        sectionHeader = @"Device Image";
    }
   return [sectionHeader autorelease];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if(indexPath.section == 1)
    {
        return 220;
    }
    return 44;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}


-(void) populateDeviceAttributes
{
    for(NSString *property in _deviceProperties)
    {
        id value = [_device valueForKey:property];
        if([property isEqualToString:@"datePurchased"])
        {
            NSDate *date = (NSDate *) value;
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
            [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
            [_deviceAttributes setValue:[dateFormatter stringFromDate:date]  forKey:property];
            [dateFormatter release];
        }
        else if([property isEqualToString:@"webcam"])
        {
            BOOL boolValue = [value boolValue];
            NSString *value = (boolValue? @"YES": @"NO");
            if(boolValue)
            [_deviceAttributes setValue:value  forKey:property];
        }
        else{
            [_deviceAttributes setValue:value  forKey:property];
        }
    }
}
- (void)dealloc {
    [_deviceImageView release];
    [_deviceDetails release];
    [_device release];
    [_deviceProperties release];
    [_deviceAttributes release];
    [super dealloc];
}
@end
