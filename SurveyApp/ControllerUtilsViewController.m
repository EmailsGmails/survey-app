//
//  ControllerUtilsViewController.m
//  SurveyApp
//
//  Created by Emils on 17.07.17.
//  Copyright © 2017. g. EmailsGmails. All rights reserved.
//

#import "ControllerUtilsViewController.h"

@interface ControllerUtilsViewController ()

@end

@implementation ControllerUtilsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+(NSString) getStepString:(float)currentStep withCondition:(Boolean)isBaseStep {
    NSString *currentStepString = nil;
    if (isBaseStep) {
        currentStepString = [NSString stringWithFormat:@"%.f", currentStep];
    }
    else {
        currentStepString = [NSString stringWithFormat:@"%.1f", currentStep];
    }
}

+(void) setStepCountLabel:(NSString *)labelName inView:(UIView *)view {
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.contentSize.width, 24)];
    headerLabel.textAlignment = NSTextAlignmentCenter;
    headerLabel.font = [UIFont boldSystemFontOfSize:16];
    headerLabel.text = headerString;
    headerLabel.backgroundColor = [UIColor colorWithRed:50/255.0 green:200/255.0 blue:50/255.0 alpha:1.0];
    CALayer* layer = [headerLabel layer];
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.borderColor = [UIColor darkGrayColor].CGColor;
    bottomBorder.borderWidth = 1;
    bottomBorder.frame = CGRectMake(0, layer.frame.size.height-1, layer.frame.size.width, 1);
    bottomBorder.borderColor = [UIColor blackColor].CGColor;
    [layer addSublayer:bottomBorder];
    
    // TODO this too
    UILabel *questionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 24, tableView.contentSize.width, 31)];
    questionLabel.font = [UIFont systemFontOfSize:20];
    questionLabel.text = question;
    questionLabel.backgroundColor = [UIColor colorWithRed:0/255.0 green:255/255.0 blue:167/255.0 alpha:1.0];
    
    [view addSubview:headerLabel];
    [view addSubview:questionLabel];
    return view;
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
