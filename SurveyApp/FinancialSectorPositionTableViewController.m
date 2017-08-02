//
//  FinancialSectorPositionTableViewController.m
//  SurveyApp
//
//  Created by Emils on 14.07.17.
//  Copyright © 2017. g. EmailsGmails. All rights reserved.
//

#import "FinancialSectorPositionTableViewController.h"
#import "VerificationTableViewController.h"
#import "SurveyContent.h"
#import "SurveyProgress.h"
#import "Utils.h"
#import "QuestionTableViewCell.h"
#import "SurveyWorkflowManager.h"

@interface FinancialSectorPositionTableViewController ()

@property (nonatomic,retain) NSIndexPath *checkedIndexPath;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (strong, nonatomic) NSString *questionOne;
@property (strong, nonatomic) NSString *questionTwo;
@property (strong, nonatomic) NSArray *answerOptionsHasFinancialSectorPosition;
@property (strong, nonatomic) NSArray *answerOptionsFinancialSectorPosition;
@property (strong, nonatomic) NSArray *answerOptions;
@property (nonatomic, strong) NSMutableArray *chosenOptions;
@property (nonatomic, assign) Boolean isBaseStep;
@property (nonatomic, assign) float currentStep;
@property (strong, nonatomic) IBOutlet UILabel *stepLabel;
@property (assign, nonatomic) Boolean showSecondQuestion;

@end

@implementation FinancialSectorPositionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Title", nil);
    self.answerOptionsHasFinancialSectorPosition = [NSArray arrayWithObjects:NSLocalizedString(@"No", nil),
                                                NSLocalizedString(@"Yes", nil), nil];
    self.answerOptionsFinancialSectorPosition = [NSArray arrayWithObjects:NSLocalizedString(@"FinancialSectorPositionAnalyst", nil),
                          NSLocalizedString(@"FinancialSectorPositionBroker", nil),
                          NSLocalizedString(@"FinancialSectorPositionPortfolioManager", nil),
                          NSLocalizedString(@"FinancialSectorPositionInvestmentConsultant", nil),
                          NSLocalizedString(@"FinancialSectorPositionRegulationExpert", nil), nil];
    self.answerOptions = [NSArray arrayWithObjects:self.answerOptionsHasFinancialSectorPosition,
                        self.answerOptionsFinancialSectorPosition, nil];
    self.questionOne = NSLocalizedString(@"HasFinancialSectorPositionQuestion", nil);
    self.questionTwo = NSLocalizedString(@"FinancialSectorPositionQuestion", nil);
    self.stepLabel.text = [SurveyWorkflowManager getStepCountFromStep:SurveyStep_FinancialSectorPosition
                                                       fromSurvey:self.survey];
    [self.nextButton setTitle:NSLocalizedString(@"Next", nil) forState:UIControlStateNormal];
    self.chosenOptions = [NSMutableArray arrayWithObjects: [NSNull null], [NSNull null], nil];
}


