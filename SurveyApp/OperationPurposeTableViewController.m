//
//  OperationPurposeTableViewController.m
//  SurveyApp
//
//  Created by A on 10/07/2017.
//  Copyright © 2017 EmailsGmails. All rights reserved.
//

#import "OperationPurposeTableViewController.h"
#import "FinancialActivityTableViewController.h"
#import "SurveyProgress.h"
#import "SurveyContent.h"
#import "Utils.h"

@interface OperationPurposeTableViewController ()
@property (nonatomic,retain) NSIndexPath *checkedIndexPath ;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) NSString *question;
@property (weak, nonatomic) NSArray *answerChoices;
@property (strong, nonatomic) NSMutableArray *chosenOptions;
@property (nonatomic, assign) Boolean isBaseStep;
@property (weak, nonatomic) IBOutlet UILabel *stepLabel;

@end

@implementation OperationPurposeTableViewController
@synthesize checkedIndexPath;
@synthesize nextButton;
@synthesize question;
@synthesize answerChoices;
@synthesize chosenOptions;
@synthesize isBaseStep;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.question = [SurveyContent.surveyContent operationPurposeQuestion];
    self.answerChoices = [SurveyContent.surveyContent operationPurposeAnswerChoices];
    self.isBaseStep = [Utils determineIfBaseQuestion:question];
    self.stepLabel.text = [Utils getStepLabelWithCondition:isBaseStep];
    self.nextButton.enabled = NO;
    self.nextButton.backgroundColor = [UIColor grayColor];
    self.chosenOptions = [[NSMutableArray alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
    self.title = @"Financial Instrument Survey";
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.isMovingFromParentViewController) {
        if (self.isBaseStep) {
            [[SurveyProgress.surveyProgress baseQuestions] removeLastObject];
        }
        [SurveyProgress.surveyProgress setOperationPurposeQuestion:nil];
        [SurveyProgress.surveyProgress setOperationPurposeAnswer:nil];
    }
}

- (IBAction)cancelSurveyButton:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
    [SurveyProgress cancelSurvey];
}

- (IBAction)nextButton:(id)sender {
    [SurveyProgress.surveyProgress setOperationPurposeQuestion:question];
    [SurveyProgress.surveyProgress setOperationPurposeAnswer:chosenOptions];
    if (self.isBaseStep) {
        [[SurveyProgress.surveyProgress baseQuestions] addObject:question];
    }
    NSLog(@"Chosen options %@", [chosenOptions valueForKey:@"description"]);
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *uvc = (FinancialActivityTableViewController*)[storyboard instantiateViewControllerWithIdentifier:@"FinancialActivity"];
    [self.navigationController pushViewController:uvc animated:YES];

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
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    if([self.checkedIndexPath isEqual:indexPath])
    {
        [chosenOptions removeObjectIdenticalTo:cell.textLabel.text];
        cell.accessoryType = UITableViewCellAccessoryNone;
        self.checkedIndexPath = nil;
        if (!chosenOptions.count) {
            self.nextButton.enabled = NO;
            self.nextButton.backgroundColor = [UIColor grayColor];
        }
    }
    else
    {
        if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
            [chosenOptions removeObjectIdenticalTo:cell.textLabel.text];
            cell.accessoryType = UITableViewCellAccessoryNone;
            self.checkedIndexPath = nil;
            if (!chosenOptions.count) {
                self.nextButton.enabled = NO;
                self.nextButton.backgroundColor = [UIColor grayColor];
            }
        }
        else {
            [chosenOptions addObject:cell.textLabel.text];
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
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
