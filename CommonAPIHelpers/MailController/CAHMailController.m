#import "CAHMailController.h"
#import <MessageUI/MessageUI.h>
#import <UIDevice-Helpers/UIDevice-Helpers.h>

#define FEATURE_REQUESTS_MAIL_SUBJECT NSLocalizedString(@"Requesting feature for %@", @"Feature request mail subject")
#define FEATURE_REQUESTS_MAIL_BODY NSLocalizedString(@"Write your feature request above this horizontal line.", @"Feature request mail subject")
#define DEVICE_TEXT NSLocalizedString(@"Device", @"Device")
#define OPERATING_SYSTEM_TEXT NSLocalizedString(@"Operating System", @"Operating System")
#define APP_VERSION NSLocalizedString(@"App version", @"App version")
#define DO_NOT_WRITE_BELOW NSLocalizedString(@"Please do not write/edit anything below this line", @"App version")

#define CONTACT_REQUEST_MAIL_SUBJECT NSLocalizedString(@"Contact request: %@", @"Contact request mail subject")
#define CONTACT_REQUEST_MAIL_BODY NSLocalizedString(@"Contact request", @"Contact request mail body")


@interface CAHMailController () <MFMailComposeViewControllerDelegate>

@property (nonatomic) NSString *appName;
@property (nonatomic) NSString *appSpecificDebugInfo;

@end

@implementation CAHMailController

- (instancetype)initWithAppName:(NSString *)appName
           appSpecificDebugInfo:(NSString *)appSpecificDebugInfo {
  self = [super init];
  if (self) {
    _appName = appName;
    _appSpecificDebugInfo = appSpecificDebugInfo;
  }
  return self;
}

#pragma mark Contact request

- (void)showContactRequestFromPresentingViewController:(UIViewController *)viewController
                                          contactEmail:(NSString *)contactEmail {
  NSString *subject = [NSString stringWithFormat:CONTACT_REQUEST_MAIL_SUBJECT,
                       self.appName];
  NSString *body = [self bodyWithDefaultMessage:CONTACT_REQUEST_MAIL_BODY];
  [self showMailComposerWithSubject:subject
                               body:body
                          presenter:viewController
                          recipient:contactEmail];
}

#pragma mark Feature request

- (void)showFeatureRequestFromPresentingViewController:(UIViewController *)viewController
                                          requestEmail:(NSString *)requestEmail {
  NSString *subject = [NSString stringWithFormat:FEATURE_REQUESTS_MAIL_SUBJECT,
                       self.appName];
  NSString *body = [self bodyForFeatureRequestsMail];
  [self showMailComposerWithSubject:subject
                               body:body
                          presenter:viewController
                          recipient:requestEmail];
}

- (NSString *)bodyForFeatureRequestsMail {
  return [self bodyWithDefaultMessage:FEATURE_REQUESTS_MAIL_BODY];
}

#pragma mark -

- (NSString *)bodyWithDefaultMessage:(NSString *)message {
  return [NSString stringWithFormat:@"\n\n\n\n-------------------------------\n%@\n\n%@\n%@\n%@",
          DO_NOT_WRITE_BELOW,
          message,
          self.appSpecificDebugInfo,
          [self systemInfo]];
}

- (NSString *)systemInfo {
  NSString *osString = [NSString stringWithFormat:@"%@ %@",
                        [[UIDevice currentDevice] systemName],
                        [[UIDevice currentDevice] systemVersion]];
  return [NSString stringWithFormat:@"\n%@: %@\n%@: %@\n",
          DEVICE_TEXT, [[UIDevice currentDevice] modelVersion],
          OPERATING_SYSTEM_TEXT, osString];
}

#pragma mark - Mail view related methods

- (void)showMailComposerWithSubject:(NSString *)subject
                               body:(NSString *)body
                          presenter:(UIViewController *)presenter
                          recipient:(NSString *)recipient {
  if (![MFMailComposeViewController canSendMail]) {
    //TODO: Show some error or notify caller about this error
    return;
  }
  MFMailComposeViewController *mailComposeController = nil;
  mailComposeController = [self createMailComposerViewControllerWithSubject:subject
                                                                       body:body
                                                                  recipient:recipient];
  [presenter presentViewController:mailComposeController animated:YES completion:nil];
}

- (MFMailComposeViewController *)createMailComposerViewControllerWithSubject:(NSString *)subject
                                                                        body:(NSString *)body
                                                                   recipient:(NSString *)recipient {
  MFMailComposeViewController *mailComposeController = [[MFMailComposeViewController alloc] init];
  mailComposeController.mailComposeDelegate = self;
  
  [mailComposeController setSubject:subject];
  [mailComposeController setToRecipients:@[recipient]];
  [mailComposeController setMessageBody:body isHTML:NO];
  return mailComposeController;
}

- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error {
  [controller dismissViewControllerAnimated:YES completion:nil];
}


@end
