//
//  OtpService.h
//  centagate
//
//  Created by SecureTest on 24/04/2016.
//  Copyright © 2016 securemetric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OtpInfo.h"
#import "AccountInfo.h"
#import "Account.h"
#import "DeviceAuthentication.h"

/*! @brief object contain All Otp binding proccess */
@interface OtpService : NSObject

/*!
 * @discussion getOfflineCrOtpWithHid for get detail of OTP user
 * @param hid contain String from device
 * @param accountInfo contain full of information accountInfo
 * @param deviceAuthentication authentication object contain authentication infromation from user
 * @return OtpInfo otp detail related to user
 */
-(OtpInfo*) getOtpWithHid:(NSString*)hid accountInfo:(AccountInfo*)accountInfo deviceAuthentication:(DeviceAuthentication *)deviceAuthentication error:(NSError**)error;
/*!
 * @discussion activateOfflineCrOtpWithHid for get detail of OTP user
 * @param hid contain String from device
 * @param otpInfo contain full of information Otp
 * @param accountInfo contain full of information accountInfo
 * @param deviceAuthentication authentication object contain authentication infromation from user
 * @return status binding process
 */
-(BOOL)activateOtpWithHid:(NSString*)hid otpInfo:(OtpInfo*)otpInfo accountInfo:(AccountInfo*)accountInfo deviceAuthentication:(DeviceAuthentication *)deviceAuthentication error:(NSError**)error;

/*!
 * @discussion getOfflineOtpWithActivationCode for get detail of OTP offline
 * @param activationCode contain String from activation code
 * @param activationPin contain String Pin
 * @param deviceAuthentication authentication object contain authentication infromation from user
 * @return OtpInfo otp detail related to user
 */
-(OtpInfo*) getOfflineOtpWithActivationCode:(NSString*)activationCode activationPin:(NSString*)activationPin deviceAuthentication:(DeviceAuthentication *)deviceAuthentication error:(NSError**)error;

/*!
 * @discussion activateOfflineCrOtpWithHid for get detail of OTP user
 * @param hid contain String from device
 * @param account contain full information account
 * @param deviceAuthentication contain authentication object contain authentication infromation from user
 * @return status syncronizing process
 */
-(BOOL)syncOtpWithHid:(NSString*)hid account:(Account*)account deviceAuthentication:(DeviceAuthentication *)deviceAuthentication error:(NSError**)error;



@end
