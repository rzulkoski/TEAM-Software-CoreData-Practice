//
//  TEAMViewController.m
//  TEAM Software Practice
//
//  Created by Ryan Zulkoski on 7/20/13.
//  Copyright (c) 2013 RZGamer. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "MainVC.h"
#import "EmployeesTVC.h"
#import "Employee.h"

@interface MainVC ()
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (weak, nonatomic) IBOutlet UIButton *employeeNameButton;
@end

@implementation MainVC

- (NSManagedObjectContext *)managedObjectContext {
    if (!_managedObjectContext) {
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        _managedObjectContext = appDelegate.managedObjectContext;
    }
    return _managedObjectContext;
}

- (void)nameOfSelectedEmployee:(NSString *)name {
    self.employeeNameButton.titleLabel.text = name;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self insertSampleData];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)pressedEmployee {
    [self performSegueWithIdentifier:@"showEmployees" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    EmployeesTVC *employeeTVC = segue.destinationViewController;
    employeeTVC.managedObjectContext = self.managedObjectContext;
    employeeTVC.delegate = self;
}

- (void)insertSampleData {
    [self insertNewEmployeeWithID:18 name:@"Ryan Zulkoski" thumbnailURL:@"http://files.rzgamer.com/images/ryan.png"];
    [self insertNewEmployeeWithID:1001 name:@"Tysen Johnson" thumbnailURL:@"http://files.rzgamer.com/images/tysen.png"];
    [self insertNewEmployeeWithID:203 name:@"Marcus Nathan" thumbnailURL:@"http://files.rzgamer.com/images/marcus.png"];

    NSError *Error = nil;
    
    if ([self.managedObjectContext save:&Error]) {
        NSLog(@"Save Was Successful!");
    } else {
        NSLog(@"Save Failed!");
    }
}

- (void)insertNewEmployeeWithID:(int)employeeID name:(NSString *)name thumbnailURL:(NSString *)thumbnailURL
{
    Employee *employee = [NSEntityDescription insertNewObjectForEntityForName:@"Employee"
                                                       inManagedObjectContext:self.managedObjectContext];
    
    if (!employee) NSLog(@"Failed to create new employee!");
    
    employee.employeeID = @(employeeID);
    employee.name = name;
    employee.thumbnailURL = thumbnailURL;
}

@end
