//
//  DeviceAuthentication.h
//  centagate
//
//  Created by SecureTest on 23/02/2016.
//  Copyright © 2016 securemetric. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum AuthenticationType : NSUInteger {
    PIN= 1,
    FINGERPRINT=2,
    NONE=0
} AuthenticationType;


@interface DeviceAuthentication : NSObject <NSCopying>
{
    unsigned char * kek;
}
/*! @brief return Integer of max of fail do authentication */
-(NSInteger)getTryLimit;

/*! @brief return Integer of remain try to do authentication */
-(NSInteger)getRemainTry;

/*! @brief getKeyInfo return the static String key */
-(NSString *)getKeyInfo;

/*! @brief getKekKey return the Key encryption */
-(unsigned char *)getKek;

/*! @brief generateKeyInfoWithKek return the String of Key encryption */
-(NSString *)generateKeyInfoWithKekKey:(unsigned char *)kekKey;

/*! @brief generateKekKey return the Kek Key */
-(unsigned char *)generateKekKey:(NSString *)password hid:(NSString*)hid;

/*! @brief setKekKeyWithKek return the valid of kek */
-(BOOL)setKekWithKekKey:(unsigned char *)kekKey;

/*! @brief type of current authentication */
-(AuthenticationType)getAuthenticationType;

-(NSString *)getAuthenticationInfo;

-(void)setAuthenticationInfo:(NSString *)authenticationInfo;
/*!
 * @discussion authenticateWithObject to authenticate user Pin with Pin
 * @param pin contain more than 0 digit String as a key
 * @param error return error
 * @return authentication result
 */
-(BOOL)authenticateWithObject:(NSObject *)pin error:(NSError **)error;

@property (atomic,strong) NSString * keyInfo;
@property (atomic,strong) NSString * mAuthenticationInfo;
@property NSInteger tryLimit;
@property NSInteger remainTry;
@property (atomic,strong) NSData * encKek;
@property (atomic,assign) AuthenticationType authenticationType;
@property (atomic,strong) NSString * random8;

@end
