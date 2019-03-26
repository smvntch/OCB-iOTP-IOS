//
//  AccountInfo.h
//  centagate
//
//  Created by Development on 1/28/16.
//  Copyright (c) 2016 securemetric. All rights reserved.
//

#import <Foundation/Foundation.h>

/*! @brief Object contain all account Information */
@interface AccountInfo : NSObject <NSCopying> 


/*! @brief property of Account Id */
@property (atomic,strong) NSString * accountId;
/*! @brief property of username */
@property (atomic,strong) NSString * username;
/*! @brief property of display name */
@property (atomic,strong) NSString * displayName;
/*! @brief property of first name */
@property (atomic,strong) NSString * firstName;
/*! @brief property of last name */
@property (atomic,strong) NSString * lastName;
/*! @brief property of company name of user */
@property (atomic,strong) NSString * companyName;
/*! @brief property of company country if user */
@property (atomic,strong) NSString * companyCountry;
/*! @brief property of account cipher key for comunication each transaction */
@property (atomic,strong) NSString * accountCipherEncKey;
/*! @brief property of account cipher key for signing each transaction */
@property (atomic,strong) NSString * accountCipherSignKey;
/*! @brief property of avaiable Otp user */
@property (atomic,assign) BOOL otpEnable;

/*! @brief property of type account (offline account) */
@property  (atomic,assign) BOOL offline;

@end
