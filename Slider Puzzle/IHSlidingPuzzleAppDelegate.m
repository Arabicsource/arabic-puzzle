//
//  SliderPuzzleAppDelegate.m
//  Sliding Puzzle
//
//  Created by Adil Ben Moussa on 5/7/12.
//  Copyright (c) 2012 Islamhome.info. All rights reserved.
//

#import "IHSlidingPuzzleAppDelegate.h"
#import "IHSlidingPuzzleRootViewController.h"
#import "IHDataModel.h"

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation IHSlidingPuzzleAppDelegate

@synthesize window = _window;
@synthesize rootViewController = _rootViewController;

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc
{
    if(_window!= nil)
        IH_RELEASE_SAFELY(_window);
    if(_rootViewController!= nil)
        IH_RELEASE_SAFELY(_rootViewController);
    [super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [IHDataModel model];
    
    //Init the model locator
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.rootViewController = [[[IHSlidingPuzzleRootViewController alloc] initWithNibName:@"IHSlidingPuzzleRootViewController" bundle:nil] autorelease];
    self.window.rootViewController = self.rootViewController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
