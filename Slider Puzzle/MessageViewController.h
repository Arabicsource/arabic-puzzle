//
//  MessageViewController.h
//  Sliding Puzzle
//
//  Created by Adil Ben Moussa on 5/10/12.
//  Copyright (c) 2012 Islamhome.info. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
 
@interface MessageViewController : MFMailComposeViewController <MFMailComposeViewControllerDelegate>
{
    
}

- (void)tellFriend;

@end
