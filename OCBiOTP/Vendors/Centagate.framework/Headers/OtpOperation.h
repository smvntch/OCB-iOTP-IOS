//
//  OtpOperation.h
//  centagate
//
//  Created by SecureTest on 24/04/2016.
//  Copyright © 2016 securemetric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OtpInfo.h"
#import "DeviceAuthentication.h"

/*! @brief object contain OTP operation such as, generate CR or get OTP time */
@interface OtpOperation : NSObject

/*!
 * @discussion generateCrOtpWithOtpInfo for get String of generated CR OTP
 * @param otpInfo contain full information of OTP
 * @param challengeCode contain question or challenge
 * @param deviceAuthentication authentication object contain authentication infromation from user
 * @return generated CR OTP result
 */
-(NSString*)generateCrOtpWithOtpInfo:(OtpInfo*)otpInfo challengeCode:(NSString*)challengeCode deviceAuthentication:(DeviceAuthentication *)deviceAuthentication error:(NSError**)error;
/*!
 * @discussion generateSignOtpWithOtpInfo for get String of generated Signing OTP
 * @param otpInfo contain full information of OTP
 * @param dataToSign contain question or challenge
 * @param deviceAuthentication authentication object contain authentication infromation from user
 * @return generated Sign OTP result
 */
-(NSString*)generateSignOtpWithOtpInfo:(OtpInfo*)otpInfo dataToSign:(NSString*)dataToSign deviceAuthentication:(DeviceAuthentication *)deviceAuthentication error:(NSError**)error;

/*!
 * @discussion generateTotpWithOtpInfo for get String of generated time OTP
 * @param otpInfo contain full information of OTP
 * @param deviceAuthentication authentication object contain authentication infromation from user
 * @return generated time OTP result
 */
-(NSString*)generateTotpWithOtpInfo:(OtpInfo*)otpInfo deviceAuthentication:(DeviceAuthentication *)deviceAuthentication error:(NSError**)error;
/*!
 * @discussion generateTotpWithOtpInfo for get String of generated time OTP
 * @param otpInfo contain full information of OTP
 * @param date date to generate
 * @param deviceAuthentication authentication object contain authentication infromation from user
 * @return generated time OTP result
 */
-(NSString*)generateTotpWithOtpInfo:(OtpInfo*)otpInfo date:(NSDate*)date deviceAuthentication:(DeviceAuthentication *)deviceAuthentication error:(NSError**)error;
@end
