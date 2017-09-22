//
//  IHImageCustomCell.m
//  Sliding Puzzle
//
//  Created by Adil Ben Moussa on 5/8/12.
//  Copyright (c) 2012 Islamhome.info. All rights reserved.
//

#import "IHImageCustomCell.h"

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation IHImageCustomCell
@synthesize primaryLabel,secondaryLabel,myImageView;


///////////////////////////////////////////////////////////////////////////////////////////////////
-(void)dealloc
{
    if (primaryLabel != nil) 
        IH_RELEASE_SAFELY(primaryLabel);
    if (secondaryLabel != nil)    
        IH_RELEASE_SAFELY(secondaryLabel);
    if (myImageView != nil)
        IH_RELEASE_SAFELY(myImageView);
	[super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        primaryLabel = [[UILabel alloc]init];
        primaryLabel.textAlignment = UITextAlignmentLeft;
        primaryLabel.font = [UIFont systemFontOfSize:22];
        secondaryLabel = [[UILabel alloc]init];
        secondaryLabel.textAlignment = UITextAlignmentLeft;
        secondaryLabel.font = [UIFont systemFontOfSize:12];
        myImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:primaryLabel];
        [self.contentView addSubview:secondaryLabel];
        [self.contentView addSubview:myImageView];
    }
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect contentRect = self.contentView.bounds;
    CGFloat boundsX = contentRect.origin.x;
    CGRect frame;
    frame= CGRectMake(boundsX+10 ,0, 100, 100);
    myImageView.frame = frame;
    
    frame= CGRectMake(boundsX+120 ,5, 200, 25);
    primaryLabel.frame = frame;
    
    frame= CGRectMake(boundsX+120 ,30, 100, 15);
    secondaryLabel.frame = frame;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
