//
//  AuthenticationService.h
//  centagate
//
//  Created by SecureTest on 17/05/2016.
//  Copyright © 2016 securemetric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestInfo.h"
#import "AccountInfo.h"
#import "DeviceInfo.h"
#import "DeviceAuthentication.h"

/*! @brief object contain function for get all Request Information to use it on authentication */
@interface AuthenticationService : NSObject

/*!
 * @discussion reject request authentication user
 * @param hid contain unique string  get from device Id
 * @param accountInfo contain account information who will do authentication
 * @param deviceInfo deviceInfo contain of full information get from setDeviceKey
 * @param requestId contain request Id related with user
 * @param longitude contain longitude of user
 * @param latitude contain latitude of user
 * @param deviceAuthentication authentication object contain authentication infromation from user
 * @param error return error
 * @return status reject authentication
 */
-(boolean_t)rejectRequestWithHid:(NSString*)hid accountInfo:(AccountInfo*)accountInfo deviceInfo:(DeviceInfo*)deviceInfo requestId:(NSString*)requestId longitude:(NSString*)longitude latitude:(NSString*)latitude deviceAuthentication:(DeviceAuthentication *)deviceAuthentication error:(NSError**)error;

/*!
 * @discussion get full request information authentication user
 * @param hid contain unique string  get from device Id
 * @param requestId contain request Id related with user
* @param accountInfo contain account information who will do authentication
 * @param deviceAuthentication authentication object contain authentication infromation from user
 * @param error return error
 * @return RequestInfo object contain full of Request Information
 */
-(RequestInfo*)getRequestInfoWithHid:(NSString*)hid requestId:(NSString*)requestId accountInfo:(AccountInfo*)accountInfo deviceAuthentication:(DeviceAuthentication *)deviceAuthentication error:(NSError**)error;

/*!
 * @discussion get all pending request authentication user
 * @param hid contain unique string  get from device Id
 * @param accountInfo contain account information who will do authentication
 * @param deviceAuthentication authentication object contain authentication infromation from user
 * @param error return error
 * @return Array contains basic information of RequestInfo object  
 */
-(NSMutableArray*)getPendingRequestInfoWithHid:(NSString*)hid accountInfo:(AccountInfo*)accountInfo deviceAuthentication:(DeviceAuthentication *)deviceAuthentication error:(NSError **)error;

@end
