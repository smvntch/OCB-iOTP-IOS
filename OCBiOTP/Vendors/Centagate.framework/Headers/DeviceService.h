//
//  DeviceService.h
//  centagate
//
//  Created by SecureTest on 23/02/2016.
//  Copyright © 2016 securemetric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DeviceInfo.h"
#import "DeviceAuthentication.h"
#import "AccountInfo.h"
#import "SessionInfo.h"

/*! @brief object contain All device and user account binding proccess */
@interface DeviceService : NSObject

/*!
 * @discussion set Device Key for transaction to server
 * @param sessionInfo contain session info from onlineProvisioningWithUsername or getSessionInfo
 * @param hid contain unique string  get from device Id
 * @param deviceAuthentication contain authentication object contain authentication infromation from user
 * @param error return error
 * @return DeviceInfo registered in server
 */
-(DeviceInfo *)setDeviceKeyWithSessionInfo:(SessionInfo *)sessionInfo hid:(NSString*)hid DeviceAuth:(DeviceAuthentication *)deviceAuthentication error:(NSError**)error;

@end
