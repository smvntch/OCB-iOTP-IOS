//
//  OtpInfo.h
//  centagate
//
//  Created by Development on 1/28/16.
//  Copyright (c) 2016 securemetric. All rights reserved.
//

#import <Foundation/Foundation.h>
/*! @brief object contain all of Otp Information */
@interface OtpInfo : NSObject <NSCopying>
/*! @brief property of serial number OTP user */
@property (atomic,strong) NSString * otpSerialNumber;
/*! @brief property of signing algorithm Otp user */
@property (atomic,strong) NSString * otpSignAlgo;
/*! @brief property of CSV algorithm Otp user */
@property (atomic,strong) NSString * otpCsvAlgo;
/*! @brief property of CR algorithm Otp user */
@property (atomic,strong) NSString * otpCrAlgo;
/*! @brief property of seed of Otp user */
@property (atomic,strong) NSString * cipherOtpSeed;
/*! @brief property of random data used for activate OTP */
@property (atomic,strong) NSString * randomData;
/*! @brief property of otp gap Otp user */
@property  NSInteger otpGap;

@end
