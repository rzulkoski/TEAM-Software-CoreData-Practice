//
//  EmployeeDetailVC.m
//  TEAM Software Practice
//
//  Created by Ryan Zulkoski on 7/20/13.
//  Copyright (c) 2013 RZGamer. All rights reserved.
//

#import "EmployeeDetailVC.h"

@interface EmployeeDetailVC ()
@property (weak, nonatomic) IBOutlet UILabel *employeeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *employeeIDLabel;
@property (weak, nonatomic) IBOutlet UIImageView *employeePhotoImageView;
@end

@implementation EmployeeDetailVC

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
    
    self.employeeIDLabel.text = [self.dataSource employeeID];
    self.employeeNameLabel.text = [self.dataSource employeeName];
    self.employeePhotoImageView.image = [self.dataSource employeePhoto];
}

@end
