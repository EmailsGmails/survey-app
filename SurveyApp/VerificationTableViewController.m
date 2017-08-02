//
//  VerificationTableViewController.m
//  SurveyApp
//
//  Created by Emils on 14.07.17.
//  Copyright © 2017. g. EmailsGmails. All rights reserved.
//

#import "VerificationTableViewController.h"
#import "SurveyContent.h"
#import "SurveyProgress.h"
#import "Utils.h"
#import "VerificationTableViewCell.h"
#import "SurveyWorkflowManager.h"

@interface VerificationTableViewController ()

@property (weak, nonatomic) IBOutlet UIButton *finishButton;
@property (strong, nonatomic) NSArray *answerOptionsClientDescription;
@property (strong, nonatomic) NSArray *answerOptionsOperationPurpose;
@property (strong, nonatomic) NSArray *answerOptionsPortfolioCost;
@property (strong, nonatomic) NSArray *answerOptionsFinancialSectorPosition;
@property (weak, nonatomic) IBOutlet UILabel *stepLabel;

@property (strong, nonatomic) NSArray *allCells;

@end

@implementation VerificationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Title", nil);
    self.answerOptionsClientDescription = [NSArray arrayWithObjects:
                              NSLocalizedString(@"ProfessionalClientDescriptionLicensed", nil),
                              NSLocalizedString(@"ProfessionalClientDescriptionCommercialCommunity", nil),
                              NSLocalizedString(@"ProfessionalClientDescriptionInvestmentCommercialCommunity", nil),
                              NSLocalizedString(@"ProfessionalClientDescriptionOther", nil), nil];
    self.answerOptionsOperationPurpose = [NSArray arrayWithObjects:
                              NSLocalizedString(@"OperationPurposeCapitalIncrement", nil),
                              NSLocalizedString(@"OperationPurposeStorage", nil),
                              NSLocalizedString(@"OperationPurposeSpeculativeOperations", nil),
                              NSLocalizedString(@"OperationPurposeThirdPersonService", nil),
                              NSLocalizedString(@"OperationPurposeFinancialMarketOperations", nil),
                              NSLocalizedString(@"OperationPurposeOther", nil), nil];
    self.answerOptionsPortfolioCost = [NSArray arrayWithObjects:
                              NSLocalizedString(@"PortfolioCostLessThan500ThousandEuros", nil),
                              NSLocalizedString(@"PortfolioCostMoreThan500ThousandEuros", nil), nil];
    self.answerOptionsFinancialSectorPosition = [NSArray arrayWithObjects:
                              NSLocalizedString(@"FinancialSectorPositionAnalyst", nil),
                              NSLocalizedString(@"FinancialSectorPositionBroker", nil),
                              NSLocalizedString(@"FinancialSectorPositionPortfolioManager", nil),
                              NSLocalizedString(@"FinancialSectorPositionInvestmentConsultant", nil),
                              NSLocalizedString(@"FinancialSectorPositionRegulationExpert", nil), nil];
    self.stepLabel.text = [SurveyWorkflowManager getStepCountFromStep:SurveyStep_Verification
                                                           fromSurvey:self.survey];
    self.allCells = [self answersForSurvey:self.survey];
}

- (IBAction)cancelSurveyButton:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (NSArray *) answersForSurvey:(SurveyProgress *)survey {
    NSMutableArray *steps = [NSMutableArray new];
    [steps addObject:[self isProfClientCell]];
    if ([survey.isProfessionalClient  isEqual: @(YES)]) {
        [steps addObject:[self clientDescriptionCell]];
    }
    [steps addObject:[self operationPurposeCell]];
    [steps addObject:[self financialActivityCell]];
    if ([survey.hasFinancialExperience  isEqual: @(YES)]) {
        [steps addObject:[self portfolioCostCell]];
    }
    [steps addObject:[self hasFinancialSectorPositionCell]];
    if ([survey.hasFinancialSectorPosition  isEqual: @(YES)]) {
        [steps addObject:[self financialSectorPositionCell]];
    }
    return steps;
}

