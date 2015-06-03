#import "MBProgressHUD.h"

@interface MBProgressHUD (CAHAdditions)

+ (void)cah_showToastWithImageName:(NSString *)imageName
                              text:(NSString *)text
                              view:(UIView *)view;
+ (void)cah_showSuccessToastWithText:(NSString *)text view:(UIView *)view;
+ (void)cah_showErrorToastWithText:(NSString *)text view:(UIView *)view;
+ (void)cah_showSuccessToastWithText:(NSString *)text;
+ (void)cah_showErrorToastWithText:(NSString *)text;
+ (void)cah_showSpinnerToastWithText:(NSString *)text
                      whileExecuting:(SEL)method
                            onTarget:(id)target;

@end
