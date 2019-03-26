//
//  AccountService.h
//  centagate
//
//  Created by SecureTest on 22/04/2016.
//  Copyright © 2016 securemetric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DeviceAuthentication.h"
#import "AccountInfo.h"
#import "DeviceInfo.h"
#import "SessionInfo.h"
#import "BindInfo.h"

/*! @brief Object contain all account service */
@interface AccountService : NSObject

/*!
 * @discussion getAccountInfoWithQrCode for get details of user
 * @param sessionInfo contain key from onlineProvisioningWithUsername or from getSessionInfo
 * @param deviceAuthentication authentication object contain authentication information from user
 * @param accountInfo contain basic accountInfo get from DeviceService.bindAccount
 * @param hid contain unique string  get from device Id
 * @param error return error
 * @return AccountInfo full account user information
 */
-(AccountInfo *)getAccountInfoWithSessionInfo:(SessionInfo *)sessionInfo deviceAuthentication:(DeviceAuthentication *)deviceAuthentication accountInfo:(AccountInfo*)accountInfo hid:(NSString*)hid error:(NSError**)error;


/*!
 * @discussion bind account between device and server
 * @param sessionInfo contain String from onlineProvisioningWithUsername or getSessionInfo
 * @param hid contain unique string  get from device Id
 * @param deviceAuthentication contain authentication object contain authentication information from user
 * @param deviceToken contain APNS registration Id
 * @param imei contain unique Id from device
 * @param os Operation System and version
 * @param model mode of phone
 * @param deviceInfo contain device key get from SetDeviceKey method
 * @param error return error
 * @return AccountInfo contains with cipher key can use it to AccountService.getAccountIfo
 */
-(AccountInfo *)bindWithSessionInfo:(SessionInfo *)sessionInfo hid:(NSString*)hid DeviceAuth:(DeviceAuthentication *)deviceAuthentication deviceToken:(NSString *)deviceToken imei:(NSString*)imei os:(NSString*)os model:(NSString*)model deviceInfo:(DeviceInfo *)deviceInfo error:(NSError**)error;


/*!
 * @discussion bind account between device and server
 * @param sessionInfo contain String from onlineProvisioningWithUsername or getSessionInfo
 * @param hid contain unique string  get from device Id
 * @param deviceAuthentication contain authentication object contain authentication information from user
 * @param deviceToken contain APNS registration Id
 * @param imei contain unique Id from device
 * @param os Operation System and version
 * @param model mode of phone
 * @param deviceInfo contain device key get from SetDeviceKey method, if nil will generate new device key.
 * @param error return error
 * @return AccountInfo contains with cipher key can use it to AccountService.getAccountIfo
 */
-(BindInfo *)bindCompleteWithSessionInfo:(SessionInfo *)sessionInfo hid:(NSString*)hid DeviceAuth:(DeviceAuthentication *)deviceAuthentication deviceToken:(NSString *)deviceToken imei:(NSString*)imei os:(NSString*)os model:(NSString*)model deviceInfo:(DeviceInfo *)deviceInfo error:(NSError**)error;


/*!
 * @discussion update bind proccess result status to server
 * @param sessionInfo contain String from onlineProvisioningWithUsername or getSessionInfo
 * @param accountInfo accountInfo contain of full information get from AccountService.getAccountIfo
 * @param deviceAuthentication contain authentication object contain authentication information from user
 * @param error return error
 * @return status afrer bind
 */
-(BOOL)updateBindStatusWithSessionInfo:(SessionInfo *)sessionInfo accountInfo:(AccountInfo*)accountInfo DeviceAuth:(DeviceAuthentication *)deviceAuthentication error:(NSError**)error;

/*!
 * @discussion update bind proccess result status to server
 * @param sessionInfo contain String from onlineProvisioningWithUsername or getSessionInfo
 * @param accountInfo accountInfo contain of full information get from AccountService.bindCompleteWithSessionInfo
 * @param otpInfo otpInfo contain of full information of OTP get from AccountService.bindCompleteWithSessionInfo.
 * @param deviceAuthentication contain authentication object contain authentication information from user
 * @param error return error
 * @return status afrer bind
 */
-(BOOL)updateBindCompleteStatusWithSessionInfo:(SessionInfo *)sessionInfo hid:(NSString*)hid accountInfo:(AccountInfo*)accountInfo otpInfo:(OtpInfo*)otpInfo  DeviceAuth:(DeviceAuthentication *)deviceAuthentication error:(NSError**)error;

/*!
 * @discussion get the session key from server
 * @param username contain String of username get from web or other source
 * @param sms contain number 6 digits get from user input
 * @param error return error
 * @return Session Info for do a request
 */
-(SessionInfo*)onlineProvisioningWithUsername:(NSString*)username sms:(NSString*)sms error:(NSError**)error;

/*!
 * @discussion get the session key from server
 * @param qrCode contain String of detail get from web or other source
 * @param sms contain number 6 digits get from user input
 * @param error return error
 * @return Session Info for do a request
 */
-(SessionInfo*)getSessionInfoWithQrCode:(NSString*)qrCode sms:(NSString*)sms error:(NSError**)error;



@end
