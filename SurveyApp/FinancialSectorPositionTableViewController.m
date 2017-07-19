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

@interface FinancialSectorPositionTableViewController ()

@property (nonatomic,retain) NSIndexPath *checkedIndexPath;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (strong, nonatomic) NSArray *questions1and2;
@property (strong, nonatomic) NSArray *answerChoices;
@property (nonatomic, strong) NSMutableArray *chosenOptions;
@property (nonatomic, assign) Boolean isBaseStep;
@property (nonatomic, assign) float currentStep;
@property (strong, nonatomic) IBOutlet UILabel *stepLabel;
@property (assign, nonatomic) Boolean showQuestion2;

@end

@implementation FinancialSectorPositionTableViewController

@synthesize checkedIndexPath;
@synthesize nextButton;
@synthesize questions1and2;
@synthesize answerChoices;
@synthesize chosenOptions;
@synthesize isBaseStep;
@synthesize currentStep;
@synthesize showQuestion2;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.questions1and2 = [NSArray arrayWithObjects:[SurveyContent.surveyContent hasFinancialSectorPositionQuestion],
                    [SurveyContent.surveyContent financialSectorPositionQuestion], nil];
    self.answerChoices = [NSArray arrayWithObjects:[SurveyContent.surveyContent hasFinancialSectorPositionAnswerChoices],
                          [SurveyContent.surveyContent financialSectorPositionAnswerChoices], nil];
    self.isBaseStep = [Utils determineIfBaseQuestion:[questions1and2 objectAtIndex:0]];
    self.stepLabel.text = [Utils getStepLabelWithCondition:isBaseStep];
    self.nextButton.enabled = NO;
    self.nextButton.backgroundColor = [UIColor grayColor];
    self.chosenOptions = [NSMutableArray arrayWithObjects: [NSNull null], [NSNull null], nil];
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
        [SurveyProgress.surveyProgress setFinancialSectorPositionQuestion:nil];
        [SurveyProgress.surveyProgress setFinancialSectorPositionAnswer:nil];
        [SurveyProgress.surveyProgress setHasFinancialSectorPositionQuestion:nil];
        [SurveyProgress.surveyProgress setHasFinancialSectorPositionAnswer:nil];
    }
}

- (IBAction)cancelSurveyButton:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
    [SurveyProgress cancelSurvey];
}

