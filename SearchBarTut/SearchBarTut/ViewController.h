//
//  ViewController.h
//  SearchBarTut
//
//  Created by Karthik on 30/05/13.
//  Copyright (c) 2013 Karthik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UISearchBar *mySearchBar;

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@end
