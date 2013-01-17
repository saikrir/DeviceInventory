//
//  SearchViewController.h
//  MyDeviceInventory
//
//  Created by Katterishetty, Sai Krishna on 11/28/12.
//  Copyright (c) 2012 Katterishetty, Sai Krishna. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController<UISearchBarDelegate, UITableViewDataSource , UITableViewDelegate>

@property (retain, nonatomic) IBOutlet UISearchBar *deviceSearchBar;
@property (retain, nonatomic) IBOutlet UITableView *searchView;

@end
