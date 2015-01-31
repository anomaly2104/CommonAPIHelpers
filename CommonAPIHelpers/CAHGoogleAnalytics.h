#import <Foundation/Foundation.h>

@interface CAHGoogleAnalytics : NSObject

+ (instancetype)sharedInstance;

- (void)setTrackingID:(NSString *)trackingID;

- (void)sendEventHitFromCategory:(NSString *)category
                          action:(NSString *)action
                           label:(NSString *)label
                           value:(NSNumber *)value;

/**
 interval -> @(NSTimeInterval)
 */
- (void)sendTimingHitFromCategory:(NSString *)category
                    intervalBoxed:(NSNumber *)intervalBoxed
                         variable:(NSString *)variable
                            label:(NSString *)label;

- (void)sendScreenViewHitFromScreen:(NSString *)screen;

#pragma mark Development Modes

/**
 Turn on the "dry run" mode and log all API interactions.
 
 @note This method should be called before initialization.
 */
+ (void)enterDebugMode;

+ (void)disable;

@end
