//
//  IHFileUtils.h
//  Sliding Puzzle
//
//  Created by Adil Ben Moussa on 5/7/12.
//  Copyright (c) 2012 Islamhome.info. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IHFileUtils : NSObject{
    
}

/*
 * Read the passed file name
 *
 */
+ (id)readPlist:(NSString *)fileName;

/*
 * Save the passed dic to the disk
 *
 */
+ (void)saveSettingsToDisk:(NSMutableDictionary *)dic;

/*
 * Get the path to the root docuemnts
 *
 * @return the path to the root document
 */
+ (NSString *)pathToDoc;

/**
 * Read an array or a dictionary from the document folder
 *
 * @param fileName  the name of the file to read.
 * @param cls the the class to get the data of. Possible values: [NSMutableDictionary  class], [NSMutableArray class]
 */
+ (id)readFromDoc:(NSString *)fileName withClass:(Class)cls;

@end
