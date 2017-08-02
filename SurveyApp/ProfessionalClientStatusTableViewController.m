//
//  ProfessionalClientStatusTableViewController.m
//  SurveyApp
//
//  Created by A on 10/07/2017.
//  Copyright © 2017 EmailsGmails. All rights reserved.
//

#import "ProfessionalClientStatusTableViewController.h"
#import "OperationPurposeTableViewController.h"
#import "ClientDescriptionTableViewController.h"
#import "SurveyContent.h"
#import "SurveyProgress.h"
#import "Utils.h"
#import "SurveyWorkflowManager.h"

@interface ProfessionalClientStatusTableViewController ()

@property (strong, nonatomic) IBOutlet UIButton *nextButton;
@property (nonatomic, assign) Boolean isBaseStep;
@property (strong, nonatomic) IBOutlet UILabel *stepLabel;
@property (weak, nonatomic) IBOutlet UILabel *noLabel;
@property (weak, nonatomic) IBOutlet UIImageView *noCheckmark;
@property (weak, nonatomic) IBOutlet UILabel *yesLabel;
@property (weak, nonatomic) IBOutlet UIImageView *yesCheckmark;

@end

@implementation ProfessionalClientStatusTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Title", nil);
    self.noLabel.text = NSLocalizedString(@"No", nil);
    self.yesLabel.text = NSLocalizedString(@"Yes", nil);
    [self.nextButton setTitle:NSLocalizedString(@"Next", nil) forState:UIControlStateNormal];
    self.stepLabel.text = [SurveyWorkflowManager getStepCountFromStep:SurveyStep_ProfessionalClientStatus fromSurvey:self.survey];
    [self updateCheckmarks];
//    self.question = NSLocalizedString(@"ProfessionalClientStatusQuestion", nil);
//    self.answerChoices = [NSArray arrayWithObjects:self.survey.isProfessionalClient, nil];
    // TODO : remake step counter somehow
//    self.isBaseStep = [Utils determineIfBaseQuestion:NSLocalizedString(@"ProfessionalClientStatusQuestion", nil)];
//    self.stepLabel.text = [Utils getStepLabelWithCondition:isBaseStep];
    // TODO: move to storyboard
//    self.nextButton.enabled = NO;
//    self.nextButton.backgroundColor = [UIColor grayColor];
}

- (IBAction)cancelSurveyButton:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
    // TODO : create workflow manager (self.survey = new survey)
//    [WorkflowManager cancelSurvey];
}

- (IBAction)nextButton:(id)sender {
    NSLog(@"Selected choice: %@", [self.survey.isProfessionalClient isEqual:@(YES)] ? @"Yes" : @"No");
    [self nextStepForSurvey:self.survey currentStep:SurveyStep_ProfessionalClientStatus];
//    if (self.isBaseStep) {
//        [[SurveyProgress.surveyProgress baseQuestions] addObject:question];
//    }
//    NSLog(@"Selected choice: %@", self.survey.isProfessionalClient ? @"No" : @"Yes");
//    if ([self.survey.isProfessionalClient isEqual:@YES]) {
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        OperationPurposeTableViewController *uvc = [storyboard instantiateViewControllerWithIdentifier:@"ClientDescription"];
//        uvc.survey = self.survey;
//        [self.navigationController pushViewController:uvc animated:YES];
//    }
//    else {
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        ClientDescriptionTableViewController *uvc = [storyboard instantiateViewControllerWithIdentifier:@"OperationPurpose"];
//        uvc.survey = self.survey;
//        [self.navigationController pushViewController:uvc animated:YES];
//    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return NSLocalizedString(@"ProfessionalClientStatusQuestion", nil);
}

static const int yesCell = 0;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    
    self.survey.isProfessionalClient = indexPath.row == yesCell ? @(NO) : @(YES);
    [self updateCheckmarks];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - Navigation
/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void) updateCheckmarks
{
    self.yesCheckmark.hidden = ![self.survey.isProfessionalClient isEqual:@(YES)];
    self.noCheckmark.hidden = ![self.survey.isProfessionalClient isEqual:@(NO)];
    
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

@end
