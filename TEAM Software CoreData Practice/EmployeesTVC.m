//
//  EmployeesTVC.m
//  TEAM Software Practice
//
//  Created by Ryan Zulkoski on 7/20/13.
//  Copyright (c) 2013 RZGamer. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "EmployeesTVC.h"
#import "EmployeeDetailVC.h"
#import "Employee.h"
#import "MainVC.h"

@interface EmployeesTVC ()
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSIndexPath *indexPathOfSelectedEmployee;

@end

@implementation EmployeesTVC

- (NSFetchedResultsController *)fetchedResultsController {
    if (!_fetchedResultsController) {
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Employee"];
        [fetchRequest setSortDescriptors:@[[[NSSortDescriptor alloc] initWithKey:@"employeeID" ascending:YES]]];
        
        _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                        managedObjectContext:self.managedObjectContext
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
        
        _fetchedResultsController.delegate = self;
        
        NSError *Error = nil;
        
        if ([_fetchedResultsController performFetch:&Error]) {
            NSLog(@"Fetch successful!");
        } else {
            NSLog(@"Fetch was unsuccessful...");
        }
    }
    
    return _fetchedResultsController;
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    NSLog(@"FRC content did change!");
    [self.tableView reloadData];
}

- (NSString *)employeeName
{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:self.indexPathOfSelectedEmployee];
    return cell.textLabel.text;
}

- (NSString *)employeeID
{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:self.indexPathOfSelectedEmployee];
    return cell.detailTextLabel.text;
}

- (UIImage *)employeePhoto
{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:self.indexPathOfSelectedEmployee];
    return cell.imageView.image;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [self.fetchedResultsController.sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"EmployeeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    Employee *employee = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = employee.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", [employee.employeeID intValue]];
    
    NSURL *thumbURL = [[NSURL alloc] initWithString:employee.thumbnailURL];
    
    dispatch_queue_t imageFetchQ = dispatch_queue_create("image fetcher", NULL);
    dispatch_async(imageFetchQ, ^{
        NSData *imageData = [[NSData alloc] initWithContentsOfURL:thumbURL];
        UIImage *image = [[UIImage alloc] initWithData:imageData];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!cell.imageView.image && image) {
                cell.imageView.image = image;
                [self.tableView reloadData];
            }
        });
    });
        
    return cell;
}

- (void)employeeSelectedAtIndexPath:(NSIndexPath *)indexPath
{
    self.indexPathOfSelectedEmployee = indexPath;
    Employee *selectedEmployee = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [self.delegate nameOfSelectedEmployee:selectedEmployee.name];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Set employee name on main screen and Pop view controller.
    [self employeeSelectedAtIndexPath:indexPath];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [self employeeSelectedAtIndexPath:indexPath];
    [self performSegueWithIdentifier:@"showEmployeeDetail" sender:indexPath];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    EmployeeDetailVC *employeeDetailVC = segue.destinationViewController;
    
    employeeDetailVC.dataSource = self;
}

@end
