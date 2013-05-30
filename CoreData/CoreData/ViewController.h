//
//  ViewController.h
//  CoreData
//
//  Created by Karthik on 29/05/13.
//  Copyright (c) 2013 Karthik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *firstnameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastnameTextField;
@property (weak, nonatomic) IBOutlet UILabel *displayLabel;

- (IBAction)AddPersonButtonClick:(id)sender;
- (IBAction)SearchButtonclick:(id)sender;
- (IBAction)DeleteButtonclick:(id)sender;
@end
