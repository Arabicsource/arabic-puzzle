//
//  SliderPuzzleMainViewController.h
//  Sliding Puzzle
//
//  Created by Adil Ben Moussa on 5/7/12.
//  Copyright (c) 2012 Islamhome.info. All rights reserved.
//

#import "IHSlidingPuzzleImageSelectorViewController.h"
#import "IHSlidingPuzzleImagePreviewViewController.h"
#import "IHSlidingPuzzleImageSelectorViewController.h"
#import "IHTileView.h"

@interface IHSlidingPuzzleRootViewController : UIViewController{
    CGFloat tileWidth; 
	CGFloat tileHeight;
	
	NSMutableArray *tiles; 
	CGPoint blankPosition; 
    
    IHTileView *tileImageView;
    IBOutlet UINavigationBar *topBar;
    IBOutlet UIView *puzzleContainer;
    IBOutlet UIBarButtonItem *togglePuzzleButton;
    IBOutlet UIBarButtonItem *showImageButton;
    BOOL isPlaying;
    
    int numHorizontalPieces;
    int numVerticalPieces;
}

- (IBAction)togglePuzzle:(id)sender;
- (IBAction)nextPuzzle:(id)sender;
- (IBAction)previousPuzzle:(id)sender;
- (IBAction)selectNewPuzzlePressed:(id)sender;
- (IBAction)orgImageButtonPressed:(id)sender;
- (IBAction)settingsPressed:(id)sender;
- (void)updatePiecies;


@property (nonatomic,retain) NSMutableArray *tiles; 
@property (nonatomic,retain) IHTileView *tileImageView;
@property (nonatomic,retain) IBOutlet UINavigationBar *topBar;
@property (nonatomic,retain) IBOutlet UIView *puzzleContainer;
@property (nonatomic,retain) IBOutlet UIBarButtonItem *togglePuzzleButton;
@property (nonatomic,retain) IBOutlet UIBarButtonItem *showImageButton;

-(void) initPuzzle;

-(ShuffleMove) validMove:(IHTileView *) tile;
-(void) movePiece:(IHTileView *) tile withAnimation:(BOOL) animate;
-(void) movePiece:(IHTileView *) tile inDirectionX:(NSInteger) dx inDirectionY:(NSInteger) dy withAnimation:(BOOL) animate;
-(void) shuffle;

-(IHTileView *) getPieceAtPoint:(CGPoint) point;
-(BOOL) puzzleCompleted;

@end