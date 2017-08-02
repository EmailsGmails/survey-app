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

@property (nonatomic, assign) BOOL isProfessionalClient;

@property (nonatomic, strong) NSString *professionalClientDescriptionLicensed;
@property (nonatomic, strong) NSString *professionalClientDescriptionCommercialCommunity;
@property (nonatomic, strong) NSString *professionalClientDescriptionInvestmentCommercialCommunity;
@property (nonatomic, strong) NSString *professionalClientDescriptionOther;

@property (nonatomic, strong) NSString *operationPurposeCapitalIncrement;
@property (nonatomic, strong) NSString *operationPurposeStorage;
@property (nonatomic, strong) NSString *operationPurposeSpeculativeOperations;
@property (nonatomic, strong) NSString *operationPurposeThirdPersonService;
@property (nonatomic, strong) NSString *operationPurposeFinancialMarketOperations;
@property (nonatomic, strong) NSString *operationPurposeOther;

@property (nonatomic, assign) BOOL isFinancialActivityPreviouslyCommitted;

@property (nonatomic, assign) NSString *portfolioCostMoreThan500ThousandEuros;
@property (nonatomic, assign) NSString *portfolioCostLessThan500ThousandEuros;

@property (nonatomic, assign) Boolean *isInFinancialSector;
@property (nonatomic, strong) NSString *financialSectorPositionAnalyst;
@property (nonatomic, strong) NSString *financialSectorPositionBroker;
@property (nonatomic, strong) NSString *financialSectorPositionPortfolioManager;
@property (nonatomic, strong) NSString *financialSectorPositionInvestmentConsultant;
@property (nonatomic, strong) NSString *financialSectorPositionRegulationExpert;

+ (id)surveyContent;

@end
