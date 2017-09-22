//
//  SliderPuzzleMainViewController.m
//  Sliding Puzzle
//
//  Created by Adil Ben Moussa on 5/7/12.
//  Copyright (c) 2012 Islamhome.info. All rights reserved.
//

#import "IHSlidingPuzzleRootViewController.h"
#import "IHDataModel.h"
#import "IHSlidingPuzzleSettingsViewController.h"

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation IHSlidingPuzzleRootViewController
@synthesize topBar,tiles, tileImageView,puzzleContainer, togglePuzzleButton, showImageButton;

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kPuzzleChangedNotification object:nil];
    
    if(topBar!= nil){
        IH_RELEASE_SAFELY(topBar);
    }
    if(tiles!= nil){
        IH_RELEASE_SAFELY(tiles);
    }
    if(tileImageView!= nil)
        IH_RELEASE_SAFELY(tileImageView);
    if(puzzleContainer!= nil)
        IH_RELEASE_SAFELY(puzzleContainer);
    if(togglePuzzleButton!= nil)
        IH_RELEASE_SAFELY(togglePuzzleButton);
    if(showImageButton!= nil)
        IH_RELEASE_SAFELY(showImageButton);
    [super dealloc];
}

#pragma mark - View lifecycle
///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidLoad
{  
    topBar.topItem.title = kAppName;
    [togglePuzzleButton setTitle:IH_STRING(@"Start")];
    [showImageButton setTitle:IH_STRING(@"Image")];
    [self updatePiecies];
    tiles = [[NSMutableArray alloc] init];
    isPlaying = YES;
    [self togglePuzzle:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceivePuzzleChanged:) name:kPuzzleChangedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceivePuzzlePropertiesChanged:) name:kPuzzlePropertiesChangedNotification object:nil];
    [super viewDidLoad];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)updatePiecies{
    NSInteger pieciesMode = [[[IHDataModel model].settings objectForKey:kPieciesMode] intValue];
    switch (pieciesMode) {
		case PIECE_3_3:
            numHorizontalPieces = 3;
            numVerticalPieces = 3;
			break;
		case PIECE_4_4:
            numHorizontalPieces = 4;
            numVerticalPieces = 4;
			break;
        case PIECE_5_5:
            numHorizontalPieces = 5;
            numVerticalPieces = 5;
			break;
		default:
            numHorizontalPieces = 3;
            numVerticalPieces = 3;
            break;
    }

}

