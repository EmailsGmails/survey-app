//
//  ControllerUtilsTableViewController.h
//  SurveyApp
//
//  Created by Emils on 18.07.17.
//  Copyright © 2017. g. EmailsGmails. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ControllerUtilsTableViewController : UITableViewController
+(NSString *) getStepString:(float)currentStep withCondition:(Boolean)isBaseStep;

@end
