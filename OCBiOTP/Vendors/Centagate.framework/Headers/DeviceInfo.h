//
//  DeviceInfo.h
//  centagate
//
//  Created by Development on 1/28/16.
//  Copyright (c) 2016 securemetric. All rights reserved.
//

#import <Foundation/Foundation.h>
/*! @brief object of device information needed for bind device to server */
@interface DeviceInfo : NSObject <NSCopying>

/*! @brief property of device sign key to do signing on transaction */
@property (atomic,strong) NSString * deviceCipherSignKey;

/*! @brief property of device encryption key to do encryption on transaction */
@property (atomic,strong) NSString * deviceCipherEncKey;

/*! @brief property of push registration Id needed to sending push from server  */
@property (atomic,strong) NSString * registrationId;

@end