#pragma mark NSNotifications
///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didReceivePuzzleChanged:(NSNotification*)notification {
    [self updatePiecies];
    isPlaying = YES;
    [self togglePuzzle:nil];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didReceivePuzzlePropertiesChanged:(NSNotification*)notification {
    // show hide the numbers
    BOOL showNumnerOnTiles = [IHDataModel model].showNumnerOnTiles;
    for (IHTileView *tile in tiles){
        tile.label.hidden = !showNumnerOnTiles;
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// Toggle the puzzle, start/stop
- (IBAction)togglePuzzle:(id)sender{
    
    // remove all tiles from the parent view
    for( IHTileView *tile in tiles ){
        [tile removeFromSuperview];		
    }
    
    [self initPuzzle];
    
    if(!isPlaying){
        [self shuffle];
        togglePuzzleButton.title = IH_STRING(@"Reset");
        isPlaying = YES;
    }
    else{
        isPlaying = NO;
        togglePuzzleButton.title = IH_STRING(@"Start");
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// Select a new puzzle
- (IBAction)selectNewPuzzlePressed:(id)sender{
    
    IHSlidingPuzzleImageSelectorViewController *viewController = [[IHSlidingPuzzleImageSelectorViewController alloc] init];
    [self presentModalViewController:viewController animated:YES];
    IH_RELEASE_SAFELY(viewController);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// Go to the next puzzle
- (IBAction)nextPuzzle:(id)sender{
        
    [[IHDataModel model] goForwards];
    isPlaying = YES;
    [self togglePuzzle:nil];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// Go back to the previous puzzle
- (IBAction)previousPuzzle:(id)sender{
    
    [[IHDataModel model] goBackwards];
    isPlaying = YES;
    [self togglePuzzle:nil];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// Settings button has been pressed
- (IBAction)settingsPressed:(id)sender{
    
    IHSlidingPuzzleSettingsViewController *viewController = [[IHSlidingPuzzleSettingsViewController alloc] init];
    [self presentModalViewController:viewController animated:YES];
    IH_RELEASE_SAFELY(viewController);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// show the original image
- (IBAction)orgImageButtonPressed:(id)sender{
    
    IHSlidingPuzzleImagePreviewViewController *viewController = [[IHSlidingPuzzleImagePreviewViewController alloc] init];
    [self presentModalViewController:viewController animated:YES];
    IH_RELEASE_SAFELY(viewController);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
/**
 * take an image path, load the image and break it into tiles to use as our puzzle pieces. 
 **/ 
-(void) initPuzzle{
    
	UIImage *orgImage = [UIImage imageNamed:[IHDataModel model].currentImage];
	
	if( orgImage == nil ){
		return; 
	}
	
    if(tiles!= nil)
        [tiles removeAllObjects];
	
	float width = orgImage.size.width < puzzleContainer.frame.size.width ? orgImage.size.width : puzzleContainer.frame.size.width;
   	float height = orgImage.size.height < puzzleContainer.frame.size.height ? orgImage.size.height : puzzleContainer.frame.size.height;
    
    tileWidth = width/numHorizontalPieces;
	tileHeight = height/numVerticalPieces;
    
	blankPosition = CGPointMake( numHorizontalPieces - 1, numVerticalPieces - 1 );
	int i=1;
	BOOL showNumnerOnTiles = [IHDataModel model].showNumnerOnTiles;
    for( int y=0; y<numVerticalPieces; y++ ){
        for( int x=0; x<numHorizontalPieces; x++ ){
			CGPoint orgPosition = CGPointMake(x,y); 
			
			if( blankPosition.x == orgPosition.x && blankPosition.y == orgPosition.y ){
				continue; 
			}
			
			CGRect frame = CGRectMake(tileWidth*x, tileHeight*y, 
									  tileWidth, tileHeight );
			CGImageRef tileImageRef = CGImageCreateWithImageInRect( orgImage.CGImage, frame );
			UIImage *tileImage = [UIImage imageWithCGImage:tileImageRef];
			
			CGRect tileFrame =  CGRectMake((tileWidth+TILE_SPACING)*x, (tileHeight+TILE_SPACING)*y, 
										   tileWidth, tileHeight );
			
			tileImageView = [[IHTileView alloc] initWithImage:tileImage];
            tileImageView.index = i;
            tileImageView.showNumnerOnTiles = showNumnerOnTiles;
			tileImageView.frame = tileFrame;
			tileImageView.originalPosition = orgPosition;
			tileImageView.currentPosition = orgPosition;
			CGImageRelease( tileImageRef );
			
			[tiles addObject:tileImageView];
			
			// now add to view
			[puzzleContainer insertSubview:tileImageView atIndex:0];
			[tileImageView release];
            i++;
		}
	}
}

#pragma mark tile handling methods 
///////////////////////////////////////////////////////////////////////////////////////////////////
-(ShuffleMove) validMove:(IHTileView *) tile{
	// blank spot above current piece 
	if( tile.currentPosition.x == blankPosition.x && tile.currentPosition.y == blankPosition.y+1 ){
		return UP; 
	}
	
	// bank splot below current piece
	if( tile.currentPosition.x == blankPosition.x && tile.currentPosition.y == blankPosition.y-1 ){
		return DOWN; 
	}
	
	// bank spot left of the current piece
	if( tile.currentPosition.x == blankPosition.x+1 && tile.currentPosition.y == blankPosition.y ){
		return LEFT; 
	}
	
	// bank spot right of the current piece
	if( tile.currentPosition.x == blankPosition.x-1 && tile.currentPosition.y == blankPosition.y ){
		return RIGHT; 
	}
	
	return NONE;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
-(void) movePiece:(IHTileView *) tile withAnimation:(BOOL) animate{
	switch ( [self validMove:tile] ) {
		case UP:
			[self movePiece:tile 
			   inDirectionX:0 inDirectionY:-1 withAnimation:animate];
			break;
		case DOWN:
			[self movePiece:tile 
			   inDirectionX:0 inDirectionY:1 withAnimation:animate];
			break;
		case LEFT:
			[self movePiece:tile 
			   inDirectionX:-1 inDirectionY:0 withAnimation:animate];
			break;
		case RIGHT:
			[self movePiece:tile 
			   inDirectionX:1 inDirectionY:0 withAnimation:animate];
			break;
		default:
			break;
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////
-(void) movePiece:(IHTileView *) tile inDirectionX:(NSInteger) dx inDirectionY:(NSInteger) dy withAnimation:(BOOL) animate{
	tile.currentPosition = CGPointMake( tile.currentPosition.x+dx, 
                                       tile.currentPosition.y+dy); 
	blankPosition = CGPointMake( blankPosition.x-dx, blankPosition.y-dy );
	
	int x = tile.currentPosition.x; 
	int y = tile.currentPosition.y;
	
	if( animate ){
		[UIView beginAnimations:@"frame" context:nil];
	}
	tile.frame = CGRectMake((tileWidth+TILE_SPACING)*x, (tileHeight+TILE_SPACING)*y, 
                            tileWidth, tileHeight );
	if( animate ){
		[UIView commitAnimations];
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////
-(void) shuffle{
	NSMutableArray *validMoves = [[NSMutableArray alloc] init];
	
	srandom(time(NULL));
	
	for( int i=0; i<SHUFFLE_NUMBER; i++ ){
		[validMoves removeAllObjects];
		
		// get all of the pieces that can move 
		for( IHTileView *tile in tiles ){
			if( [self validMove:tile] != NONE ){
				[validMoves addObject:tile];
			}
		}
		
		// randomly select a piece to move 
		NSInteger pick = random()%[validMoves count];
		//NSLog(@"shuffleRandom using pick: %d from array of size %d", pick, [validMoves count]);
		[self movePiece:(IHTileView *)[validMoves objectAtIndex:pick] withAnimation:NO];
	}
	
	[validMoves release];
}

#pragma mark helper methods 
///////////////////////////////////////////////////////////////////////////////////////////////////
-(IHTileView *) getPieceAtPoint:(CGPoint) point{
	CGRect touchRect = CGRectMake(point.x, point.y, 1.0, 1.0);
	
	for( IHTileView *tile in tiles ){
		if( CGRectIntersectsRect(tile.frame, touchRect) ){
			return tile; 
		}		
	}
	return nil;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
-(BOOL) puzzleCompleted{
	for( IHTileView *tile in tiles ){
		if( tile.originalPosition.x != tile.currentPosition.x || tile.originalPosition.y != tile.currentPosition.y ){
			return NO;
		}
	}
	
	return YES;
}

#pragma mark user input hanlding 
///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
    CGPoint currentTouch = [touch locationInView:puzzleContainer];	
	
	IHTileView *tile = [self getPieceAtPoint:currentTouch];
	if( tile != nil && isPlaying){
		[self movePiece:tile withAnimation:YES];
		if( [self puzzleCompleted] ){
            
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:IH_STRING(@"You Won!")
                                                              message:IH_STRING(@"Great Job!")
                                                             delegate:nil
                                                    cancelButtonTitle:IH_STRING(@"OK")
                                                    otherButtonTitles:nil];
            [message show];
            [message release];
		}
	}
}

@end