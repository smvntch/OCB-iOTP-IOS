//
//  SoftCertInfo.h
//  centagate
//
//  Created by SecureTest on 19/05/2016.
//  Copyright © 2016 securemetric. All rights reserved.
//

#import <Foundation/Foundation.h>
/*! @discussion object of Soft Certificate information needed for do authenticate with browser do get approvalUrl/username/sessionString/pubkey */
@interface SoftCertInfo : NSObject

/*! @brief property approveUrl */
@property (atomic,strong) NSString * approveUrl;
/*! @brief property username */
@property (atomic,strong) NSString * username;
/*! @brief property sessionString */
@property (atomic,strong) NSString * sessionString;
/*! @brief property pubkey */
@property (atomic,strong) NSString * pubkey;

@end
