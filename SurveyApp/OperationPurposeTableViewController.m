//
//  OperationPurposeTableViewController.m
//  SurveyApp
//
//  Created by A on 10/07/2017.
//  Copyright © 2017 EmailsGmails. All rights reserved.
//

#import "OperationPurposeTableViewController.h"
#import "FinancialActivityTableViewController.h"
#import "QuestionTableViewCell.h"
#import "SurveyProgress.h"
#import "SurveyContent.h"
#import "Utils.h"
#import "SurveyWorkflowManager.h"

@interface OperationPurposeTableViewController ()
@property (nonatomic,retain) NSIndexPath *checkedIndexPath ;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UILabel *stepLabel;
@property (nonatomic, strong) NSArray *answerOptions;

@end

@implementation OperationPurposeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Title", nil);
    self.answerOptions = [NSArray arrayWithObjects:
                          NSLocalizedString(@"OperationPurposeCapitalIncrement", nil),
                          NSLocalizedString(@"OperationPurposeStorage", nil),
                          NSLocalizedString(@"OperationPurposeSpeculativeOperations", nil),
                          NSLocalizedString(@"OperationPurposeThirdPersonService", nil),
                          NSLocalizedString(@"OperationPurposeFinancialMarketOperations", nil),
                          NSLocalizedString(@"OperationPurposeOther", nil), nil];
    self.stepLabel.text = [SurveyWorkflowManager getStepCountFromStep:SurveyStep_OperationPurpose fromSurvey:self.survey];
    [self.nextButton setTitle:NSLocalizedString(@"Next", nil) forState:UIControlStateNormal];
}

- (IBAction)cancelSurveyButton:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)nextButton:(id)sender {
    NSLog(@"Chosen options %@", [self.survey.operationPurpose valueForKey:@"description"]);
    [self nextStepForSurvey:self.survey currentStep:SurveyStep_OperationPurpose];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return NSLocalizedString(@"OperationPurposeQuestion", nil);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"QuestionCell";
    QuestionTableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[QuestionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
//    if ([self.survey.operationPurpose objectAtIndex:indexPath.row] isEqual:)
    cell.questionLbl.text = self.answerOptions[indexPath.row];
    cell.checkmark.hidden = YES;
    cell.backgroundColor = [UIColor colorWithRed:0/255.0 green:255/255.0 blue:167/255.0 alpha:1.0];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.answerOptions.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath{
    QuestionTableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    if([self.checkedIndexPath isEqual:indexPath]) {
        [self.survey.operationPurpose removeObjectIdenticalTo:@(indexPath.row)];
        cell.checkmark.hidden = YES;
        self.checkedIndexPath = nil;
        if (!self.survey.operationPurpose.count) {
            self.nextButton.enabled = NO;
            self.nextButton.backgroundColor = [UIColor grayColor];
        }
    }
    else {
        if (cell.checkmark.hidden == NO) {
            [self.survey.operationPurpose removeObjectIdenticalTo:@(indexPath.row)];
            cell.checkmark.hidden = YES;
            self.checkedIndexPath = nil;
            if (!self.survey.operationPurpose.count) {
                self.nextButton.enabled = NO;
                self.nextButton.backgroundColor = [UIColor grayColor];
            }
        }
        else {
            [self.survey.operationPurpose addObject:@(indexPath.row)];
            cell.checkmark.hidden = NO;
            self.checkedIndexPath = indexPath;
            self.nextButton.enabled = YES;
            self.nextButton.backgroundColor = [UIColor colorWithRed:255/255.0 green:64/255.0 blue:100/255.0 alpha:1.0];
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
