//
//  IHImageCustomCell.h
//  Sliding Puzzle
//
//  Created by Adil Ben Moussa on 5/8/12.
//  Copyright (c) 2012 Islamhome.info. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IHImageCustomCell : UITableViewCell{
    UILabel *primaryLabel;
    UILabel *secondaryLabel;
    UIImageView *myImageView;
}

@property(nonatomic,retain)UILabel *primaryLabel;
@property(nonatomic,retain)UILabel *secondaryLabel;
@property(nonatomic,retain)UIImageView *myImageView;

@end
