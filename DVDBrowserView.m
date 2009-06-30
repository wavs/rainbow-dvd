//
//  DVDBrowserView.m
//  MacDVD
//
//  Created by Alexandre Testu on 10/06/09.
//  Copyright 2009 EpiMac. All rights reserved.
//

#import "DVDBrowserView.h"

#define kSelectedDVDDidChange @"kSelectedDVDDidChange"
#define kNoDVDSelected @"kNoDVDSelected"

@implementation DVDBrowserView

- (void) awakeFromNib
{
}

- (void) mouseDown:(NSEvent *)event
{
  [super mouseDown:event];
  if ([self indexOfItemAtPoint:[event locationInWindow]] != NSNotFound)
	[[NSNotificationCenter defaultCenter] postNotificationName:kSelectedDVDDidChange object:nil];
  else
	[[NSNotificationCenter defaultCenter] postNotificationName:kNoDVDSelected object:nil];
}

- (void) dealloc
{
  [super dealloc];
}


@end
