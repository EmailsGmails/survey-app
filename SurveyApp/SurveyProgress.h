//
//  SurveyProgress.h
//  SurveyApp
//
//  Created by Emils on 19.07.17.
//  Copyright © 2017. g. EmailsGmails. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SurveyProgress : NSObject

@property (nonatomic, strong) NSString *professionalClientStatusAnswer;
@property (nonatomic, strong) NSString *clientDescriptionAnswer;
@property (nonatomic, strong) NSMutableArray *operationPurposeAnswer;
@property (nonatomic, strong) NSString *financialActivityAnswer;
@property (nonatomic, strong) NSString *portfolioCostAnswer;
@property (nonatomic, strong) NSString *hasFinancialSectorPositionAnswer;
@property (nonatomic, strong) NSString *financialSectorPositionAnswer;

@property (nonatomic, strong) NSString *professionalClientStatusQuestion;
@property (nonatomic, strong) NSString *clientDescriptionQuestion;
@property (nonatomic, strong) NSString *operationPurposeQuestion;
@property (nonatomic, strong) NSString *financialActivityQuestion;
@property (nonatomic, strong) NSString *portfolioCostQuestion;
@property (nonatomic, strong) NSString *hasFinancialSectorPositionQuestion;
@property (nonatomic, strong) NSString *financialSectorPositionQuestion;

@property (nonatomic, strong) NSMutableArray *baseQuestions;
@property (nonatomic, strong) NSMutableArray *questions;
@property (nonatomic, strong) NSMutableArray *answers;

+(id) surveyProgress;
+(void) cancelSurvey;

+ (NSMutableArray *)getFilledQuestions;
+ (NSMutableArray *)getFilledAnswers;

@end