- (UITableViewCell *) isProfClientCell {
    static NSString *cellIdentifier = @"VerificationCell";
    VerificationTableViewCell *cell;
    cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[VerificationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.questionLabel.text = NSLocalizedString(@"ProfessionalClientStatusQuestion", nil);
    cell.answerLabel.text = [self.survey.isProfessionalClient isEqual:@(YES)] ? @"Yes" : @"No";
    cell.backgroundColor = [UIColor colorWithRed:0/255.0 green:255/255.0 blue:167/255.0 alpha:1.0];
    return cell;
}

- (UITableViewCell *) clientDescriptionCell {
    static NSString *cellIdentifier = @"VerificationCell";
    VerificationTableViewCell *cell;
    cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[VerificationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.questionLabel.text = NSLocalizedString(@"ClientDescriptionQuestion", nil);
    cell.answerLabel.text = self.answerOptionsClientDescription[self.survey.clientDescription];
    cell.backgroundColor = [UIColor colorWithRed:0/255.0 green:255/255.0 blue:167/255.0 alpha:1.0];
    return cell;
}

- (UITableViewCell *) operationPurposeCell {
    static NSString *cellIdentifier = @"VerificationCell";
    VerificationTableViewCell *cell;
    cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[VerificationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSMutableArray *multipleAnswers = [NSMutableArray new];
    self.survey.operationPurpose = [[self.survey.operationPurpose sortedArrayUsingSelector: @selector(compare:)] mutableCopy];
    for (int i = 0; i < [self.survey.operationPurpose count]; i++) {
        NSInteger selectedChoice = [self.survey.operationPurpose[i] integerValue];
        [multipleAnswers addObject:self.answerOptionsOperationPurpose[selectedChoice]];
    }
    NSString *parsedAnswers = [multipleAnswers componentsJoinedByString: @"\n"];
    cell.questionLabel.text = NSLocalizedString(@"OperationPurposeQuestion", nil);
    cell.answerLabel.text = parsedAnswers;
    cell.answerLabel.numberOfLines = 0;
    cell.backgroundColor = [UIColor colorWithRed:0/255.0 green:255/255.0 blue:167/255.0 alpha:1.0];
    return cell;
}

- (UITableViewCell *) financialActivityCell {
    static NSString *cellIdentifier = @"VerificationCell";
    VerificationTableViewCell *cell;
    cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[VerificationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.questionLabel.text = NSLocalizedString(@"FinancialActivityQuestion", nil);
    cell.answerLabel.text = [self.survey.hasFinancialExperience isEqual:@(YES)] ? @"Yes" : @"No";
    cell.backgroundColor = [UIColor colorWithRed:0/255.0 green:255/255.0 blue:167/255.0 alpha:1.0];
    return cell;
}

- (UITableViewCell *) portfolioCostCell {
    static NSString *cellIdentifier = @"VerificationCell";
    VerificationTableViewCell *cell;
    cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[VerificationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.questionLabel.text = NSLocalizedString(@"PortfolioCostQuestion", nil);
    cell.answerLabel.text = self.answerOptionsPortfolioCost[self.survey.portfolioCost];
    cell.backgroundColor = [UIColor colorWithRed:0/255.0 green:255/255.0 blue:167/255.0 alpha:1.0];
    return cell;
}

- (UITableViewCell *) hasFinancialSectorPositionCell {
    static NSString *cellIdentifier = @"VerificationCell";
    VerificationTableViewCell *cell;
    cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[VerificationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.questionLabel.text = NSLocalizedString(@"HasFinancialSectorPositionQuestion", nil);
    cell.answerLabel.text = [self.survey.hasFinancialSectorPosition isEqual:@(YES)] ? @"Yes" : @"No";
    cell.backgroundColor = [UIColor colorWithRed:0/255.0 green:255/255.0 blue:167/255.0 alpha:1.0];
    return cell;
}

- (UITableViewCell *) financialSectorPositionCell {
    static NSString *cellIdentifier = @"VerificationCell";
    VerificationTableViewCell *cell;
    cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[VerificationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.questionLabel.text = NSLocalizedString(@"FinancialSectorPositionQuestion", nil);
    cell.answerLabel.text = self.answerOptionsFinancialSectorPosition[self.survey.financialSectorPosition];
    cell.backgroundColor = [UIColor colorWithRed:0/255.0 green:255/255.0 blue:167/255.0 alpha:1.0];
    return cell;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return NSLocalizedString(@"Verification", nil);
}

- (IBAction)finishButton:(id)sender {
    NSLog(@"Survey finished.");
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = self.allCells[indexPath.row];
    tableView.rowHeight = UITableViewAutomaticDimension;
    tableView.estimatedRowHeight = 140;
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return UITableViewAutomaticDimension;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.allCells count];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
