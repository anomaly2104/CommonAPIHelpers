#import "MBProgressHUD+CAHAdditions.h"

@implementation MBProgressHUD (CAHAdditions)

+ (void)cah_showToastWithImageName:(NSString *)imageName
                              text:(NSString *)text
                              view:(UIView *)view {
  MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
  UIImage *icon = [UIImage imageNamed:imageName];
  hud.customView = [[UIImageView alloc] initWithImage:icon];
  hud.labelText = text;
  hud.mode = MBProgressHUDModeCustomView;
  hud.square = YES;
  hud.removeFromSuperViewOnHide = YES;
  [hud hide:YES afterDelay:1.0];
}

+ (void)cah_showSuccessToastWithText:(NSString *)text view:(UIView *)view {
  [MBProgressHUD cah_showToastWithImageName:@"hud-tick-icon.png"
                                       text:text
                                       view:view];
}

+ (void)cah_showErrorToastWithText:(NSString *)text view:(UIView *)view {
  [MBProgressHUD cah_showToastWithImageName:@"hud-cross-icon.png"
                                       text:text
                                       view:view];
}

+ (void)cah_showSuccessToastWithText:(NSString *)text {
  UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
  [MBProgressHUD cah_showSuccessToastWithText:text view:keyWindow];
}

+ (void)cah_showErrorToastWithText:(NSString *)text {
  UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
  [MBProgressHUD cah_showErrorToastWithText:text view:keyWindow];
}

@end
