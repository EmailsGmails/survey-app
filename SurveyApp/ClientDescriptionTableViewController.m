//
//  ProfessionalClientStatusTableViewController.m
//  SurveyApp
//
//  Created by A on 10/07/2017.
//  Copyright © 2017 EmailsGmails. All rights reserved.
//

#import "ClientDescriptionTableViewController.h"
#import "OperationPurposeTableViewController.h"
#import "SurveyProgress.h"
#import "SurveyContent.h"
#import "Utils.h"
#import "QuestionTableViewCell.h"
#import "InvestSurveyEnums.h"
#import "SurveyWorkflowManager.h"

@interface ClientDescriptionTableViewController ()

@property (nonatomic,retain) NSIndexPath *checkedIndexPath;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UILabel *stepLabel;
@property (nonatomic, strong) NSArray *answerOptions;

@end

@implementation ClientDescriptionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Title", nil);
    self.answerOptions = [NSArray arrayWithObjects:NSLocalizedString(@"ProfessionalClientDescriptionLicensed", nil),
                        NSLocalizedString(@"ProfessionalClientDescriptionCommercialCommunity", nil),
                        NSLocalizedString(@"ProfessionalClientDescriptionInvestmentCommercialCommunity", nil),
                          NSLocalizedString(@"ProfessionalClientDescriptionOther", nil), nil];
    self.stepLabel.text = [SurveyWorkflowManager getStepCountFromStep:SurveyStep_ProfessionalClientDescription fromSurvey:self.survey];
    [self.nextButton setTitle:NSLocalizedString(@"Next", nil) forState:UIControlStateNormal];
    
}

- (IBAction)cancelSurveyButton:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)nextButton:(id)sender {
    NSLog(@"Selected choice: %u", self.survey.clientDescription);
    [self nextStepForSurvey:self.survey currentStep:SurveyStep_ProfessionalClientDescription];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return NSLocalizedString(@"ClientDescriptionQuestion", nil);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"QuestionCell";
    QuestionTableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[QuestionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    [self updateCheckmarks:cell atPath:indexPath];
    cell.questionLbl.text = self.answerOptions[indexPath.row];
    cell.backgroundColor = [UIColor colorWithRed:0/255.0 green:255/255.0 blue:167/255.0 alpha:1.0];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.answerOptions count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    if(self.checkedIndexPath) {
        QuestionTableViewCell* uncheckCell = [tableView cellForRowAtIndexPath:self.checkedIndexPath];
        uncheckCell.checkmark.hidden = YES;
    }
    self.checkedIndexPath = indexPath;
    self.survey.clientDescription = (ClientDescription)indexPath.row;
    self.nextButton.backgroundColor = [UIColor colorWithRed:255/255.0 green:64/255.0 blue:100/255.0 alpha:1.0];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [tableView reloadData];
    }

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

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

@end
