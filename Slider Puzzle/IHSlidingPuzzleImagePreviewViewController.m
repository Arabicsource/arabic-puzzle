//
//  IHSlidingPuzzleImagePreviewViewController.m
//  Sliding Puzzle
//
//  Created by Adil Ben Moussa on 5/7/12.
//  Copyright (c) 2012 Islamhome.info. All rights reserved.
//

#import "IHSlidingPuzzleImagePreviewViewController.h"
#import "IHDataModel.h"

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation IHSlidingPuzzleImagePreviewViewController
@synthesize topBar, imageView;

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
    if(topBar!= nil)
        IH_RELEASE_SAFELY(topBar);
    if(imageView!= nil)
        IH_RELEASE_SAFELY(imageView);
    [super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidLoad
{
    topBar.topItem.title = IH_STRING(@"Image preview");
    UIImage *img = [UIImage imageNamed:[IHDataModel model].currentImage];
    [imageView setImage:img];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (IBAction)done:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

@end
