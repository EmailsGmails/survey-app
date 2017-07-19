//
//  Utils.h
//  SurveyApp
//
//  Created by Emils on 12.07.17.
//  Copyright © 2017. g. EmailsGmails. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

+ (NSString *) getStepLabelWithCondition:(Boolean)isBaseStep;
+ (Boolean) determineIfBaseQuestion:(NSString *)question;
+ (NSMutableArray *)parseAnswersToString:(NSMutableArray *)inputArray;

@end
