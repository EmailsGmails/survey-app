////
////  Utils.m
////  SurveyApp
////
////  Created by Emils on 12.07.17.
////  Copyright © 2017. g. EmailsGmails. All rights reserved.
////
//
//#import "Utils.h"
//#import "SurveyContent.h"
//#import "SurveyProgress.h"
//
//static int STEP_UNIT = 1;
//static float HALF_STEP_UNIT = 0.5;
//
//@implementation Utils
//
//+ (NSString *) getStepLabelWithCondition:(Boolean)isBaseStep {
//    NSString *stepString;
//    if (isBaseStep) {
//        stepString = [NSString stringWithFormat:@"%lu", [[SurveyProgress.surveyProgress baseQuestions] count] + STEP_UNIT];
//    }
//    else {
//        stepString = [NSString stringWithFormat:@"%.1f", [[SurveyProgress.surveyProgress baseQuestions] count] + HALF_STEP_UNIT];
//    }
//    NSString *labelString = [NSString stringWithFormat:@"Step %@ of %lu", stepString,
//                             [[SurveyContent.surveyContent baseQuestionsArray] count]];
//    return labelString;
//}
//
//+ (Boolean) determineIfBaseQuestion:(NSString *)question {
//    for (int i = 0; i < [[SurveyContent.surveyContent baseQuestionsArray] count]; i++) {
//        if ([[[SurveyContent.surveyContent baseQuestionsArray] objectAtIndex:i] isEqualToString:question]) {
//            return true;
//        }
//    }
//    return false;
//}
//
//+ (NSMutableArray *)parseAnswersToString:(NSMutableArray *)inputArray {
//    NSMutableArray *parsedArray = [[NSMutableArray alloc] init];
//    
//    for (int i = 0; i < inputArray.count; i++) {
//        if ([[inputArray objectAtIndex:i] isKindOfClass:NSMutableArray.class]) {
//            NSMutableArray *multipleAnswers = [[NSMutableArray alloc] init];
//            for (int j = 0; j < [[inputArray objectAtIndex:i] count]; j++) {
//                [multipleAnswers addObject:[[inputArray objectAtIndex:i] objectAtIndex:j]];
//            }
//            [parsedArray addObject:[multipleAnswers componentsJoinedByString: @", "]];
//        }
//        else {
//            [parsedArray addObject:[inputArray objectAtIndex:i]];
//        }
//    }
//    
//    return parsedArray;
//}
//
//@end
