//
//  SearchViewController.m
//  MyDeviceInventory
//
//  Created by Katterishetty, Sai Krishna on 11/28/12.
//  Copyright (c) 2012 Katterishetty, Sai Krishna. All rights reserved.
//

#import "DeviceDataAccessService.h"
#import "SearchViewController.h"
#import "DeviceDetailViewController.h"
#import "Device.h"

@interface SearchViewController ()
{
    NSMutableArray *searchResults;
}
    
@end

@implementation SearchViewController
@synthesize deviceSearchBar = _deviceSearchBar;
@synthesize searchView = _searchView;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Device Search";
        self.tabBarItem.image = [UIImage imageNamed:@"magnify"];
    }
    searchResults = nil;
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
     self.deviceSearchBar.showsCancelButton = YES;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_deviceSearchBar release];
    [_searchView release];
    [searchResults release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setDeviceSearchBar:nil];
    [self setSearchView:nil];
    [super viewDidUnload];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if(interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
        return NO;
    
    return YES;
}



#pragma - mark UISearchBar Delegate

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [self.deviceSearchBar resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSString *srchTxt = searchBar.text;
    [searchBar resignFirstResponder];
    DeviceDataAccessService *dataAccessSvc = [DeviceDataAccessService sharedInstance];

    if([srchTxt length]<= 0)
    {
        [searchResults removeAllObjects];
        [self.searchView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
        [searchBar becomeFirstResponder];
        return;
    }
    
    if(searchResults)
    {
        [searchResults release];
    }
    
    searchResults = [[dataAccessSvc searchDevices:srchTxt] retain];
    
    if([searchResults count] == 0)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Device Inventory" message:@"No Search Results Found" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
        searchBar.text =@"";
        [searchBar becomeFirstResponder];
        return;
    }
    
    [self.searchView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if([searchText length] == 0) {
        [searchBar performSelector: @selector(resignFirstResponder)
                        withObject: nil
                        afterDelay: 0.0];
        [searchResults removeAllObjects];
        [searchBar becomeFirstResponder];
        [self.searchView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    }
}

- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar
{
    [self searchBarSearchButtonClicked:searchBar];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchResults removeAllObjects];
    [self.deviceSearchBar setText:@""];
    [self.searchView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    [searchBar resignFirstResponder];

}


#pragma mark - Table View Methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *simpleTableIdentifier = @"DefaultCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    UIImage *ltImage = [UIImage imageNamed:@"laptop.png"];
    UIImage *tbImage = [UIImage imageNamed:@"tablet.png"];
    UIImage *phImage = [UIImage imageNamed:@"phones.png"];
    
    NSInteger rowIndex = [indexPath row];
    
    Device *device = [searchResults objectAtIndex:rowIndex];
    
    if([device.deviceType isEqualToString:@"LT"])
    {
        cell.imageView.image = ltImage;
    }
    else if([device.deviceType isEqualToString:@"TB"])
    {
        cell.imageView.image = tbImage;
    }
    else{
        cell.imageView.image = phImage;
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = device.deviceName;
    return cell;
        
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rowCount = 0;
    
    if(searchResults)
    {
       rowCount = [searchResults count];
    }
    
    return rowCount;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Device *device = [searchResults objectAtIndex:indexPath.row];
    DeviceDetailViewController *deviceViewController = [[DeviceDetailViewController alloc] initWithNibName:@"DeviceDetailViewController" bundle:nil];
    [deviceViewController setDevice:device];
    [self.navigationController pushViewController:deviceViewController animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 64;
}


@end
