#import <Foundation/Foundation.h>

@interface CAHMailAttachment : NSObject

@property (nonatomic) NSString *mimeType;
@property (nonatomic) NSString *fileName;
@property (nonatomic) NSData *data;

@end

@interface CAHMailController : NSObject

- (instancetype)initWithDeviceName:(NSString *)deviceName
              appSpecificDebugInfo:(NSString *)appSpecificDebugInfo;

- (void)showContactRequestFromPresentingViewController:(UIViewController *)viewController
                                          contactEmail:(NSString *)contactEmail;

- (void)showFeatureRequestFromPresentingViewController:(UIViewController *)viewController
                                          requestEmail:(NSString *)requestEmail;

- (void)showSendFeedbackFromPresentingViewController:(UIViewController *)viewController
                                        contactEmail:(NSString *)contactEmail
                                         attachments:(NSArray<CAHMailAttachment *> *)attachments;

- (void)showMailComposerWithSubject:(NSString *)subject
                               body:(NSString *)body
                          presenter:(UIViewController *)presenter
                          recipient:(NSString *)recipient
                        attachments:(NSArray<CAHMailAttachment *> *)attachments;
@end
