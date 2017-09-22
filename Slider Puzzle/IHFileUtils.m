//
//  IHFileUtils.m
//  Sliding Puzzle
//
//  Created by Adil Ben Moussa on 5/7/12.
//  Copyright (c) 2012 Islamhome.info. All rights reserved.
//

#import "IHFileUtils.h"

@implementation IHFileUtils

/*
 * Read the passed file name
 *
 */
+ (id)readPlist:(NSString *)fileName
{
	NSData *plistData;
	NSString *error;
	NSPropertyListFormat format;
	id plist;
	
	NSString *localizedPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
	plistData = [NSData dataWithContentsOfFile:localizedPath];
	
	plist = [NSPropertyListSerialization propertyListFromData:plistData
											 mutabilityOption:NSPropertyListImmutable
													   format:&format 
											 errorDescription:&error];
	if (!plist)
		[error release];
	return plist;
}


/*
 * Save the passed dic to the disk
 *
 */
+ (void)saveSettingsToDisk:(NSMutableDictionary *)dic
{	
	NSString *file = [NSString stringWithString:@"settings.plist"];
	NSString *resumePath = [IHFileUtils pathToDoc];
	@try
	{
		[dic writeToFile:[resumePath stringByAppendingPathComponent:file] atomically:YES];
	}
	@catch (NSException *exception)
	{
		//NSLog(@"Warning: cannot save file dic to disk.");
	}
}

/*
 * Get the path to the root docuemnts
 *
 * @return the path to the root document
 */
+ (NSString *)pathToDoc
{
	return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];	
}

/**
 * Read an array or a dictionary from the document folder
 *
 * @param fileName  the name of the file to read.
 * @param cls the the class to get the data of. Possible values: [NSMutableDictionary  class], [NSMutableArray class]
 */
+ (id)readFromDoc:(NSString *)fileName withClass:(Class)cls
{
	NSString *docPath = [IHFileUtils pathToDoc];
    NSString *file = [NSString stringWithFormat:@"%@/%@", docPath, fileName];
	id list;
	@try
	{
		if(cls == [NSMutableDictionary class])
        {
            list = [[NSMutableDictionary alloc] initWithContentsOfFile:file];
        }
        else if(cls == [NSMutableArray class]) 
        {
            list = [[NSMutableArray alloc] initWithContentsOfFile:file];
        }
	}
	@catch (NSException *exception)
	{
	}
	
	if (list != nil)
		return [list autorelease];
	
	return nil;
}

@end
