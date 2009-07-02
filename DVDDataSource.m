//
//  EMDataSource.m
//  MacDVD
//
//  Created by Alexandre Testu on 10/06/09.
//  Copyright 2009 EpiMac. All rights reserved.
//

#import "DVDDataSource.h"
#import <Quartz/Quartz.h>
#import "DVDItem.h"

#define	kDVDTitle @"title"
#define kDVDDirector @"director"
#define kDVDGenre @"genre"
#define kDVDYear @"year"
#define kDVDSynopsis @"synopsis"
#define kDVDActors @"actors"
#define kDVDImageBrowserItem @"imageBrowserItem"

@implementation DVDDataSource

@synthesize dvds;

- (id) init
{
  self = [super init];
  if (self != nil) {
	dvds = [[NSMutableArray alloc] init];
  }
  return self;
}


/*! 
 @method numberOfItemsInImageBrowser:
 @abstract Returns the number of records managed for aBrowser by the data source object (required).
 @discussion An instance of IKImageView uses this method to determine how many cells it should create and display. 
 */
- (NSUInteger) numberOfItemsInImageBrowser:(IKImageBrowserView *)aBrowser
{
  return [dvds count];
}

/*! 
 @method imageBrowser:itemAtIndex:
 @abstract Returns an object for the record in aBrowser corresponding to index <i>index</i> (required).
 @discussion The returned object must implement the required methods of <i>IKImageBrowserCell</i>. 
 */
- (id /*IKImageBrowserItem*/) imageBrowser:(IKImageBrowserView *)aBrowser itemAtIndex:(NSUInteger)index
{
	NSLog(@"%@", [[dvds objectAtIndex:index] objectForKey:kDVDImageBrowserItem]);
	return [[dvds objectAtIndex:index] objectForKey:kDVDImageBrowserItem];
}

//-- optional methods
/*! 
 @method imageBrowser:removeItemsAtIndexes:
 @abstract Invoked by the image browser after it has been determined that a remove operation should be applied (optional)
 @discussion The data source should update itself (usually by removing this indexes).  
 */
- (void) imageBrowser:(IKImageBrowserView *) aBrowser removeItemsAtIndexes:(NSIndexSet *) indexes
{
  for (int i = [indexes firstIndex]; i < [indexes lastIndex]; i++)
	[dvds removeObjectAtIndex:i];
}

- (void) addNewDVD:(NSMutableDictionary *)dvd
{
  [dvd retain];
  [dvds addObject:dvd];
}

- (void) dealloc 
{ 
  NSUInteger i, count = [dvds count];
  for (i = 0; i < count; i++) {
	  NSDictionary * obj = [dvds objectAtIndex:i];
	  [[obj objectForKey:kDVDImageBrowserItem] release];
	  [obj release];
  } 
  [super dealloc]; 
} 

- (void) setDvds:(NSMutableArray*) newDvds
{
	[newDvds retain];
	[dvds release];
	dvds = newDvds;
}
@end
