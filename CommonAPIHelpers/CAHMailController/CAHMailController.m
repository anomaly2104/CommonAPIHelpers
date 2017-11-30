#import "CAHMailController.h"
#import <MessageUI/MessageUI.h>
#import "NSString+CAHProductNamesFromModelVersion.h"

#define FEATURE_REQUESTS_MAIL_SUBJECT NSLocalizedString(@"Requesting feature for %@", @"Feature request mail subject")
#define FEATURE_REQUESTS_MAIL_BODY NSLocalizedString(@"Write your feature request above this horizontal line.", @"Feature request mail subject")
#define DEVICE_TEXT NSLocalizedString(@"Device", @"Device")
#define OPERATING_SYSTEM_TEXT NSLocalizedString(@"Operating System", @"Operating System")
#define APP_VERSION NSLocalizedString(@"App version", @"App version")
#define APP_NAME NSLocalizedString(@"App name", @"App name")
#define DO_NOT_WRITE_BELOW NSLocalizedString(@"Please do not write/edit anything below this line.", @"Do not write below text")

#define CONTACT_REQUEST_MAIL_SUBJECT NSLocalizedString(@"Contact request: %@", @"Contact request mail subject")
#define CONTACT_REQUEST_MAIL_BODY NSLocalizedString(@"Contact request", @"Contact request mail body")

#define SendFeedbackMailSubject NSLocalizedString(@"Send Feedback: %@", @"Contact request mail subject")
#define SendFeedbackMailBody NSLocalizedString(@"Write your feedback above this horizontal line", @"feedback mail body")

@interface CAHMailController () <MFMailComposeViewControllerDelegate>

@property (nonatomic) NSString *appSpecificDebugInfo;
@property (nonatomic) NSString *deviceName;

@end

@implementation CAHMailController

- (instancetype)initWithDeviceName:(NSString *)deviceName
              appSpecificDebugInfo:(NSString *)appSpecificDebugInfo {
  self = [super init];
  if (self) {
    _appSpecificDebugInfo = appSpecificDebugInfo;
    _deviceName = deviceName;
  }
  return self;
}

#pragma mark Contact request

- (void)showContactRequestFromPresentingViewController:(UIViewController *)viewController
                                          contactEmail:(NSString *)contactEmail {
  NSString *subject = [NSString stringWithFormat:CONTACT_REQUEST_MAIL_SUBJECT,
                       [self currentAppName]];
  NSString *body = [self bodyWithDefaultMessage:CONTACT_REQUEST_MAIL_BODY];
  [self showMailComposerWithSubject:subject
                               body:body
                          presenter:viewController
                          recipient:contactEmail
                        attachments:nil];
}

#pragma mark Send Feedback

- (void)showSendFeedbackFromPresentingViewController:(UIViewController *)viewController
                                        contactEmail:(NSString *)contactEmail
                                         attachments:(NSArray<CAHMailAttachment *> *)attachments {
  NSString *subject = [NSString stringWithFormat:SendFeedbackMailSubject,
                       [self currentAppName]];
  NSString *body = [self bodyWithDefaultMessage:SendFeedbackMailBody];
  [self showMailComposerWithSubject:subject
                               body:body
                          presenter:viewController
                          recipient:contactEmail
                        attachments:attachments];
}

#pragma mark Feature request

- (void)showFeatureRequestFromPresentingViewController:(UIViewController *)viewController
                                          requestEmail:(NSString *)requestEmail {
  NSString *subject = [NSString stringWithFormat:FEATURE_REQUESTS_MAIL_SUBJECT,
                       [self currentAppName]];
  NSString *body = [self bodyForFeatureRequestsMail];
  [self showMailComposerWithSubject:subject
                               body:body
                          presenter:viewController
                          recipient:requestEmail
                        attachments:nil];
}

- (NSString *)bodyForFeatureRequestsMail {
  return [self bodyWithDefaultMessage:FEATURE_REQUESTS_MAIL_BODY];
}


#pragma mark Current App Details

- (NSString *)currentFullVersion {
  return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
}

- (NSString *)currentAppName {
  return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleExecutable"];
}

#pragma mark -

- (NSString *)appSpecificInfo {
  NSString *appInfo = [NSString stringWithFormat:@"%@: %@\n%@: %@",
                       APP_VERSION, [self currentFullVersion],
                       APP_NAME, [self currentAppName]];
  if (self.appSpecificDebugInfo != nil) {
    [appInfo stringByAppendingFormat:@"\n%@", self.appSpecificDebugInfo];
  }
  return appInfo;
}

- (NSString *)bodyWithDefaultMessage:(NSString *)message {
  return [NSString stringWithFormat:@"\n\n\n\n-------------------------------\n%@\n%@\n\n%@\n%@",
          message,
          DO_NOT_WRITE_BELOW,
          [self appSpecificInfo],
          [self systemInfo]];
}

- (NSString *)systemInfo {
  NSString *osString = [NSString stringWithFormat:@"%@ %@",
                        [[UIDevice currentDevice] systemName],
                        [[UIDevice currentDevice] systemVersion]];
  return [NSString stringWithFormat:@"%@: %@\n%@: %@",
          DEVICE_TEXT, self.deviceName,
          OPERATING_SYSTEM_TEXT, osString];
}

#pragma mark - Mail view related methods

- (void)showMailComposerWithSubject:(NSString *)subject
                               body:(NSString *)body
                          presenter:(UIViewController *)presenter
                          recipient:(NSString *)recipient
                        attachments:(NSArray<CAHMailAttachment *> *)attachments {
  if (![MFMailComposeViewController canSendMail]) {
    //TODO: Show some error or notify caller about this error
    NSLog(@"Could not open mail composer");
    return;
  }
  MFMailComposeViewController *mailComposeController = nil;
  mailComposeController = [self createMailComposerViewControllerWithSubject:subject
                                                                       body:body
                                                                  recipient:recipient
                                                                attachments:attachments];
  [presenter presentViewController:mailComposeController animated:YES completion:nil];
}

- (MFMailComposeViewController *)createMailComposerViewControllerWithSubject:(NSString *)subject
                                                                        body:(NSString *)body
                                                                   recipient:(NSString *)recipient
                                                                 attachments:(NSArray<CAHMailAttachment *> *)attachments{
  MFMailComposeViewController *mailComposeController = [[MFMailComposeViewController alloc] init];
  mailComposeController.mailComposeDelegate = self;
  
  [mailComposeController setSubject:subject];
  [mailComposeController setToRecipients:@[recipient]];
  [mailComposeController setMessageBody:body isHTML:NO];
  
  for (CAHMailAttachment *attachment in attachments) {
    [mailComposeController addAttachmentData:attachment.data
                                    mimeType:attachment.mimeType
                                    fileName:attachment.fileName];
  }
  
  return mailComposeController;
}

- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error {
  [controller dismissViewControllerAnimated:YES completion:nil];
}


@end

@interface CAHMailAttachment ()

@end

@implementation CAHMailAttachment

@end
