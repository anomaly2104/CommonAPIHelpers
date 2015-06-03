#import <Foundation/Foundation.h>

@interface CAHMailController : NSObject

- (instancetype)initWithAppSpecificDebugInfo:(NSString *)appSpecificDebugInfo;

- (void)showContactRequestFromPresentingViewController:(UIViewController *)viewController
                                          contactEmail:(NSString *)contactEmail;

- (void)showFeatureRequestFromPresentingViewController:(UIViewController *)viewController
                                          requestEmail:(NSString *)requestEmail;
@end
