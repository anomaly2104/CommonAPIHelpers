#import "ViewController.h"
#import <CommonAPIHelpers/CommonAPIHelpers.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self cah_sendScreenViewEvent];
}

- (IBAction)tapItPressed:(id)sender {
  NSLog(@"Tap it pressed");
  [MBProgressHUD cah_showSuccessToastWithText:@"succ"];
}

@end