- (IBAction)cancelSurveyButton:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)nextButton:(id)sender {
    NSLog(@"Selected choice: %@", [self.survey.hasFinancialSectorPosition isEqual:@(YES)] ? @"Yes" : @"No");
    [self nextStepForSurvey:self.survey currentStep:SurveyStep_FinancialSectorPosition];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier;
    if (indexPath.section == 0) {
        cellIdentifier = @"QuestionOne";
    }
    else {
        cellIdentifier = @"QuestionTwo";
    }
    QuestionTableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[QuestionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.questionLbl.text = [[self.answerOptions objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    if (indexPath.section == 0) {
        [self updateCheckmarksSection0:cell atPath:indexPath];
    }
    else {
        [self updateCheckmarksSection1:cell atPath:indexPath];
    }
//    if (indexPath.section == 0 && indexPath.row == 0 && [self.survey.hasFinancialSectorPosition isEqual:@(NO)]) {
//        cell.checkmark.hidden = NO;
//        self.nextButton.enabled = YES;
//        self.nextButton.backgroundColor = [UIColor colorWithRed:255/255.0 green:64/255.0 blue:100/255.0 alpha:1.0];
//    }
//    else if (indexPath.section == 0 && indexPath.row == 1 && [self.survey.hasFinancialSectorPosition isEqual:@(YES)]) {
//        cell.checkmark.hidden = NO;
//        self.nextButton.enabled = YES;
//        self.nextButton.backgroundColor = [UIColor colorWithRed:255/255.0 green:64/255.0 blue:100/255.0 alpha:1.0];
//    }
//    else {
//        cell.checkmark.hidden = YES;
//        self.nextButton.enabled = NO;
//        self.nextButton.backgroundColor = [UIColor grayColor];
//    }
    cell.backgroundColor = [UIColor colorWithRed:0/255.0 green:255/255.0 blue:167/255.0 alpha:1.0];
    return cell;

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (!self.showSecondQuestion) {
        return 1;
    }
    else {
        return 2;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (!self.showSecondQuestion) {
        return self.questionOne;
    } else {
        NSArray *bothQuestions = [NSArray arrayWithObjects:self.questionOne, self.questionTwo, nil];
        return [bothQuestions objectAtIndex:section];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (!self.showSecondQuestion) {
        if (section==0) {
            return UITableViewAutomaticDimension;
        }
        else {
            return 0;
        }
    } else {
        return UITableViewAutomaticDimension;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.answerOptionsHasFinancialSectorPosition.count;
    }
    else {
        return self.answerOptionsFinancialSectorPosition.count;
    }
}

static const int yesCell = 0;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath{
    switch (indexPath.section) {
        case 0: {
            if(self.checkedIndexPath) {
                QuestionTableViewCell* uncheckCell = [tableView cellForRowAtIndexPath:self.checkedIndexPath];
                uncheckCell.checkmark.hidden = YES;
            }
            self.checkedIndexPath = indexPath;
            self.survey.hasFinancialSectorPosition = indexPath.row == yesCell ? @(NO) : @(YES);
            break;
        }
        case 1 : {
            if(self.checkedIndexPath) {
                QuestionTableViewCell* uncheckCell = [tableView cellForRowAtIndexPath:self.checkedIndexPath];
                uncheckCell.checkmark.hidden = YES;
            }
            self.checkedIndexPath = indexPath;
            self.survey.financialSectorPosition = (FinancialSectorPosition)indexPath.row;
            break;
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [tableView reloadData];
}

- (void) updateCheckmarksSection0:(QuestionTableViewCell *)cell atPath:(NSIndexPath *)indexPath
{
    if(self.checkedIndexPath) {
        QuestionTableViewCell* uncheckCell = [self.tableView cellForRowAtIndexPath:self.checkedIndexPath];
        uncheckCell.checkmark.hidden = YES;
    }
    if ([self.survey.hasFinancialSectorPosition isEqual:@(YES)]) {
        self.showSecondQuestion = YES;
        self.nextButton.enabled = NO;
        self.nextButton.backgroundColor = [UIColor grayColor];
    }
    else {
        self.showSecondQuestion = NO;
        self.nextButton.enabled = YES;
        self.nextButton.backgroundColor = [UIColor colorWithRed:255/255.0 green:64/255.0 blue:100/255.0 alpha:1.0];
    }
    cell.checkmark.hidden = NO;
}

- (void) updateCheckmarksSection1:(QuestionTableViewCell *)cell atPath:(NSIndexPath *)indexPath
{
    if (self.survey.clientDescription == indexPath.row) {
        cell.checkmark.hidden = NO;
        self.nextButton.enabled = YES;
        self.nextButton.backgroundColor = [UIColor colorWithRed:255/255.0 green:64/255.0 blue:100/255.0 alpha:1.0];
    }
    else {
        cell.checkmark.hidden = YES;
        self.nextButton.enabled = NO;
        self.nextButton.backgroundColor = [UIColor grayColor];
    }
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
