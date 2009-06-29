//
//  DVDItem.m
//  MacDVD
//
//  Created by Alexandre Testu on 13/06/09.
//  Copyright 2009 EpiMac. All rights reserved.
//

#import "DVDItem.h"
#import <Quartz/Quartz.h>

@implementation DVDItem

@synthesize imageUID;
@synthesize imageRepresentation;
@synthesize imageTitle;
@synthesize imageSubtitle;
@synthesize imageRepresentationType;

- (id) init
{
  self = [super init];
  if (self != nil) {
	imageRepresentation = [NSImage imageNamed:NSImageNameIconViewTemplate];
	imageRepresentationType = IKImageBrowserNSImageRepresentationType;
	imageUID = [imageRepresentation name];
  }
  return self;
}


- (id) initWithImage:(NSImage *)image
{
  self = [self init];
  if (self != nil)
  {
	imageRepresentationType = IKImageBrowserNSImageRepresentationType;
	imageRepresentation = image;
	imageUID = [imageRepresentation description];
  }
  return self;
}

- (id) initWithImage:(NSImage *)image andTitle:(NSString *)title andDirector:(NSString *)director
{
  self = [self initWithImage:image];
  imageTitle = title;
  imageSubtitle = director;
  return self;
}

/*! 
 @method isSelectable
 @abstract Returns whether this item is selectable. 
 @discussion The receiver can implement this methods to forbid selection of this item by returning NO.
 */
- (BOOL) isSelectable
{
  return YES;
}

- (void) dealloc
{
  [imageUID release];
  [imageTitle release];
  [imageSubtitle release];
  [imageRepresentation release];
  [imageRepresentationType release];
  [super dealloc];
}


@end
