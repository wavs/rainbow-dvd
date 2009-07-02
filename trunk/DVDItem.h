//
//  DVDItem.h
//  MacDVD
//
//  Created by Alexandre Testu on 13/06/09.
//  Copyright 2009 EpiMac. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface DVDItem : NSObject <NSCoding> 
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

- (id) init;
- (id) initWithImage:(NSImage *)image;
- (id) initWithImage:(NSImage *)image andTitle:(NSString *)title andDirector:(NSString *)director;

- (void) encodeWithCoder:(NSCoder*) coder;
- (id) initWithCoder:(NSCoder*) coder;
@end
