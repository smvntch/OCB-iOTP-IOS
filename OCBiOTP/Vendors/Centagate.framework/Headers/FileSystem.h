//
//  FileSystem.h
//  centagate
//
//  Created by SecureTest on 19/05/2016.
//  Copyright © 2016 securemetric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DeviceAuthentication.h"
#import "DeviceInfo.h"
#import "CompleteEntity.h"

/*! @brief object contain function to save and get all application informations */
@interface FileSystem : NSObject

/*!
 * @discussion saveAccountsToFilename save all accounts device information and Configuration.
 * @param fileName contain String filename of file
 * @param accounts array contains Account object
 * @param deviceInfo object contain device information
 * @param deviceAuthentication contain authentication object contain authentication infromation from user
 * @return status save result
 */
-(boolean_t)saveAccountsToFilename:(NSString *)fileName accounts:(NSMutableArray*)accounts deviceInfo:(DeviceInfo*)deviceInfo deviceAuthentication:(DeviceAuthentication *)deviceAuthentication error:(NSError **)error;

/*!
 * @discussion getAccountFromFilename get all accounts device information and Configuration.
 * @param fileName contain String filename of file
 * @return CompleteEntity contains all object for running application
 */
-(CompleteEntity*)getAccountFromFilename:(NSString *)fileName error:(NSError **)error;;
/*!
 * @discussion deleteFileWithFilename delete all accounts device information and Configuration.
 * @param filename contain String filename of file
 */
-(void)deleteFileWithFilename:(NSString*)filename error:(NSError **)error;;

@end
