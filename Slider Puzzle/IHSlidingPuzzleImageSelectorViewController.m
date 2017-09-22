//
//  SliderPuzzleTileViewController.m
//  Sliding Puzzle
//
//  Created by Adil Ben Moussa on 5/7/12.
//  Copyright (c) 2012 Islamhome.info. All rights reserved.
//

#import "IHSlidingPuzzleImageSelectorViewController.h"
#import "IHImageCustomCell.h"
#import "IHDataModel.h"

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation IHSlidingPuzzleImageSelectorViewController
@synthesize topBar;

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
    if(topBar!= nil)
        IH_RELEASE_SAFELY(topBar);
    [super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidLoad
{
    topBar.topItem.title = IH_STRING(@"Select new puzzle");
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

// Customize the number of rows in the table view.
///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[IHDataModel model].images count];
}

// Customize the appearance of table view cells.
///////////////////////////////////////////////////////////////////////////////////////////////////
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    IHImageCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[IHImageCustomCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }   
    
    NSMutableDictionary *data = [[IHDataModel model].images objectAtIndex: [indexPath row]];
    cell.primaryLabel.text = [data objectForKey:kTitle];
    cell.secondaryLabel.text =[data objectForKey:kName];
    cell.myImageView.image = [UIImage imageNamed:[data objectForKey:kName]];
    
    return cell;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        
    NSMutableDictionary *data = [[IHDataModel model].images objectAtIndex: [indexPath row]];
    [IHDataModel model].currentImage = [data objectForKey:kName];
    [[NSNotificationCenter defaultCenter] postNotificationName:kPuzzleChangedNotification object:nil];
    [self dismissModalViewControllerAnimated:YES];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (IBAction)done:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

@end
