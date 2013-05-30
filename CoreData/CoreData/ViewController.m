//
//  ViewController.m
//  CoreData
//
//  Created by Karthik on 29/05/13.
//  Copyright (c) 2013 Karthik. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
@interface ViewController (){
    NSManagedObjectContext *context;
    UIAlertView*loading;
    
}

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self firstnameTextField]setDelegate:self];
    [[self lastnameTextField]setDelegate:self];
    //[[self displayLabel]setText:nil];
    AppDelegate *appdelegate=[[UIApplication sharedApplication]delegate];
    context=[appdelegate managedObjectContext];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)AddPersonButtonClick:(id)sender {
     NSLog(@"AddButtonClicked");
    
    if ([_firstnameTextField.text length]>0 || [_lastnameTextField.text length]>0) {
        
        // progerss view loading starts here
        loading = [[UIAlertView alloc] initWithTitle:@"data adding operation in progress" message:@"Please Wait..." delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
        UIActivityIndicatorView *progress= [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(125, 50, 30, 30)];
        progress.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        [loading addSubview:progress];
        [progress startAnimating];
        
        [loading show];
        
        NSEntityDescription *entitydesc=[NSEntityDescription entityForName:@"Person" inManagedObjectContext:context];
        NSManagedObject *newPerson=[[NSManagedObject alloc]initWithEntity:entitydesc insertIntoManagedObjectContext:context];
        [newPerson setValue:self.firstnameTextField.text forKey:@"firstname"];
        [newPerson setValue:self.lastnameTextField.text forKey:@"lastname"];
        NSError *error;
        [context save:&error];
        self.displayLabel.text=@"Person added successfully!";
        
        
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Welcome to my app!"
                                                        message:@"Please enter first & last name!!"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
    }
  
      [loading dismissWithClickedButtonIndex:0 animated:YES];
    [[self firstnameTextField]setText:nil];
    [[self lastnameTextField]setText:nil];
    
}

- (IBAction)SearchButtonclick:(id)sender {
     NSLog(@"SearchButtonClicked");
    loading = [[UIAlertView alloc] initWithTitle:@" Searching operation in progress" message:@"Please Wait..." delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    UIActivityIndicatorView *progress= [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(125, 50, 30, 30)];
    progress.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [loading addSubview:progress];
    [progress startAnimating];
    
    [loading show];
     NSEntityDescription *entitydesc=[NSEntityDescription entityForName:@"Person" inManagedObjectContext:context];
    NSFetchRequest *request=[[NSFetchRequest alloc]init];
    [request setEntity:entitydesc];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"firstname like %@ and lastname like %@",self.firstnameTextField.text,self.lastnameTextField.text];
    [request setPredicate:predicate];
    NSError *error;
    NSArray *matchingData=[context executeFetchRequest:request error:&error];
    if (matchingData.count==0) {
        self.displayLabel.text=@"No Person found!";
    }else{
        NSString *firstname;
        NSString *lastname;
        for (NSManagedObject *obj in matchingData) {
            firstname=[obj valueForKey:@"firstname"];
            lastname=[obj valueForKey:@"lastname"];
            
        }
        self.displayLabel.text=[NSString stringWithFormat:@"Person Found with %@,%@", firstname,lastname ];
        //self.displayLabel.text=@"Person added successfully!";
        [loading dismissWithClickedButtonIndex:0 animated:YES];
        
    }
    
    
}

- (IBAction)DeleteButtonclick:(id)sender {
    NSLog(@"DeleteButtonClicked");
    loading = [[UIAlertView alloc] initWithTitle:@"delete operation in progress" message:@"Please Wait..." delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    UIActivityIndicatorView *progress= [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(125, 50, 30, 30)];
    progress.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [loading addSubview:progress];
    [progress startAnimating];
    
    [loading show];
    NSEntityDescription *entitydesc=[NSEntityDescription entityForName:@"Person" inManagedObjectContext:context];
    NSFetchRequest *request=[[NSFetchRequest alloc]init];
    [request setEntity:entitydesc];
    [request setEntity:entitydesc];
     NSPredicate *predicate=[NSPredicate predicateWithFormat:@"firstname like %@ ",self.firstnameTextField.text];
    [request setPredicate:predicate];
    NSError *error;
    NSArray *matchingData=[context executeFetchRequest:request error:&error];
    if (matchingData.count==0) {
        self.displayLabel.text=@"No Person delete!!";
    }else{
        int count = 0;
     
        for (NSManagedObject *obj in matchingData) {
           
            [context deleteObject:obj];
             count++;
        }
        
        [context save:&error];
        self.displayLabel.text=[NSString stringWithFormat:@"%d Person deleted successfully!",count];
        [loading dismissWithClickedButtonIndex:0 animated:YES];
          }

    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
     NSLog(@"textFieldShouldReturn");
    return [textField resignFirstResponder];
}
@end
