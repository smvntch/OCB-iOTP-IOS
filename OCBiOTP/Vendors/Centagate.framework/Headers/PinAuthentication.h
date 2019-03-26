//
//  PinAuthentication.h
//  centagate
//
//  Created by SecureTest on 25/05/2016.
//  Copyright © 2016 securemetric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DeviceAuthentication.h"
#import "DeviceAuthenticationProtocol.h"
/*! @brief object which is implement DeviceAuthentication protocol uses for authentication on API */
@interface PinAuthentication : DeviceAuthentication<DeviceAuthenticationProtocol>


-(AuthenticationType)getAuthenticationType;
/*!
 * @discussion setPinWithPin to encrypt user data with Pin
 * @param pin contain 6 digits String as a key
 * @param error return error
 * @return set Pin status
 */
-(BOOL)setPinWithPin:(NSString*)pin error:(NSError**)error;

/*!
 * @discussion authenticateWithObject to authenticate user Pin with Pin
 * @param pin contain more than 0 digit String as a key
 * @param error return error
 * @return authentication result
 */
-(BOOL)authenticateWithObject:(NSObject *)pin error:(NSError **)error;

-(NSString *)getAuthenticationInfo;

@property (nonatomic, strong) id<DeviceAuthenticationProtocol> delegate;

@end
