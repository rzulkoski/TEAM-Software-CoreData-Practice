//
//  Employee.h
//  TEAM Software CoreData Practice
//
//  Created by Ryan Zulkoski on 7/20/13.
//  Copyright (c) 2013 RZGamer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Employee : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * employeeID;
@property (nonatomic, retain) NSString * thumbnailURL;

@end
