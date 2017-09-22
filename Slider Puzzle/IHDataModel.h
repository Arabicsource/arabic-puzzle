//
//  IHDataModel.h
//  Sliding Puzzle
//
//  Created by Adil Ben Moussa on 5/7/12.
//  Copyright (c) 2012 Islamhome.info. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IHDataModel : NSObject{
    
    NSString *currentImage;
    NSMutableArray *images;
    NSMutableDictionary *settings;
    NSNumber *pieciesMode;
    BOOL showNumnerOnTiles;
}

@property (nonatomic, retain) NSString *currentImage;
@property (nonatomic, retain) NSMutableArray *images;
@property (nonatomic, retain) NSNumber *pieciesMode;
@property (nonatomic, retain) NSMutableDictionary *settings;
@property (nonatomic, assign) BOOL showNumnerOnTiles;


+(IHDataModel *)model;
+(id)alloc;
+(id)copy;
+(void)initialize;
-(id)init;


- (void)readSettings;
- (void)updateSettings;
- (void)goForwards;
- (void)goBackwards;

@end
