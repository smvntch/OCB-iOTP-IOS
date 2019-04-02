//
//  KeyGenerator.h
//  centagate
//
//  Created by SecureTest on 09/03/2016.
//  Copyright © 2016 securemetric. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeyGenerator : NSObject

-(unsigned char *)getSessionKeywithQrCode:(NSString*)qrCode sms:(NSString*) sms;

-(NSString*)genEncKeyPairWithKek:(unsigned char *)kek error:(NSError**)error;
-(NSString*)genSignKeyPairWithKek:(unsigned char *)kek error:(NSError**)error;
-(NSString*)getPlainEncPublicKeyWithWithKek:(unsigned char *)kek keyPair:(NSString*)cipherData error:(NSError**)error;
-(NSString*)getPlainSignPublicKeyWithWithKek:(unsigned char *)kek keyPair:(NSString*)cipherData error:(NSError**)error;
-(unsigned char*)signDataWithCipherKey:(NSString*)cipherKey kek:(unsigned char *)kek data:(NSString*)data error:(NSError**)error;
-(unsigned char*)encryptDataWithCipherKey:(NSString*)cipherKey kek:(unsigned char *)kek data:(NSString*)data publicKey:(NSString*)publicKey error:(NSError**)error;
-(unsigned char*)decryptDataWithCipherKey:(NSString*)cipherKey kek:(unsigned char *)kek data:(NSString*)data publicKey:(NSString*)publicKey error:(NSError**)error;

-(unsigned char*)decryptDataWithCipherKey:(NSString*)cipherKey kek:(unsigned char *)kek data:(unsigned char *)data dataLen:(unsigned int)dataLen publicKey:(NSString*)publicKey decryptedData:(unsigned char**)decryptedData decryptedDataLen:(unsigned int*)decryptedDataLen error:(NSError**)error;

-(boolean_t)generatePairKeyWithKek:(unsigned char *)kek returnCipherEncKey:(unsigned char **)returnCipherEncKey returnCipherSignKey:(unsigned char **)returnCipherSignKey error:(NSError**)error;


-(unsigned char*)encryptDataWithCipherKey:(NSString*)cipherKey kek:(unsigned char *)kek data:(unsigned char *)data publicKey:(NSString*)publicKey encryptedData:(unsigned char**)encryptedData encryptedDataLen:(unsigned int*)encryptedDataLen error:(NSError**)error;

@end
