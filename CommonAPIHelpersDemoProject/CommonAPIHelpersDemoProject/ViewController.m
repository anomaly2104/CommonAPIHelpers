#import "ViewController.h"
#import <CommonAPIHelpers/CommonAPIHelpers.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self cah_sendScreenViewEvent];
}

@end
