//
//  FinancialActivityTableViewController.m
//  SurveyApp
//
//  Created by Emils on 14.07.17.
//  Copyright © 2017. g. EmailsGmails. All rights reserved.
//

#import "FinancialActivityTableViewController.h"
#import "FinancialSectorPositionTableViewController.h"
#import "PortfolioCostTableViewController.h"
#import "SurveyProgress.h"
#import "SurveyContent.h"
#import "Utils.h"
#import "SurveyWorkflowManager.h"

@interface FinancialActivityTableViewController ()

@property (nonatomic,retain) NSIndexPath *checkedIndexPath;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UILabel *stepLabel;
@property (weak, nonatomic) IBOutlet UILabel *noLbl;
@property (weak, nonatomic) IBOutlet UIImageView *noCheckmark;
@property (weak, nonatomic) IBOutlet UILabel *yesLbl;
@property (weak, nonatomic) IBOutlet UIImageView *yesCheckmark;

@end

@implementation FinancialActivityTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Title", nil);
    self.noLbl.text = NSLocalizedString(@"FinancialActivityHasNotPreviouslyCommitted", nil);
    self.yesLbl.text = NSLocalizedString(@"FinancialActivityHasPreviouslyCommitted", nil);
    self.stepLabel.text = [SurveyWorkflowManager getStepCountFromStep:SurveyStep_FinancialActivity fromSurvey:self.survey];
    [self.nextButton setTitle:NSLocalizedString(@"Next", nil) forState:UIControlStateNormal];
    [self updateCheckmarks];
}

- (IBAction)cancelSurveyButton:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)nextButton:(id)sender {
    NSLog(@"Selected choice: %@", [self.survey.hasFinancialExperience isEqual:@(YES)] ? @"Yes" : @"No");
    [self nextStepForSurvey:self.survey currentStep:SurveyStep_FinancialActivity];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return NSLocalizedString(@"FinancialActivityQuestion", nil);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

static const int yesCell = 0;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath{
    self.survey.hasFinancialExperience = indexPath.row == yesCell ? @(NO) : @(YES);
    
    [self updateCheckmarks];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void) updateCheckmarks
{
    self.yesCheckmark.hidden = ![self.survey.hasFinancialExperience isEqual:@(YES)];
    self.noCheckmark.hidden = ![self.survey.hasFinancialExperience isEqual:@(NO)];
    
    if(!self.yesCheckmark.hidden || !self.noCheckmark.hidden)
    {
        self.nextButton.enabled = YES;
        self.nextButton.backgroundColor = [UIColor colorWithRed:255/255.0 green:64/255.0 blue:100/255.0 alpha:1.0];
    }
    else
    {
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
