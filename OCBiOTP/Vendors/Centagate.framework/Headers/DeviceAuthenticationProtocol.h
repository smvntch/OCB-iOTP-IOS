//
//  DeviceAuthenticationProtocol.h
//  centagate
//
//  Created by SecureTest on 20/09/2016.
//  Copyright © 2016 securemetric. All rights reserved.
//

/*! @brief protocol object to do authentication on API */
@protocol DeviceAuthenticationProtocol <NSObject>
/*! @brief method to do/check authentication String pin contain depends of implemented object contain */
@required
-(BOOL)authenticateWithObject:(NSObject*)pin error:(NSError**)error;

@required
-(AuthenticationType)getAuthenticationType;

@end

