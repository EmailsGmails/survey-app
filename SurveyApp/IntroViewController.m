//
//  IntroViewController.m
//  SurveyApp
//
//  Created by A on 10/07/2017.
//  Copyright © 2017 EmailsGmails. All rights reserved.
//

#import "IntroViewController.h"
#import "ProfessionalClientStatusTableViewController.h"

@interface IntroViewController ()

@end

@implementation IntroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Fillinsurvey:(id)sender {
    NSLog(@"Beginning the survey.");
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *uvc = (ProfessionalClientStatusTableViewController*)[storyboard instantiateViewControllerWithIdentifier:@"ProfessionalClientStatus"];
    [self.navigationController pushViewController:uvc animated:YES];
}

@end
