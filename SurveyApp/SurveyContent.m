//
//  SurveyContent.m
//  SurveyApp
//
//  Created by A on 12.07.17.
//  Copyright © 2017. g. EmailsGmails. All rights reserved.
//

#import "SurveyContent.h"

@implementation SurveyContent : NSObject

@synthesize professionalClientStatusQuestion;
@synthesize clientDescriptionQuestion;
@synthesize operationPurposeQuestion;
@synthesize financialActivityQuestion;
@synthesize portfolioCostQuestion;
@synthesize hasFinancialSectorPositionQuestion;
@synthesize financialSectorPositionQuestion;

@synthesize baseQuestionsArray;
@synthesize optionalQuestions;

@synthesize professionalClientStatusAnswerChoices;
@synthesize clientDescriptionAnswerChoices;
@synthesize operationPurposeAnswerChoices;
@synthesize financialActivityAnswerChoices;
@synthesize portfolioCostAnswerChoices;
@synthesize financialSectorPositionAnswerChoices;
@synthesize hasFinancialSectorPositionAnswerChoices;

@synthesize baseAnswerChoices;
@synthesize optionalAnswerChoices;

+ (id)surveyContent {
    static SurveyContent *surveyContent = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        surveyContent = [[self alloc] init];
    });
    return surveyContent;
}

- (id)init {
    if (self = [super init]) {
        professionalClientStatusQuestion = @"Are you a professional client?";
        clientDescriptionQuestion = @"Describe yourself";
        operationPurposeQuestion = @"Operation purpose";
        financialActivityQuestion = @"Activity on financial market";
        portfolioCostQuestion = @"Your portfolio cost";
        hasFinancialSectorPositionQuestion = @"Did you have a position in the financial sector?";
        financialSectorPositionQuestion = @"Specify position";
        
        baseQuestionsArray = [NSArray arrayWithObjects: professionalClientStatusQuestion, operationPurposeQuestion, financialActivityQuestion, hasFinancialSectorPositionQuestion, nil];
        optionalQuestions = [NSArray arrayWithObjects: clientDescriptionQuestion, portfolioCostQuestion, financialSectorPositionQuestion, nil];
        
        professionalClientStatusAnswerChoices = [NSArray arrayWithObjects: @"No", @"Yes", nil];
        clientDescriptionAnswerChoices = [NSArray arrayWithObjects: @"Licensed", @"Commercial community", @"Investment commercial community", @"None of the above", nil];
        operationPurposeAnswerChoices = [NSArray arrayWithObjects: @"Capital increment", @"Storage", @"Speculative operations", @"Third person service", @"Financial market operations", @"Other", nil];
        financialActivityAnswerChoices = [NSArray arrayWithObjects: @"Previously not committed", @"Previously committed", nil];
        portfolioCostAnswerChoices = [NSArray arrayWithObjects: @"Less than 500 000 EUR", @"More than 500 000 EUR", nil];
        hasFinancialSectorPositionAnswerChoices = [NSArray arrayWithObjects: @"No", @"Yes", nil];
        financialSectorPositionAnswerChoices = [NSArray arrayWithObjects: @"Analyst", @"Broker", @"Portfolio Manager", @"Investment consultant", @"Regulation expert", nil];

        baseAnswerChoices = [NSArray arrayWithObjects:professionalClientStatusAnswerChoices, operationPurposeAnswerChoices, financialActivityAnswerChoices, hasFinancialSectorPositionAnswerChoices, nil];
        optionalAnswerChoices = [NSArray arrayWithObjects:clientDescriptionAnswerChoices, portfolioCostAnswerChoices, financialSectorPositionAnswerChoices, nil];
    }
    return self;
}
@end
