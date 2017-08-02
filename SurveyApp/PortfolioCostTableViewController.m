//
//  PortfolioCostTableViewController.m
//  SurveyApp
//
//  Created by Emils on 14.07.17.
//  Copyright © 2017. g. EmailsGmails. All rights reserved.
//

#import "PortfolioCostTableViewController.h"
#import "FinancialSectorPositionTableViewController.h"
#import "QuestionTableViewCell.h"
#import "SurveyContent.h"
#import "SurveyProgress.h"
#import "Utils.h"
#import "SurveyWorkflowManager.h"

@interface PortfolioCostTableViewController ()

@property (nonatomic,retain) NSIndexPath *checkedIndexPath;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) NSString *question;
@property (weak, nonatomic) NSArray *answerOptions;
@property (nonatomic, strong) NSString *chosenOption;
@property (nonatomic, assign) Boolean isBaseStep;
@property (weak, nonatomic) IBOutlet UILabel *stepLabel;

@end

@implementation PortfolioCostTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Title", nil);
    self.answerOptions = [NSArray arrayWithObjects:NSLocalizedString(@"PortfolioCostLessThan500ThousandEuros", nil),
                          NSLocalizedString(@"PortfolioCostMoreThan500ThousandEuros", nil), nil];
    self.stepLabel.text = [SurveyWorkflowManager getStepCountFromStep:SurveyStep_PortfolioCost fromSurvey:self.survey];
    [self.nextButton setTitle:NSLocalizedString(@"Next", nil) forState:UIControlStateNormal];
}

- (IBAction)cancelSurveyButton:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)nextButton:(id)sender {
    NSLog(@"Selected choice: %@", self.chosenOption);
    [self nextStepForSurvey:self.survey currentStep:SurveyStep_PortfolioCost];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return NSLocalizedString(@"PortfolioCostQuestion", nil);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"QuestionCell";
    QuestionTableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[QuestionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    [self updateCheckmarks:cell atPath:indexPath];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.answerOptions count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath{
    if(self.checkedIndexPath) {
        QuestionTableViewCell* uncheckCell = [tableView cellForRowAtIndexPath:self.checkedIndexPath];
        uncheckCell.checkmark.hidden = YES;
    }
    QuestionTableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.checkmark.hidden = NO;
    self.checkedIndexPath = indexPath;
    self.chosenOption = cell.questionLbl.text;
    self.survey.portfolioCost = (PortfolioCost)indexPath.row;
    self.nextButton.enabled = YES;
    self.nextButton.backgroundColor = [UIColor colorWithRed:255/255.0 green:64/255.0 blue:100/255.0 alpha:1.0];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [tableView reloadData];
}

- (void) updateCheckmarks:(QuestionTableViewCell *)cell atPath:(NSIndexPath *)indexPath
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
