//
//  CommonOperation.h
//  centagate
//
//  Created by SecureTest on 11/05/2016.
//  Copyright © 2016 securemetric. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonOperation : NSObject

-(boolean_t)decodeQRCodeWithSMSInput:(NSString*)sms qrCode:(NSString*)qrCode parsedData:(unsigned char**)parsedData parsedDataLen:(unsigned int*)parsedDataLen sessionKey:(unsigned char*)sessionKey;

+(NSString*)getOnlyPublicEncServerKeyUrlSave;
@end
