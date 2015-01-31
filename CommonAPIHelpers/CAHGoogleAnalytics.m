#import "CAHGoogleAnalytics.h"
#import <GoogleAnalytics-iOS-SDK/GAI.h>
#import <GoogleAnalytics-iOS-SDK/GAIDictionaryBuilder.h>
#import <GoogleAnalytics-iOS-SDK/GAIFields.h>
#import <TDTChocolate/TDTFoundationAdditions.h>

@interface GAI (CAHAdditions)

- (void)cah_configureOnce;

@end

@implementation GAI (CAHAdditions)

- (void)cah_configureOnce {
  self.trackUncaughtExceptions = NO;
  self.dispatchInterval = 20;
}

@end

@interface CAHGoogleAnalytics ()

@property (nonatomic) id<GAITracker> tracker;
@property (nonatomic) NSString *trackingID;

@end

@implementation CAHGoogleAnalytics

+ (instancetype)sharedInstance {
  GAI *GA = [GAI sharedInstance];
  
  static CAHGoogleAnalytics *sharedObj = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    [GA cah_configureOnce];
    sharedObj = [[[self class] alloc] init];
  });
  return sharedObj;
}

+ (void)enterDebugMode {
  GAI *GA = [GAI sharedInstance];
  [GA.logger setLogLevel:kGAILogLevelVerbose];
  GA.dryRun = YES;
}

+ (void)disable {
  [[GAI sharedInstance] setOptOut:YES];
}

- (void)setTrackingID:(NSString *)trackingID {
  _trackingID = trackingID;
  self.tracker = [[GAI sharedInstance] trackerWithTrackingId:_trackingID];
}

- (void)sendEventHitFromCategory:(NSString *)category
                          action:(NSString *)action
                           label:(NSString *)label
                           value:(NSNumber *)value {
  TDTParameterAssert(category);
  TDTParameterAssert(action);
  [self.tracker send:[[GAIDictionaryBuilder createEventWithCategory:category
                                                             action:action
                                                              label:label
                                                              value:value] build]];
}

- (void)sendTimingHitFromCategory:(NSString *)category
                    intervalBoxed:(NSNumber *)intervalBoxed
                         variable:(NSString *)variable
                            label:(NSString *)label {
  TDTParameterAssert(category);
  TDTParameterAssert(intervalBoxed);
  TDTParameterAssert(variable);
  NSTimeInterval interval = [intervalBoxed doubleValue];
  NSTimeInterval intervalInMilliseconds = floor(interval * 1000);
  [self.tracker send:[[GAIDictionaryBuilder createTimingWithCategory:category
                                                            interval:@(intervalInMilliseconds)
                                                                name:variable
                                                               label:label] build]];
}

- (void)sendScreenViewHitFromScreen:(NSString *)screen {
  TDTParameterAssert(self.tracker);
  TDTParameterAssert(self.trackingID);
  TDTParameterAssert(screen);
  [self.tracker set:kGAIScreenName value:screen];
  [self.tracker send:[[GAIDictionaryBuilder createScreenView] build]];
}

@end
