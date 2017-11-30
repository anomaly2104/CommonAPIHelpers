#import <UIKit/UIKit.h>

/*
 This adds analytics functionality to all of your view controller classes.
 Event for any view controller presented will be sent to google analytics 
 automatically.
 
 @pre If you add this file to your project, be sure that you are setting
 trackingID on [CAHGoogleAnalytics sharedInstance] otherwise it will crash.
 
 Example: [[CAHGoogleAnalytics sharedInstance] setTrackingID:@"UA-00000000-0"];
 */
@interface UIViewController (CAHGoogleAnalyticsAdditions)

@end
