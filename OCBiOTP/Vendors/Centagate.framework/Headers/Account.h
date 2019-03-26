//
//  Account.h
//  centagate
//
//  Created by Development on 1/28/16.
//  Copyright (c) 2016 securemetric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccountInfo.h"
#import "OtpInfo.h"
/*! @brief object of all account information */
@interface Account : NSObject <NSCopying> 

/*! @brief property of all account information */
@property (atomic,strong) AccountInfo * accountInfo;
/*! @brief property of all Otp information */
@property (atomic,strong) OtpInfo * otpInfo;

@end
