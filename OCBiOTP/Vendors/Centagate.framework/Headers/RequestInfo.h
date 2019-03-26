//
//  RequestInfo.h
//  centagate
//
//  Created by Development on 1/28/16.
//  Copyright (c) 2016 securemetric. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 * @typedef AuthenticationMethod
 * @brief A list of all authentication method.
 * @constant CR is Change Request method.
 * @constant SOFT_CERT is Soft Certification method.
 * @constant AUDIO_PASS is audio pass device method.
 * @constant QR is QR code method.
 */
typedef enum AuthenticationMethod : NSUInteger {
    CR= 5,
    SOFT_CERT=6,
    AUDIO_PASS=7,
    SIGN_OTP=13,
    QR=40
} AuthenticationMethod;

/*! @brief object of request information needed for do authenticate */
@interface RequestInfo : NSObject <NSCopying>

/*! @brief property request Id get from notification or getQRRequestInfo */
@property (atomic,strong) NSString * requestId;
/*! @brief property company name get from AuthenticationService getRequestInfo method */
@property (atomic,strong) NSString * companyName;
/*! @brief property username get from AuthenticationService getRequestInfo method */
@property (atomic,strong) NSString * username;
/*! @brief property application name get from AuthenticationService getRequestInfo method */
@property (atomic,strong) NSString * appName;
/*! @brief property IP get from AuthenticationService getRequestInfo method */
@property (atomic,strong) NSString * ip;
/*! @brief property location get from AuthenticationService getRequestInfo method */
@property (atomic,strong) NSString * location;
/*! @brief property time get from AuthenticationService getRequestInfo method */
@property (atomic,strong) NSString * time;
/*! @brief property randomString get from AuthenticationService getRequestInfo method */
@property (atomic,strong) NSString * randomString;
/*! @brief property requestDate will be empty */
@property (atomic,strong) NSString * requestDate;
/*! @brief property requestTime will be empty */
@property (atomic,strong) NSString * requestTime;
/*! @brief property accountId get from AuthenticationService getRequestInfo method */
@property (atomic,strong) NSString * accountId;
/*! @brief property qrChallenge get from QrAuthenticationService getQRRequestInfo and also the other value will have value also */
@property (atomic,strong) NSString * qrChallenge;
/*! @brief property detail get from AuthenticationService getRequestInfo method */
@property (atomic,strong) NSString * detail;
/*! @brief property detail get from AuthenticationService getRequestInfo method customize OCB */
@property (atomic,strong) NSString * displayMessage;
/*! @brief property clientId get from AuthenticationService getPendingRequest method */
@property (atomic,strong) NSString * clientId;
/*! @brief property type get from AuthenticationService getPendingRequest method */
@property  unsigned int type;
/*! @brief property authMethod get from AuthenticationService getRequestInfo method */
@property  AuthenticationMethod authMethod;

@end
