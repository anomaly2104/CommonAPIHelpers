#import <UIKit/UIKit.h>

@interface UIViewController (CAHGoogleAnalyticsAdditions)

/*
 Sends current UIViewController's class' name to google analytics.
 
 @note Requires you to set 
 */
- (void)cah_sendScreenViewEvent;

@end
