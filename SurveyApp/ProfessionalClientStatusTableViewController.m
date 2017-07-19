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

@interface ProfessionalClientStatusTableViewController ()

@property (nonatomic,retain) NSIndexPath *checkedIndexPath ;
@property (strong, nonatomic) IBOutlet UIButton *nextButton;
@property (strong, nonatomic) NSString *question;
@property (strong, nonatomic) NSArray *answerChoices;
@property (nonatomic, strong) NSString *chosenOption;
@property (nonatomic, assign) Boolean isBaseStep;
@property (strong, nonatomic) IBOutlet UILabel *stepLabel;

@end

@implementation ProfessionalClientStatusTableViewController

@synthesize checkedIndexPath;
@synthesize nextButton;
@synthesize question;
@synthesize answerChoices;
@synthesize chosenOption;
@synthesize isBaseStep;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.question = [SurveyContent.surveyContent professionalClientStatusQuestion];
    self.answerChoices = [SurveyContent.surveyContent professionalClientStatusAnswerChoices];
    self.isBaseStep = [Utils determineIfBaseQuestion:question];
    self.stepLabel.text = [Utils getStepLabelWithCondition:isBaseStep];
    self.nextButton.enabled = NO;
    self.nextButton.backgroundColor = [UIColor grayColor];
}

- (void)viewWillAppear:(BOOL)animated {
    self.title = @"Financial Instrument Survey";
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.isMovingFromParentViewController) {
        if (self.isBaseStep) {
            [[SurveyProgress.surveyProgress baseQuestions] removeLastObject];
        }
        [SurveyProgress.surveyProgress setProfessionalClientStatusQuestion:nil];
        [SurveyProgress.surveyProgress setProfessionalClientStatusAnswer:nil];
    }
}

- (IBAction)cancelSurveyButton:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
    [SurveyProgress cancelSurvey];
}

- (IBAction)nextButton:(id)sender {
    [SurveyProgress.surveyProgress setProfessionalClientStatusQuestion:question];
    [SurveyProgress.surveyProgress setProfessionalClientStatusAnswer:chosenOption];
    if (self.isBaseStep) {
        [[SurveyProgress.surveyProgress baseQuestions] addObject:question];
    }
    NSLog(@"Selected choice: %@", chosenOption);
    if (chosenOption == [answerChoices objectAtIndex:0]) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *uvc = (OperationPurposeTableViewController*)[storyboard instantiateViewControllerWithIdentifier:@"OperationPurpose"];
        [self.navigationController pushViewController:uvc animated:YES];
    }
    else {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *uvc = (ClientDescriptionTableViewController*)[storyboard instantiateViewControllerWithIdentifier:@"ClientDescription"];
        [self.navigationController pushViewController:uvc animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return question;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [answerChoices objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:20];
    cell.backgroundColor = [UIColor colorWithRed:0/255.0 green:255/255.0 blue:167/255.0 alpha:1.0];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.answerChoices count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath{
    if(self.checkedIndexPath)
    {
        UITableViewCell* uncheckCell = [tableView
                                        cellForRowAtIndexPath:self.checkedIndexPath];
        uncheckCell.accessoryType = UITableViewCellAccessoryNone;
    }
    if([self.checkedIndexPath isEqual:indexPath])
    {
        self.checkedIndexPath = nil;
        self.chosenOption = nil;
        self.nextButton.enabled = NO;
        self.nextButton.backgroundColor = [UIColor grayColor];
    }
    else
    {
        UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        self.checkedIndexPath = indexPath;
        self.chosenOption = cell.textLabel.text;
        self.nextButton.enabled = YES;
        self.nextButton.backgroundColor = [UIColor colorWithRed:255/255.0 green:64/255.0 blue:100/255.0 alpha:1.0];
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