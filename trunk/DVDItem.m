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
	if (self != nil)
	{
		imageTitle = [[NSString alloc] initWithString:@"Movie"];
		imageSubtitle = [[NSString alloc] initWithString:@"Director"];
		imageRepresentationType = IKImageBrowserNSImageRepresentationType;
		// dvd.png n'existe pas, c'est normal! 
		// Hack pour que l'imageBrowser se reload tout seul comme un grand
		imageRepresentation = [[NSImage alloc] initByReferencingFile:@"dvd.png"];
		[imageRepresentation retain];
		imageUID = [[NSString alloc] initWithString:[imageRepresentation description]];
	}
	return self;
}

- (id) initWithImage:(NSImage *)image
{
  self = [super init];
  if (self != nil)
  {
	imageTitle = [[NSString alloc] initWithString:@"Movie"];
	imageSubtitle = [[NSString alloc] initWithString:@"Director"];
	imageRepresentationType = IKImageBrowserNSImageRepresentationType;
	imageRepresentation = image;
	imageUID = [imageRepresentation description];
  }
  return self;
}

- (id) initWithImage:(NSImage *)image andTitle:(NSString *)title andDirector:(NSString *)director
{
  self = [self initWithImage:image];
  imageTitle = [[NSString alloc] initWithString:title];
  imageSubtitle = [[NSString alloc] initWithString:director];
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

- (NSString *)description
{
	NSString *result;
	result = [[NSString alloc] initWithFormat:@"imageUID : %s\n imageTitle : %s\n imageSubtitle : %s\n imageRepresentation : %@\n",
			  imageUID, imageTitle, imageSubtitle, imageRepresentation];
	return result;
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


- (void) encodeWithCoder:(NSCoder*) encoder
{
	//[super encodeWithCoder:encoder];
	[encoder encodeObject:imageRepresentation forKey:@"imageRepresentation"];
	[encoder encodeObject:imageRepresentationType forKey:@"imageRepresentationType"];
	[encoder encodeObject:imageUID forKey:@"imageUID"];
	[encoder encodeObject:imageTitle forKey:@"imageTitle"];
	[encoder encodeObject:imageSubtitle forKey:@"imageSubtitle"];
}

- (id) initWithCoder:(NSCoder*) decoder
{
	self = [super init];
	imageRepresentation = [[decoder decodeObjectForKey:@"imageRepresentation"] retain];
	imageRepresentationType = [[decoder decodeObjectForKey:@"imageRepresentationType"] retain];
	imageUID = [[decoder decodeObjectForKey:@"imageUID"] retain];
	imageTitle = [[decoder decodeObjectForKey:@"imageTitle"] retain];
	imageSubtitle = [[decoder decodeObjectForKey:@"imageSubtitle"] retain];
	return self;
}
@end
