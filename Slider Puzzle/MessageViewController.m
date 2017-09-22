//
//  MessageViewController.m
//  Sliding Puzzle
//
//  Created by Adil Ben Moussa on 5/10/12.
//  Copyright (c) 2012 Islamhome.info. All rights reserved.
//

#import "MessageViewController.h"

@implementation MessageViewController

- (id)init
{
	if (self = [super init])
	{
		self.mailComposeDelegate = self;
        [self tellFriend];
	}
	return self;
}

- (void)tellFriend
{
	[self setSubject:IH_STRING(@"Tell a friend")];
	[self setMessageBody:[NSString stringWithFormat:IH_STRING(@"Tell a friend message"),kAppUrl, kAppUrl] isHTML:YES];
}

- (void)dealloc
{
	self.mailComposeDelegate = nil;
	[super dealloc];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
	
	[self becomeFirstResponder];
	[self dismissModalViewControllerAnimated:YES];	
}

@end
