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
  NSString *imageRepresentation;
  NSString *imageRepresentationType;
  NSString *imageUID;
  NSString *imageTitle;
  NSString *imageSubtitle;
}

@property(retain) NSString *imageRepresentation;
@property(retain) NSString *imageRepresentationType;
@property(retain) NSString *imageUID;
@property(retain) NSString *imageTitle;
@property(retain) NSString *imageSubtitle;

- (id) initWithImagePath:(NSString *)path;
- (id) initWithImagePath:(NSString *)path andTitle:(NSString *)title andDirector:(NSString *)director;

@end
