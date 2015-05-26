//
//  NSString+CAHProductNamesFromModelVersion.m
//  
//
//  Created by Udit Agarwal on 26/05/15.
//
//

#import "NSString+CAHProductNamesFromModelVersion.h"

@implementation NSString (CAHProductNamesFromModelVersion)

- (NSString *)cah_productName {
  NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:@"ProductNamesFromModelVersion"
                                                                    ofType:@"plist"];
  NSDictionary *products = [NSDictionary dictionaryWithContentsOfFile:path];
  return products[self] ?: self;
}

@end
