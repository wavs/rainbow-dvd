//
//  DVDItem.h
//  MacDVD
//
//  Created by Alexandre Testu on 13/06/09.
//  Copyright 2009 EpiMac. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface DVDItem : NSObject
{
  NSImage *imageRepresentation;
  NSString *imageRepresentationType;
  NSString *imageUID;
  NSString *imageTitle;
  NSString *imageSubtitle;
}

@property(retain) NSImage *imageRepresentation;
@property(copy) NSString *imageRepresentationType;
@property(copy) NSString *imageUID;
@property(copy) NSString *imageTitle;
@property(copy) NSString *imageSubtitle;

- (id) initWithImage:(NSImage *)path;
- (id) initWithImage:(NSImage *)path andTitle:(NSString *)title andDirector:(NSString *)director;
- (void) setImageRepresentation:(NSImage *)image;
- (NSImage *) imageRepresentation;

@end