- (IBAction)nextButton:(id)sender {
    [SurveyProgress.surveyProgress setHasFinancialSectorPositionQuestion:[questions1and2 objectAtIndex:0]];
    [SurveyProgress.surveyProgress setHasFinancialSectorPositionAnswer:[chosenOptions objectAtIndex:0]];
    if ([chosenOptions objectAtIndex:0] == [[SurveyContent.surveyContent hasFinancialSectorPositionAnswerChoices] objectAtIndex:1]) {
        [SurveyProgress.surveyProgress setFinancialSectorPositionQuestion:[questions1and2 objectAtIndex:1]];
        [SurveyProgress.surveyProgress setFinancialSectorPositionAnswer:[chosenOptions objectAtIndex:1]];
    }
    else {
        [SurveyProgress.surveyProgress setFinancialSectorPositionQuestion:nil];
        [SurveyProgress.surveyProgress setFinancialSectorPositionAnswer:nil];
    }
    if (self.isBaseStep) {
        [[SurveyProgress.surveyProgress baseQuestions] addObject:[questions1and2 objectAtIndex:0]];
    }
    NSLog(@"Selected choices: %@ and %@", [chosenOptions objectAtIndex:0], [chosenOptions objectAtIndex:1]);
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *uvc = (VerificationTableViewController*)[storyboard instantiateViewControllerWithIdentifier:@"Verification"];
    [self.navigationController pushViewController:uvc animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [[answerChoices objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:20];
    cell.backgroundColor = [UIColor colorWithRed:0/255.0 green:255/255.0 blue:167/255.0 alpha:1.0];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (!showQuestion2) {
        return 1;
    }
    else {
        return 2;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (!showQuestion2) {
        return [questions1and2 objectAtIndex:0];
    } else {
        return [questions1and2 objectAtIndex:section];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (!showQuestion2) {
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
    return [[answerChoices objectAtIndex:section] count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath{
    switch (indexPath.section) {
        case 0:
            if (self.checkedIndexPath) {
                UITableViewCell* uncheckCell = [tableView
                                                cellForRowAtIndexPath:self.checkedIndexPath];
                uncheckCell.accessoryType = UITableViewCellAccessoryNone;
            }
            if ([self.checkedIndexPath isEqual:indexPath]) {
                self.checkedIndexPath = nil;
                self.chosenOptions[0] = [NSNull null];
                self.nextButton.enabled = NO;
                self.nextButton.backgroundColor = [UIColor grayColor];
            }
            else {
                if (indexPath.row == 0) {
                    NSIndexPath *yesCellIndexPath = [NSIndexPath indexPathForRow:1 inSection:0];
                    UITableViewCell* hackYesCell = [tableView cellForRowAtIndexPath:yesCellIndexPath];
                    if (hackYesCell.accessoryType == UITableViewCellAccessoryCheckmark) {
                        hackYesCell.accessoryType = UITableViewCellAccessoryNone;
                    }
                    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                    self.checkedIndexPath = indexPath;
                    self.nextButton.enabled = YES;
                    self.showQuestion2 = NO;
                    self.chosenOptions[0] = cell.textLabel.text;
                    self.chosenOptions[1] = [NSNull null];
                    self.nextButton.backgroundColor = [UIColor colorWithRed:255/255.0 green:64/255.0 blue:100/255.0 alpha:1.0];
                    [self.tableView reloadData];
                }
                else {
                    NSIndexPath *yesCellIndexPath = [NSIndexPath indexPathForRow:1 inSection:0];
                    UITableViewCell* hackYesCell = [tableView cellForRowAtIndexPath:yesCellIndexPath];
                    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
                    if (hackYesCell.accessoryType == UITableViewCellAccessoryCheckmark || cell.accessoryType == UITableViewCellAccessoryCheckmark) {
                        hackYesCell.accessoryType = UITableViewCellAccessoryNone;
                        self.nextButton.enabled = NO;
                        self.showQuestion2 = NO;
                        self.nextButton.backgroundColor = [UIColor grayColor];
                    }
                    else {
                    cell = [tableView cellForRowAtIndexPath:indexPath];
                        cell.accessoryType = UITableViewCellAccessoryCheckmark;
                        self.checkedIndexPath = indexPath;
                        self.nextButton.enabled = NO;
                        self.showQuestion2 = YES;
                        self.nextButton.backgroundColor = [UIColor grayColor];
                        self.chosenOptions[0] = cell.textLabel.text;
                    }
                    [self.tableView reloadData];
                }
            }
            break;
        case 1:
            if(self.checkedIndexPath)
            {
                UITableViewCell* uncheckCell = [tableView
                                                cellForRowAtIndexPath:self.checkedIndexPath];
                if (!(checkedIndexPath.section == 0 && checkedIndexPath.row == 1)) {
                    uncheckCell.accessoryType = UITableViewCellAccessoryNone;
                }
            }
            if([self.checkedIndexPath isEqual:indexPath])
            {
                self.checkedIndexPath = nil;
                self.chosenOptions[1] = [NSNull null];
                self.nextButton.enabled = NO;
                self.nextButton.backgroundColor = [UIColor grayColor];
            }
            else
            {
                UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
                self.checkedIndexPath = indexPath;
                self.chosenOptions[1]= cell.textLabel.text;
                self.nextButton.enabled = YES;
                self.nextButton.backgroundColor = [UIColor colorWithRed:255/255.0 green:64/255.0 blue:100/255.0 alpha:1.0];
            }
            break;
        default:
            break;
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
