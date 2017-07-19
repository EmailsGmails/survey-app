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

@interface VerificationTableViewController ()

@property (nonatomic,retain) NSIndexPath *checkedIndexPath;
@property (weak, nonatomic) IBOutlet UIButton *finishButton;
@property (strong, nonatomic) NSArray *questions;
@property (strong, nonatomic) NSArray *answers;

@end

@implementation VerificationTableViewController

@synthesize checkedIndexPath;
@synthesize finishButton;
@synthesize questions;
@synthesize answers;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.allowsSelection = NO;
    self.questions = [SurveyProgress.getFilledQuestions copy];
    self.answers = [Utils parseAnswersToString:[SurveyProgress.getFilledAnswers copy]];
    NSLog(@"Filled questions: %@", [questions valueForKey:@"description"]);
    NSLog(@"Filled answers: %@", [answers valueForKey:@"description"]);
}

- (void)viewWillAppear:(BOOL)animated {
    self.title = @"Financial Instrument Survey";
}

- (IBAction)cancelSurveyButton:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
    [SurveyProgress cancelSurvey];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Verification";
}

- (IBAction)finishButton:(id)sender {
    NSLog(@"Survey finished.");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"VerificationCell";
    VerificationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[VerificationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    long cellIndex = indexPath.row;
    cell.questionLabel.text = [questions objectAtIndex:cellIndex];
    cell.questionLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:15];
    cell.answerLabel.text = [answers objectAtIndex:cellIndex];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [answers count];
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
