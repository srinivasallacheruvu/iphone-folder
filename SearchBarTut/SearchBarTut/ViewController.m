//
//  ViewController.m
//  SearchBarTut
//
//  Created by Karthik on 30/05/13.
//  Copyright (c) 2013 Karthik. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    NSMutableArray *totalStrings;
    NSMutableArray *filteredStrings;
    BOOL isFiltered;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.mySearchBar.delegate=self;
    self.myTableView.delegate=self;
    self.myTableView.dataSource=self;
    totalStrings =[[NSMutableArray alloc]initWithObjects:@"one", @"two", @"three", @"four", @"five", @"six",nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (searchText==0) {
        isFiltered=NO;
    }else{
        isFiltered=YES;
        filteredStrings=[[NSMutableArray alloc]init];
        for (NSString *str in totalStrings) {
            NSRange stringRange=[str rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (stringRange.location !=NSNotFound) {
                [filteredStrings addObject:str];
            }
        }
        
    }
[[self myTableView]reloadData];
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self.myTableView resignFirstResponder];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (isFiltered) {
        return filteredStrings.count;
    }else{
        return totalStrings.count;
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Cellidentifier=@"Cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:Cellidentifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cellidentifier];
        
    }
    if (isFiltered) {
    
    cell.textLabel.text=[totalStrings objectAtIndex:indexPath.row];
    }else{
        cell.textLabel.text=[filteredStrings objectAtIndex:indexPath.row];
        
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
   // displayLabel.text=[arrayOfNames objectAtIndex:indexPath.row];
}

@end
