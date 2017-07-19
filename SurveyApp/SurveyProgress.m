//
//  SurveyProgress.m
//  SurveyApp
//
//  Created by Emils on 19.07.17.
//  Copyright © 2017. g. EmailsGmails. All rights reserved.
//

#import "SurveyProgress.h"
#import <objc/runtime.h>

@implementation SurveyProgress

@synthesize professionalClientStatusAnswer;
@synthesize clientDescriptionAnswer;
@synthesize operationPurposeAnswer;
@synthesize financialActivityAnswer;
@synthesize portfolioCostAnswer;
@synthesize hasFinancialSectorPositionAnswer;
@synthesize financialSectorPositionAnswer;

@synthesize professionalClientStatusQuestion;
@synthesize clientDescriptionQuestion;
@synthesize operationPurposeQuestion;
@synthesize financialActivityQuestion;
@synthesize portfolioCostQuestion;
@synthesize hasFinancialSectorPositionQuestion;
@synthesize financialSectorPositionQuestion;

@synthesize baseQuestions;
@synthesize questions;
@synthesize answers;

+(id) surveyProgress {
    static SurveyProgress *surveyProgress = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        surveyProgress = [[self alloc] init];
    });
    return surveyProgress;
}

+ (NSMutableArray *)getFilledQuestions {
    [SurveyProgress.surveyProgress setQuestions:[[NSMutableArray alloc] init]];
    [SurveyProgress.surveyProgress setAnswers:[[NSMutableArray alloc] init]];
    if ([SurveyProgress.surveyProgress professionalClientStatusQuestion]) {
        [[SurveyProgress.surveyProgress questions] addObject:[SurveyProgress.surveyProgress professionalClientStatusQuestion]];
    }
    if ([SurveyProgress.surveyProgress clientDescriptionQuestion]) {
        [[SurveyProgress.surveyProgress questions] addObject:[SurveyProgress.surveyProgress clientDescriptionQuestion]];
    }
    if ([SurveyProgress.surveyProgress operationPurposeQuestion]) {
        [[SurveyProgress.surveyProgress questions] addObject:[SurveyProgress.surveyProgress operationPurposeQuestion]];
    }
    if ([SurveyProgress.surveyProgress financialActivityQuestion]) {
        [[SurveyProgress.surveyProgress questions] addObject:[SurveyProgress.surveyProgress financialActivityQuestion]];
    }
    if ([SurveyProgress.surveyProgress portfolioCostQuestion]) {
        [[SurveyProgress.surveyProgress questions] addObject:[SurveyProgress.surveyProgress portfolioCostQuestion]];
    }
    if ([SurveyProgress.surveyProgress hasFinancialSectorPositionQuestion]) {
        [[SurveyProgress.surveyProgress questions] addObject:[SurveyProgress.surveyProgress hasFinancialSectorPositionQuestion]];
    }
    if ([SurveyProgress.surveyProgress financialSectorPositionQuestion]) {
        [[SurveyProgress.surveyProgress questions] addObject:[SurveyProgress.surveyProgress financialSectorPositionQuestion]];
    }
    return [SurveyProgress.surveyProgress questions];
}

+ (NSMutableArray *)getFilledAnswers {
    
    if ([SurveyProgress.surveyProgress professionalClientStatusAnswer]) {
        [[SurveyProgress.surveyProgress answers] addObject:[SurveyProgress.surveyProgress professionalClientStatusAnswer]];
    }
    if ([SurveyProgress.surveyProgress clientDescriptionAnswer]) {
        [[SurveyProgress.surveyProgress answers] addObject:[SurveyProgress.surveyProgress clientDescriptionAnswer]];
    }
    if ([SurveyProgress.surveyProgress operationPurposeAnswer]) {
        [[SurveyProgress.surveyProgress answers] addObject:[SurveyProgress.surveyProgress operationPurposeAnswer]];
    }
    if ([SurveyProgress.surveyProgress financialActivityAnswer]) {
        [[SurveyProgress.surveyProgress answers] addObject:[SurveyProgress.surveyProgress financialActivityAnswer]];
    }
    if ([SurveyProgress.surveyProgress portfolioCostAnswer]) {
        [[SurveyProgress.surveyProgress answers] addObject:[SurveyProgress.surveyProgress portfolioCostAnswer]];
    }
    if ([SurveyProgress.surveyProgress hasFinancialSectorPositionAnswer]) {
        [[SurveyProgress.surveyProgress answers] addObject:[SurveyProgress.surveyProgress hasFinancialSectorPositionAnswer]];
    }
    if ([SurveyProgress.surveyProgress financialSectorPositionAnswer]) {
        [[SurveyProgress.surveyProgress answers] addObject:[SurveyProgress.surveyProgress financialSectorPositionAnswer]];
    }
    return [SurveyProgress.surveyProgress answers];
}

+(void) cancelSurvey {
    [SurveyProgress.surveyProgress setProfessionalClientStatusAnswer:nil];
    [SurveyProgress.surveyProgress setClientDescriptionAnswer:nil];
    [SurveyProgress.surveyProgress setOperationPurposeAnswer:nil];
    [SurveyProgress.surveyProgress setFinancialActivityAnswer:nil];
    [SurveyProgress.surveyProgress setPortfolioCostAnswer:nil];
    [SurveyProgress.surveyProgress setHasFinancialSectorPositionAnswer:nil];
    [SurveyProgress.surveyProgress setFinancialSectorPositionAnswer:nil];
    
    [SurveyProgress.surveyProgress setProfessionalClientStatusQuestion:nil];
    [SurveyProgress.surveyProgress setClientDescriptionQuestion:nil];
    [SurveyProgress.surveyProgress setOperationPurposeQuestion:nil];
    [SurveyProgress.surveyProgress setFinancialActivityQuestion:nil];
    [SurveyProgress.surveyProgress setPortfolioCostQuestion:nil];
    [SurveyProgress.surveyProgress setHasFinancialSectorPositionQuestion:nil];
    [SurveyProgress.surveyProgress setFinancialSectorPositionQuestion:nil];

    [SurveyProgress.surveyProgress setBaseQuestions:[NSMutableArray new]];
    [SurveyProgress.surveyProgress setQuestions:[NSMutableArray new]];
    [SurveyProgress.surveyProgress setAnswers:[NSMutableArray new]];
}

-(id) init {
    if (self = [super init]) {
        self.professionalClientStatusAnswer = nil;
        self.clientDescriptionAnswer = nil;
        self.operationPurposeAnswer = nil;
        self.financialActivityAnswer = nil;
        self.portfolioCostAnswer = nil;
        self.hasFinancialSectorPositionAnswer = nil;
        self.financialSectorPositionAnswer = nil;
        
        self.professionalClientStatusQuestion = nil;
        self.clientDescriptionQuestion = nil;
        self.operationPurposeQuestion = nil;
        self.financialActivityQuestion = nil;
        self.portfolioCostQuestion = nil;
        self.hasFinancialSectorPositionQuestion = nil;
        self.financialSectorPositionQuestion = nil;
        
        baseQuestions = [[NSMutableArray alloc] init];
        questions = [[NSMutableArray alloc] init];
        answers = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
