//
//  AudioPassAuthenticationService.h
//  centagate
//
//  Created by SecureTest on 19/05/2016.
//  Copyright © 2016 securemetric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccountInfo.h"
#import "DeviceAuthentication.h"

/*! @brief object contain function for do authentication using audio pass device */
@interface AudioPassAuthentication : NSObject


/*!
 * @discussion Approve request authentication
 * @param hid contain unique string  get from device Id
 * @param model contain phone model and version
 * @param accountInfo contain account information who will do authentication
 * @param requestId contain request Id related with user
 * @param longitude contain longitude of user
 * @param latitude contain latitude of user
 * @param deviceAuthentication authentication object contain authentication infromation from user
 * @param base64SignatureAudioPass signature get from audio device library with format base64
 * @param certInfo certInfo get from audio device library
 * @param error return error
 * @return status approve authentication
 */
-(boolean_t)approveRequestWithHid:(NSString*)hid model:(NSString*)model  accountInfo:(AccountInfo*)accountInfo requestId:(NSString*)requestId longitude:(NSString*)longitude latitude:(NSString*)latitude deviceAuthentication:(DeviceAuthentication *)deviceAuthentication base64SignatureAudioPass:(NSString*)base64SignatureAudioPass certInfo:(NSData*)certInfo error:(NSError**)error;



@end
