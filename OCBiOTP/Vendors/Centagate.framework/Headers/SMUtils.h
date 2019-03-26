//
//  Utils.h
//  centagate
//
//  Created by SecureTest on 21/06/2016.
//  Copyright © 2016 securemetric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonKeyDerivation.h>

@interface SMUtils : NSObject
+(NSString *)getRandomPINString:(NSInteger)length;

+(int) base64_encode:(unsigned char *) bin_data bin_size:(unsigned int)bin_size base64_data:(char *) base64_data;
+(int) base64_decode:(char *) base64_data bin_data:(unsigned char *) bin_data bin_size:(unsigned int *) bin_size;
+(BOOL)hasInternetConnectivity;
+(void)showBytewithData:(unsigned char*)data len:(unsigned int)len;
+(boolean_t)validateIsAllZeroWithData:(unsigned char*)data length:(unsigned int)dataLen;
+(boolean_t) isValidEmailWithEmail:(NSString *)checkString;
+(boolean_t)bin_to_hexStrWithBinary:(unsigned char *)bin binsize:(unsigned int) binsz result:(char **)result;
+ (NSString*) byteToHexWithData: (unsigned char*) data ofLength: (NSUInteger) len;

+(NSData*) hexToBytes: (NSString*) str;
+(NSString*)stringToHex:(NSString*) data;
+(int) base64_webSafeEncode:(unsigned char *) bin_data bin_size:(unsigned int)bin_size base64_data:(char *) base64_data;
+ (BOOL)isTouchIDAvailable ;
@end
