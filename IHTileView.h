//
//  IHTileView.h
//  Sliding Puzzle
//
//  Created by Adil Ben Moussa on 5/7/12 on 2/15/12.
//  Copyright (c) 2012 Islamhome.info. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IHTileView : UIImageView {
    
	CGPoint originalPosition; 
	CGPoint currentPosition; 
    int index;
    BOOL showNumnerOnTiles;
    UILabel *label;
}

@property (nonatomic,readwrite) CGPoint originalPosition;
@property (nonatomic,readwrite) CGPoint currentPosition;
@property (nonatomic,assign) int index;
@property (nonatomic,assign) BOOL showNumnerOnTiles;
@property (nonatomic, retain)UILabel *label;

@end