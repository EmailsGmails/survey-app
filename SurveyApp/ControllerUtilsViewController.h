//
//  ControllerUtilsViewController.h
//  SurveyApp
//
//  Created by Emils on 17.07.17.
//  Copyright © 2017. g. EmailsGmails. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ControllerUtilsViewController : UIViewController

+(NSString) getStepString:(float)currentStep withCondition:(Boolean)isBaseStep;

@end
