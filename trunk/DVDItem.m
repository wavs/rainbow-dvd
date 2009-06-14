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


- (id) initWithImagePath:(NSString *)path
{
  self = [self init];
  if (self != nil)
  {
	imageRepresentationType = IKImageBrowserPathRepresentationType;
	imageRepresentation = path;
	imageUID = imageRepresentation;
  }
  return self;
}

- (id) initWithImagePath:(NSString *)path andTitle:(NSString *)title andDirector:(NSString *)director
{
  self = [self initWithImagePath:path];
  imageTitle = title;
  imageSubtitle = director;
  return self;
}

@synthesize imageUID, imageRepresentationType, imageTitle, imageSubtitle, imageRepresentation;

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
