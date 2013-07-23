//
//  TEAMViewController.h
//  TEAM Software Practice
//
//  Created by Ryan Zulkoski on 7/20/13.
//  Copyright (c) 2013 RZGamer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectedEmployeeNameDelegate.h"

@interface MainVC : UIViewController <SelectedEmployeeNameDelegate>
- (void)nameOfSelectedEmployee:(NSString *)name;
@end
