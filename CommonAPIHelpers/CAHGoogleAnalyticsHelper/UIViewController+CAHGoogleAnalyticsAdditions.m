#import "UIViewController+CAHGoogleAnalyticsAdditions.h"
#import "CAHGoogleAnalytics.h"
#import <objc/runtime.h>

@implementation UIViewController (CAHGoogleAnalyticsAdditions)

- (void)cah_sendScreenViewEvent {
  [[CAHGoogleAnalytics sharedInstance]
   sendScreenViewHitFromScreen:NSStringFromClass([self class])];
}

- (void)cah_viewDidAppear:(BOOL)animated; {
  [self cah_viewDidAppear:animated];
  [self cah_sendScreenViewEvent];
}

+ (void)cah_swizzle {
  SEL original = @selector(viewDidAppear:);
  SEL swizzled = @selector(cah_viewDidAppear:);
  method_exchangeImplementations(class_getInstanceMethod(self, original),
                                 class_getInstanceMethod(self, swizzled));
}

+ (void)load {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    @autoreleasepool {
      [self cah_swizzle];
    }
  });
}

@end
