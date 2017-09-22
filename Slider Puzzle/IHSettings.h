//
//  IHSettings.h
//  Sliding Puzzle
//
//  Created by Adil Ben Moussa on 5/7/12 on 5/7/12.
//  Copyright (c) 2012 Islamhome.info. All rights reserved.
//

//Define macro's
#define IH_STRING(str) NSLocalizedString(str, nil)

// Safe releases
#define IH_RELEASE_SAFELY(__POINTER) { [__POINTER release]; __POINTER = nil; }
#define IH_INVALIDATE_TIMER(__TIMER) { [__TIMER invalidate]; __TIMER = nil; }

// Settings file
#define SETTING_FILE @"settings"
#define SETTING_FILE_PLIST @"settings.plist"

// The space between the tiles
#define TILE_SPACING    1

//Total allowed shulles
#define SHUFFLE_NUMBER	120

// Define the setting properties
#define kCurrentImage @"currentImage"
#define kImages @"images"
#define kPieciesMode @"pieciesMode"
#define kShowNumberOnTiles @"showNumberOnTiles"
#define kVersion @"version"
#define kName @"name"
#define kTitle @"title"

//Notifications
#define kPuzzleChangedNotification @"kPuzzleChangedNotification"
#define kPuzzlePropertiesChangedNotification @"kPuzzlePropertiesChangedNotification"

// Define the App name
#define kAppName  @"Arabic Alphabet Puzzle"

// Define the App version
#define kAppVersion  @"1.0"



// Define the App developper
#define kAppOwner  @"Islamitisch Cultureel Centrum Lansingerland"

// Define the App developper
#define kAppDevelopper  @"Islamhome.info"

// Define the App developper site
#define kAppDevelopperUrl  @"http://islamhome.info/mobile/"
#define kAppUrl  @"http://itunes.apple.com/app/id534990902"
#define kAppReviewUrl  @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=534990902"
#define kOwnerwUrl  @"http://www.moskeelansingerland.nl"
#define kAppMoreInfoUrl  @"http://www.moskeelansingerland.nl/arabic-alphabet-puzzle"

// Define the shuffle movements
typedef enum {
	NONE			= 0,
	UP				= 1,
	DOWN			= 2, 
	LEFT			= 3,
	RIGHT			= 4
} ShuffleMove;

// Define the shuffle piecies mode
typedef enum {
	PIECE_3_3		= 0,
	PIECE_4_4		= 1,
    PIECE_5_5		= 2
} PieceMode;

