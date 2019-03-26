//
//  KeyOperation.h
//  centagate
//
//  Created by SecureTest on 25/05/2016.
//  Copyright © 2016 securemetric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DeviceInfo.h"
#import "DeviceAuthentication.h"
#import "Account.h"

/*! @brief object contain function to change all key in Device and Account due change PIN*/
@interface KeyOperation : NSObject

/*!
 * @discussion updateDeviceKeyWithOldDeviceAuth save all accounts device information and Configuration.
 * @param oldDeviceAuth contain current or old DeviceAuthentication
 * @param newDeviceAuth contain new DeviceAuthentication will be change the old DeviceAuthentication
 * @param deviceInfo object contain current device information
 * @return new DeviceInfo for new DeviceAuthentication
 */
-(DeviceInfo *)updateDeviceKeyWithOldDeviceAuth:(DeviceAuthentication *)oldDeviceAuth newDeviceAuth:(DeviceAuthentication*)newDeviceAuth deviceInfo:(DeviceInfo*)deviceInfo error:(NSError**)error;

/*!
 * @discussion updateDeviceKeyWithOldDeviceAuth save all accounts device information and Configuration.
 * @param oldDeviceAuth contain current or old DeviceAuthentication
 * @param newDeviceAuth contain new DeviceAuthentication will be change the old DeviceAuthentication
 * @param account object contain current Account
 * @return new Account for new DeviceAuthentication
 */
-(Account *)updateAccountKeyWithOldDeviceAuth:(DeviceAuthentication *)oldDeviceAuth newDeviceAuth:(DeviceAuthentication *)newDeviceAuth account:(Account*)account error:(NSError**)error;

@end
