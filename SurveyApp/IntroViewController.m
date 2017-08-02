
#import "IntroViewController.h"
#import "ProfessionalClientStatusTableViewController.h"

@interface IntroViewController ()
@property (weak, nonatomic) IBOutlet UILabel *descriptionBtn;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;

@end

@implementation IntroViewController

- (void)viewDidLoad {
    self.title = NSLocalizedString(@"Title", nil);
    self.descriptionBtn.text = NSLocalizedString(@"SurveyDescription", nil);
    self.startBtn.titleLabel.text = NSLocalizedString(@"StartBtnText", nil);
    [super viewDidLoad];
    if (self.survey == nil) {
        self.survey = [SurveyProgress new];
        self.survey.operationPurpose = [NSMutableArray new];
        self.survey.clientDescription = ClientDescription_NIL;
        self.survey.portfolioCost = PortfolioCost_NIL;
        self.survey.financialSectorPosition = FinancialSectorPosition_NIL;
    }
}

- (IBAction)Fillinsurvey:(id)sender {
    NSLog(@"Beginning the survey.");
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ProfessionalClientStatusTableViewController *uvc = [storyboard instantiateViewControllerWithIdentifier:@"ProfessionalClientStatus"];
    uvc.survey = self.survey;
    [self.navigationController pushViewController:uvc animated:YES];
}

@end
