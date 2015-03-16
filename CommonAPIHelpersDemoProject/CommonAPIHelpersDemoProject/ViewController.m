#import "ViewController.h"
#import <CommonAPIHelpers/CommonAPIHelpers.h>

@interface ViewController ()

@property (nonatomic) CAHMailController *mailController;

@end

@implementation ViewController

- (CAHMailController *)mailController {
  if (_mailController == nil) {
    _mailController = [[CAHMailController alloc] initWithAppSpecificDebugInfo:@""];
  }
  return _mailController;
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self cah_sendScreenViewEvent];
}

- (void)infiniteTask {
  sleep(3);
}

- (IBAction)infiniteTaskPressedSpinner {
  [MBProgressHUD cah_showSpinnerToastWithText:@"Executing..."
                               whileExecuting:@selector(infiniteTask)
                                     onTarget:self];
}

- (IBAction)tapItPressed:(id)sender {
  NSLog(@"Tap it pressed");
  [MBProgressHUD cah_showSuccessToastWithText:@"succ"];
}

- (IBAction)contactRequestPressed:(UIButton *)sender {
  [self.mailController showContactRequestFromPresentingViewController:self
                                                         contactEmail:@"contact@uditagarwal.com"];
}

- (IBAction)requestFeaturePressed:(UIButton *)sender {
  [self.mailController showFeatureRequestFromPresentingViewController:self
                                                         requestEmail:@"contact@uditagarwal.com"];
}

@end
