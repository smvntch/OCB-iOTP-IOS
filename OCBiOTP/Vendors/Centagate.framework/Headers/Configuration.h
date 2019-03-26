//
//  Configuration.h
//  centagate
//
//  Created by SecureTest on 23/02/2016.
//  Copyright © 2016 securemetric. All rights reserved.
//

#import <Foundation/Foundation.h>


/*! @brief object contain all of basic configuration for API */
@interface Configuration : NSObject

/*!
 * @discussion getWebServiceUrl to get String web service URL (you need to set first)
 * @return String of Web Service URL
 */
+(NSString *)getWebServiceUrl;
/*!
 * @discussion getWebServiceUrl to set String web service URL.
 * @param url  String of Web Service URL
 */
+(void)setWebServiceUrlWithUrl:(NSString *)url;
/*!
 * @discussion setTrustedCertResourcesWithSecCertificateRefArray to set Array of SecCertificateRef
 * @param certsPath Array of SecCertificateRef
 */
+(void)setTrustedCertResourcesWithSecCertificateRefArray:(NSArray*)certsPath;
/*!
 * @discussion getTrustedCertResources to set String web service URL.
 * @return  Array of SecCertificateRef
 */
+(NSArray*)getTrustedCertResources;

/*!
 * @discussion getApprovalUrl to get String web service approval URL (you need to set first)
 * @return String of Web Service URL
 */
+(NSString *)getApprovalUrl;
/*!
 * @discussion setApprovalUrlWithUrl to set String web service approval URL.
 * @param url  String of Web Service approval URL
 */
+(void)setApprovalUrlWithUrl:(NSString *)url;

/*!
 * @discussion getTimeout to get connetion timeout value (you need to set first)
 * @return Int of timeout in second
 */
+(int)getTimeout;

/*!
 * @discussion setTimeoutWithTime to set connetion timeout value( in second)
 * @param time Int mark for how many second timeout connection
 */
+(void)setTimeoutWithTime:(int)time;

/*!
 * @discussion getServerEncPublicKey to set string contain Server encryption public key (you need to set first)
 * @return String Server encryption public key
 */
+(NSString *)getServerEncPublicKey;

/*!
 * @discussion setServerEncPublicKey to get string contain Server encryption public key
 * @param key String Server encryption public key
 */
+(void)setServerEncPublicKeyWithKey:(NSString *)key;

/*!
 * @discussion getServerSignPublicKey to set string contain Server signing public key (you need to set first)
 * @return String Server encryption public key
 */
+(NSString *)getServerSignPublicKey;

/*!
 * @discussion setServerSignPublicKeyWithKey to get string contain Server signing public key
 * @param key String Server encryption public key
 */
+(void)setServerSignPublicKeyWithKey:(NSString *)key;

/*!
 * @discussion isValidConfiguration to do validation on configuration
 * @return status validation
 */
+(BOOL)isValidConfigurationWithReason:(NSString **)reason;



@end
