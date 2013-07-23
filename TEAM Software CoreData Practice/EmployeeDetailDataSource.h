//
//  EmployeeDetailDataSource.h
//  TEAM Software CoreData Practice
//
//  Created by Ryan Zulkoski on 7/23/13.
//  Copyright (c) 2013 RZGamer. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol EmployeeDetailDataSource <NSObject>
- (NSString *)employeeName;
- (NSString *)employeeID;
- (UIImage *)employeePhoto;
@end
