//
//  SessionInfo.h
//  centagate
//
//  Created by SecureTest on 21/11/2016.
//  Copyright © 2016 securemetric. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SessionInfo : NSObject <NSCopying>

/*! @brief property of account information Id */
@property (atomic,strong) NSString * accountId;
/*! @brief property of session key */
@property (atomic,strong) NSData * sessionKey;



@end
