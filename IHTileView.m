//
//  IHTileView.m
//  Sliding Puzzle
//
//  Created by Adil Ben Moussa on 5/7/12.
//  Copyright (c) 2012 Islamhome.info. All rights reserved.
//

#import "IHTileView.h"

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation IHTileView
@synthesize index, showNumnerOnTiles;
@synthesize originalPosition;
@synthesize currentPosition;
@synthesize label;

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)layoutSubviews {
    [super layoutSubviews];
    label = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 30, 30)];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:[UIColor orangeColor]];
    [label setShadowColor:[UIColor colorWithRed:60.0/255 green:60.0/255 blue:60.0/255 alpha:0.7]];
    [label setShadowOffset:CGSizeMake(0.6, 0.6)];
    [label setFont:[UIFont systemFontOfSize:18]];
    [label setText:[NSString stringWithFormat:@"%d", index]];
    label.hidden = !showNumnerOnTiles;
    [self addSubview:label];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void) dealloc
{
	if(label!= nil )
        IH_RELEASE_SAFELY(label);
	[super dealloc];
}


@end
