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

@synthesize isProfessionalClient;
@synthesize professionalClientDescriptionLicensed;
@synthesize professionalClientDescriptionCommercialCommunity;
@synthesize professionalClientDescriptionInvestmentCommercialCommunity;
@synthesize professionalClientDescriptionOther;

@synthesize operationPurposeCapitalIncrement;
@synthesize operationPurposeStorage;
@synthesize operationPurposeSpeculativeOperations;
@synthesize operationPurposeThirdPersonService;
@synthesize operationPurposeFinancialMarketOperations;
@synthesize operationPurposeOther;

@synthesize isFinancialActivityPreviouslyCommitted;

@synthesize portfolioCostMoreThan500ThousandEuros;
@synthesize portfolioCostLessThan500ThousandEuros;

@synthesize isInFinancialSector;
@synthesize financialSectorPositionAnalyst;
@synthesize financialSectorPositionBroker;
@synthesize financialSectorPositionPortfolioManager;
@synthesize financialSectorPositionInvestmentConsultant;
@synthesize financialSectorPositionRegulationExpert;


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
        professionalClientStatusQuestion = NSLocalizedString(@"ProfessionalClientStatusQuestion", nil);
        clientDescriptionQuestion = NSLocalizedString(@"ClientDescriptionQuestion", nil);
        operationPurposeQuestion = NSLocalizedString(@"OperationPurposeQuestion", nil);
        financialActivityQuestion = NSLocalizedString(@"FinancialActivityQuestion", nil);
        portfolioCostQuestion = NSLocalizedString(@"PortfolioCostQuestion", nil);
        hasFinancialSectorPositionQuestion = NSLocalizedString(@"HasFinancialSectorPositionQuestion", nil);
        financialSectorPositionQuestion = NSLocalizedString(@"FinancialSectorPositionQuestion", nil);
        
        isProfessionalClient = nil;

        professionalClientDescriptionLicensed = NSLocalizedString(@"ProfessionalClientDescriptionLicensed", nil);
        professionalClientDescriptionCommercialCommunity = NSLocalizedString(@"ProfessionalClientDescriptionCommercialCommunity", nil);
        professionalClientDescriptionInvestmentCommercialCommunity = NSLocalizedString(@"ProfessionalClientDescriptionInvestmentCommercialCommunity", nil);
        professionalClientDescriptionOther = NSLocalizedString(@"ProfessionalClientDescriptionOther", nil);
        
        operationPurposeCapitalIncrement = NSLocalizedString(@"OperationPurposeCapitalIncrement", nil);
        operationPurposeStorage = NSLocalizedString(@"OperationPurposeStorage", nil);
        operationPurposeSpeculativeOperations = NSLocalizedString(@"OperationPurposeSpeculativeOperations", nil);
        operationPurposeThirdPersonService = NSLocalizedString(@"OperationPurposeThirdPersonService", nil);
        operationPurposeFinancialMarketOperations = NSLocalizedString(@"OperationPurposeFinancialMarketOperations", nil);
        operationPurposeOther = NSLocalizedString(@"OperationPurposeOther", nil);
        
        isFinancialActivityPreviouslyCommitted = nil;
        
        portfolioCostMoreThan500ThousandEuros;
        portfolioCostLessThan500ThousandEuros;
        isInFinancialSector;
        financialSectorPositionAnalyst;
        financialSectorPositionBroker;
        financialSectorPositionPortfolioManager;
        financialSectorPositionInvestmentConsultant;
        financialSectorPositionRegulationExpert;
    }
    return self;
}
@end
