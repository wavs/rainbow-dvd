//
//  DVDDataSource.h
//  MacDVD
//
//  Created by Alexandre Testu on 10/06/09.
//  Copyright 2009 EpiMac. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class IKImageBrowserView;

@interface DVDDataSource : NSObject
{
  NSMutableArray *dvds;
}

@property (readonly) NSMutableArray *dvds;


- (void) addNewDVD:(NSMutableDictionary *)dvd;
- (void) imageBrowser:(IKImageBrowserView *)aBrowser removeItemsAtIndexes:(NSIndexSet *)indexes;
- (NSUInteger) numberOfItemsInImageBrowser:(IKImageBrowserView *)aBrowser;
- (id /*IKImageBrowserItem*/) imageBrowser:(IKImageBrowserView *)aBrowser itemAtIndex:(NSUInteger)index;
- (void) setDvds:(NSMutableArray*) newDvds;
@end
