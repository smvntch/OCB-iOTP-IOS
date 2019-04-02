//
//  SoftCertAuthenticationService.h
//  centagate
//
//  Created by SecureTest on 19/05/2016.
//  Copyright © 2016 securemetric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccountInfo.h"
#import "DeviceAuthentication.h"
#import "SoftCertInfo.h"

/*! @brief object contain function for do authentication using soft cert */
@interface SoftCertAuthentication : NSObject

/*!
 * @discussion approve request authentication
 * @param hid contain unique string  get from device Id
 * @param model contain phone model and version
 * @param accountInfo contain account information who will do authentication
 * @param requestId contain request Id related with user
 * @param longitude contain longitude of user
 * @param latitude contain latitude of user
 * @param deviceAuthentication authentication object contain authentication infromation from user
 * @param error return error
 * @return soft cert information contain all requirement to authenticate with soft cer
 */
-(SoftCertInfo *)approveRequestWithHid:(NSString*)hid model:(NSString*)model  accountInfo:(AccountInfo*)accountInfo requestId:(NSString*)requestId longitude:(NSString*)longitude latitude:(NSString*)latitude deviceAuthentication:(DeviceAuthentication *)deviceAuthentication error:(NSError**)error;


@end
