//
//  FingerprintAuthentication.h
//  centagate
//
//  Created by SecureTest on 19/07/2016.
//  Copyright © 2016 securemetric. All rights reserved.
//
#import "DeviceAuthentication.h"
#import "DeviceAuthenticationProtocol.h"
#import <Foundation/Foundation.h>

@protocol FingerprintAuthenticationDelegate <NSObject>
- (void)getAuthenticationResult:(BOOL)result error:(NSError*) error;
@end

@interface FingerprintAuthentication : DeviceAuthentication<DeviceAuthenticationProtocol>
{
    id <FingerprintAuthenticationDelegate> fingerPrintDelegate;
    id ParentID;
 
}

/*! @brief return AuthenticationType to get type of authentication */
-(AuthenticationType)getAuthenticationType;


-(BOOL)isTouchIDAvailable;

/*!
 * @discussion authenticateWithObject to authenticate user with fingerprint return on delegate*/
-(void)authenticate;
-(BOOL)revoke;
-(NSString *)getAuthenticationInfo;

@property (atomic, strong) id<DeviceAuthenticationProtocol> delegate;
@property (retain,atomic) id <FingerprintAuthenticationDelegate> fingerPrintDelegate;
@property (atomic,strong) NSString * promptDescription;
@end
