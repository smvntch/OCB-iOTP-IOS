//
//  BindInfo.h
//  centagate
//
//  Created by SecureTest on 09/01/2017.
//  Copyright © 2017 securemetric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Account.h"
#import "DeviceInfo.h"

@interface BindInfo : NSObject <NSCopying>

/*! @brief property of account */
@property (atomic,strong) Account * account;
/*! @brief property of Device Information */
@property (atomic,strong) DeviceInfo  * deviceInfo;

@end
