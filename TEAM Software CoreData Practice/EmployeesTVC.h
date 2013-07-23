//
//  EmployeesTVC.h
//  TEAM Software Practice
//
//  Created by Ryan Zulkoski on 7/20/13.
//  Copyright (c) 2013 RZGamer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmployeeDetailDataSource.h"
#import "SelectedEmployeeNameDelegate.h"

@interface EmployeesTVC : UITableViewController <NSFetchedResultsControllerDelegate, EmployeeDetailDataSource>
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) id <SelectedEmployeeNameDelegate> delegate;

// EmployeeDetailDataSource methods
- (NSString *)employeeName;
- (NSString *)employeeID;
- (UIImage *)employeePhoto;

@end
