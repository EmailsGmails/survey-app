//
//  SurveyContent.h
//  SurveyApp
//
//  Created by A on 12.07.17.
//  Copyright © 2017. g. EmailsGmails. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SurveyContent : NSObject

@property (nonatomic, strong) NSString *professionalClientStatusQuestion;
@property (nonatomic, strong) NSString *clientDescriptionQuestion;
@property (nonatomic, strong) NSString *operationPurposeQuestion;
@property (nonatomic, strong) NSString *financialActivityQuestion;
@property (nonatomic, strong) NSString *portfolioCostQuestion;
@property (nonatomic, strong) NSString *hasFinancialSectorPositionQuestion;
@property (nonatomic, strong) NSString *financialSectorPositionQuestion;

@property (nonatomic, strong) NSArray *baseQuestionsArray;
@property (nonatomic, strong) NSArray *optionalQuestions;

@property (nonatomic, strong) NSArray *professionalClientStatusAnswerChoices;
@property (nonatomic, strong) NSArray *clientDescriptionAnswerChoices;
@property (nonatomic, strong) NSArray *operationPurposeAnswerChoices;
@property (nonatomic, strong) NSArray *financialActivityAnswerChoices;
@property (nonatomic, strong) NSArray *portfolioCostAnswerChoices;
@property (nonatomic, strong) NSArray *hasFinancialSectorPositionAnswerChoices;
@property (nonatomic, strong) NSArray *financialSectorPositionAnswerChoices;

@property (nonatomic, strong) NSArray *baseAnswerChoices;
@property (nonatomic, strong) NSArray *optionalAnswerChoices;

+ (id)surveyContent;

@end
