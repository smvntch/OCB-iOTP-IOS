//
//  CompleteEntity.h
//  centagate
//
//  Created by SecureTest on 25/05/2016.
//  Copyright © 2016 securemetric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Account.h"
#import "DeviceInfo.h"
#import "DeviceAuthentication.h"
/*! @brief object contain all of app information */
@interface CompleteEntity : NSObject <NSCopying>

/*! @brief property Array contains all account */
@property (atomic,strong) NSMutableArray * accounts;

/*! @brief property contain DeviceInfo of app */
@property (atomic,strong) DeviceInfo   * deviceInfo;

/*! @brief property contain DeviceAuthentication's user */
@property (atomic,strong) DeviceAuthentication * deviceAuthentication;

@end
