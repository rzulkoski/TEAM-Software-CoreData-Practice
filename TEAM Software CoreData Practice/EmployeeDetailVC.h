//
//  EmployeeDetailVC.h
//  TEAM Software Practice
//
//  Created by Ryan Zulkoski on 7/20/13.
//  Copyright (c) 2013 RZGamer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmployeeDetailDataSource.h"

@interface EmployeeDetailVC : UIViewController
@property (strong, nonatomic) id <EmployeeDetailDataSource> dataSource;
@end

