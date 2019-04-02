//
//  QrAuthentication.h
//  centagate
//
//  Created by SecureTest on 19/05/2016.
//  Copyright © 2016 securemetric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Account.h"
#import "DeviceAuthentication.h"
#import "RequestInfo.h"
#import "AccountInfo.h"

/*! @brief object contain function for do authentication using QR code */
@interface QrAuthentication: NSObject

/*!
 * @discussion approve request authentication
 * @param hid contain unique string  get from device Id
 * @param model contain phone model and version
 * @param account contain account who will do authentication
 * @param qrCode contain QR code get from server
 * @param longitude contain longitude of user
 * @param latitude contain latitude of user
 * @param deviceAuthentication authentication object contain authentication infromation from user
 * @param error return error
 * @return status approve authentication
 */
-(boolean_t)approveRequestWithHid:(NSString*)hid model:(NSString*)model  account:(Account*)account qrCode:(NSString*)qrCode longitude:(NSString*)longitude latitude:(NSString*)latitude deviceAuthentication:(DeviceAuthentication *)deviceAuthentication error:(NSError**)error;

/*!
 * @discussion get Request Info from QR
 * @param qrRequest contain QR code get from server
 * @param accountInfo contain account information who will do authentication
 * @param deviceAuthentication authentication object contain authentication infromation from user
 * @param error return error
 * @return request information can use it to authenticate with QR
 */
-(RequestInfo *)getQrRequestInfoWithQr:(NSString*)qrRequest accountInfo:(AccountInfo*)accountInfo deviceAuthentication:(DeviceAuthentication *)deviceAuthentication error:(NSError**)error;

@end
