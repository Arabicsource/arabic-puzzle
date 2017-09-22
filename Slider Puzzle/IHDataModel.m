//
//  IHDataModel.m
//  Sliding Puzzle
//
//  Created by Adil Ben Moussa on 5/7/12.
//  Copyright (c) 2012 Islamhome.info. All rights reserved.
//

#import "IHDataModel.h"
#import "IHFileUtils.h"

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation IHDataModel

@synthesize currentImage, settings, images, pieciesMode, showNumnerOnTiles;
static IHDataModel *model;

///////////////////////////////////////////////////////////////////////////////////////////////////
-(void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kPuzzleChangedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kPuzzlePropertiesChangedNotification object:nil];
    IH_RELEASE_SAFELY(pieciesMode);
    IH_RELEASE_SAFELY(images);
    IH_RELEASE_SAFELY(currentImage);
    IH_RELEASE_SAFELY(settings);
	[super dealloc];
}

// Class functions
///////////////////////////////////////////////////////////////////////////////////////////////////
+(IHDataModel *)model
{
	if (!model)
		model = [[IHDataModel alloc] init];
    
	return model;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
+(id)alloc
{
	NSAssert(model == nil, @"Attempted to allocate a second instance of a singleton.");
	model = [super alloc];
	return model;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
+(id)copy
{
	NSAssert(model == nil, @"Attempted to copy the singleton.");
	return model;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
+(void)initialize
{
    static BOOL initialized = NO;
    if (!initialized)
	{		
        initialized = YES;
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
-(id)init {
	if( self = [super init] )
	{
        showNumnerOnTiles = NO;
        [self readSettings];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveChange:) name:kPuzzleChangedNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveChange:) name:kPuzzlePropertiesChangedNotification object:nil];
	}
	return self;
}

#pragma mark NSNotifications
///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didReceiveChange:(NSNotification*)notification {
    
    [self updateSettings];
}


// read the setings file
///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)readSettings{
    
    NSMutableDictionary *dic = [IHFileUtils readFromDoc:SETTING_FILE_PLIST withClass:[NSMutableDictionary class]];
    // file already found, so use it
    if(dic != nil){
        settings = [dic retain];
    }
    // no file found, so create one
    else{
        settings = [[IHFileUtils readPlist:SETTING_FILE] retain];
        [IHFileUtils saveSettingsToDisk:settings];
    }
    
    NSNumber *number = [settings objectForKey:kShowNumberOnTiles];
    showNumnerOnTiles = [number intValue] == 1;
    
    if(currentImage!= nil)
        IH_RELEASE_SAFELY(currentImage);
    
    currentImage = [[settings objectForKey:kCurrentImage] retain];
    
    if(images!= nil)
        IH_RELEASE_SAFELY(images);
    images = [[settings objectForKey:kImages] retain];
    
    if(pieciesMode!= nil)
        IH_RELEASE_SAFELY(pieciesMode);
    pieciesMode = [[settings objectForKey:kPieciesMode] retain];
    
}

// update the settings file
- (void)updateSettings{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:settings];
    [dic setObject:currentImage forKey:kCurrentImage];
    [dic setObject:pieciesMode forKey:kPieciesMode];
    [dic setObject:showNumnerOnTiles ? [NSNumber numberWithInt:1] : [NSNumber numberWithInt:0] forKey:kShowNumberOnTiles];
    [IHFileUtils saveSettingsToDisk:dic];
    IH_RELEASE_SAFELY(settings);
    settings = [dic retain];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)goForwards
{
    int count = [images count];
    for(int i=0 ; i<= count; i++){
        NSMutableDictionary *image = [[images objectAtIndex:i] retain];
        NSString *current = [[image objectForKey:kName] retain];
        NSMutableDictionary *match = nil;
        if([currentImage isEqualToString:current]){
            match = (i ==  count-1) ? [[images objectAtIndex:0] retain] : [[images objectAtIndex:i+1] retain];
            if(currentImage!= nil)
                IH_RELEASE_SAFELY(currentImage);
            
            currentImage = [[match objectForKey:kName] retain];
            IH_RELEASE_SAFELY(match);
            break;
        }
        IH_RELEASE_SAFELY(image);
        IH_RELEASE_SAFELY(current);
    }
    [self updateSettings];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)goBackwards
{
    int count = [images count];
    for(int i=0 ; i<= count; i++){
        NSMutableDictionary *image = [[images objectAtIndex:i] retain];
        NSString *current = [[image objectForKey:kName] retain];
        NSMutableDictionary *match = nil;
        if([currentImage isEqualToString:current]){
            match = (i == 0) ? [[images objectAtIndex:count - 1] retain] : [[images objectAtIndex:i-1] retain];
            if(currentImage!= nil)
                IH_RELEASE_SAFELY(currentImage);
            
            currentImage = [[match objectForKey:kName] retain];
            IH_RELEASE_SAFELY(match);
            break;
        }
        IH_RELEASE_SAFELY(image);
        IH_RELEASE_SAFELY(current);
    }
    [self updateSettings];
}


@end
