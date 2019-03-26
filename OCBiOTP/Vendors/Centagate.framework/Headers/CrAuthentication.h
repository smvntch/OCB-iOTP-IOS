//
//  CrAuthentication.h
//  centagate
//
//  Created by SecureTest on 19/05/2016.
//  Copyright © 2016 securemetric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Account.h"
#import "DeviceAuthentication.h"

/*! @brief object contain function for do authentication using CR */
@interface CrAuthentication : NSObject

/*!
 * @discussion approve request authentication
 * @param hid contain unique string  get from device Id
 * @param model contain phone model and version
 * @param requestId contain request Id related with user
 * @param account contain account who will do authentication
 * @param otpChallenge contain challenge of CR
 * @param longitude contain longitude of user
 * @param latitude contain latitude of user
 * @param deviceAuthentication authentication object contain authentication infromation from user
 * @param error return error
 * @return status approve authentication
 */
-(boolean_t)approveRequestWithHid:(NSString*)hid model:(NSString*)model requestId:(NSString*)requestId account:(Account*)account otpChallenge:(NSString*)otpChallenge longitude:(NSString*)longitude latitude:(NSString*)latitude deviceAuthentication:(DeviceAuthentication *)deviceAuthentication error:(NSError**)error;

@end
