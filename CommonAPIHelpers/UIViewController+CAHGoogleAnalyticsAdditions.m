#import "UIViewController+CAHGoogleAnalyticsAdditions.h"
#import "CAHGoogleAnalytics.h"

@implementation UIViewController (CAHGoogleAnalyticsAdditions)

- (void)cah_sendScreenViewEvent {
  [[CAHGoogleAnalytics sharedInstance]
   sendScreenViewHitFromScreen:NSStringFromClass([self class])];
}

@end
