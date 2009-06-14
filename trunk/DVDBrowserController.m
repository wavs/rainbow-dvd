//
//  DVDBrowserController.m
//  MacDVD
//
//  Created by Alexandre Testu on 10/06/09.
//  Copyright 2009 EpiMac. All rights reserved.
//

#import "DVDBrowserController.h"
#import "DVDDataSource.h"
#import "DVDItem.h"
#import "DVDBrowserView.h"

#define kDVDTitle @"title"
#define kDVDDirector @"director"
#define kDVDGenre @"genre"
#define kDVDYear @"year"
#define kDVDSynopsis @"synopsis"
#define kDVDActors @"actors"
#define kDVDImageBrowserItem @"imageBrowserItem"
#define kSelectedDVDDidChange @"kSelectedDVDDidChange"

@implementation DVDBrowserController

- (void) awakeFromNib 
{
  dataSource = [[DVDDataSource alloc] init];
  [oImageBrowser setDataSource:dataSource];
  [self viewMode];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshEditPanel:) name:kSelectedDVDDidChange object:nil];
}

- (void) updateDataSource
{
  [oImageBrowser reloadData];
}

- (void) viewMode
{
  [oEditSave setTitle:@"Editer"];
  [oTitle setEditable:NO];
  [oTitle setBordered:NO];
  [oDirector setEditable:NO];
  [oDirector setBordered:NO];
  [oYear setEnabled:NO];
  [oGenre setEnabled:NO];
  [oImage setEnabled:NO];
  [oActors setEditable:NO];
  [oActors setBordered:NO];
  [oSynopsis setEditable:NO];
  [oSynopsis setBordered:NO];
  editable = NO;
}

- (void) editMode
{
  [oEditSave setTitle:@"Sauvegarder"];
  [oTitle setEditable:YES];
  [oTitle setBordered:YES];
  [oDirector setEditable:YES];
  [oDirector setBordered:YES];
  [oYear setEnabled:YES];
  [oGenre setEnabled:YES];
  [oImage setEnabled:YES];
  [oActors setEditable:YES];
  [oActors setBordered:YES];
  [oSynopsis setEditable:YES];
  [oSynopsis setBordered:YES];
  editable = YES;
}

- (IBAction) editSaveButtonClicked:(id)sender
{
  if (!editable)
  {
	// passer en mode édition
	[self editMode];
  }
  else
  {
	// sauvegarder
	DVDItem *dvd = [dataSource imageBrowser:oImageBrowser itemAtIndex:[dataSource numberOfItemsInImageBrowser:oImageBrowser] - 1];
	dvd.imageSubtitle = [oDirector stringValue];
	dvd.imageTitle = [oTitle stringValue];
	dvd.imageRepresentation = [[oImage image] bestRepresentationForDevice:nil];
	[[[dataSource dvds] objectAtIndex:[self selectedDVDIndex]] setObject:[oDirector stringValue] forKey:kDVDDirector];
	[[[dataSource dvds] objectAtIndex:[self selectedDVDIndex]] setObject:[oTitle stringValue] forKey:kDVDTitle];
	[[[dataSource dvds] objectAtIndex:[self selectedDVDIndex]] setObject:[oGenre stringValue] forKey:kDVDGenre];
	[[[dataSource dvds] objectAtIndex:[self selectedDVDIndex]] setObject:[oYear stringValue] forKey:kDVDYear];
	[[[dataSource dvds] objectAtIndex:[self selectedDVDIndex]] setObject:oActors forKey:kDVDActors];
	[[[dataSource dvds] objectAtIndex:[self selectedDVDIndex]] setObject:[oSynopsis stringValue] forKey:kDVDSynopsis];
	
	[self viewMode];
	[self updateDataSource];
  }
}

- (void) refreshEditPanel:(NSNotification *)notification
{
  if ([[dataSource dvds] count] != 0)
  {
	NSMutableDictionary *dvd = [[dataSource dvds] objectAtIndex:[self selectedDVDIndex]];
	NSImage *img = [[NSImage alloc] initByReferencingFile:[[dvd objectForKey:kDVDImageBrowserItem] imageRepresentation]];
	
	[oImage setImage:img];
	[oTitle setStringValue:[dvd objectForKey:kDVDTitle]];
	[oDirector setStringValue:[dvd objectForKey:kDVDDirector]];
	[oGenre setStringValue:[dvd objectForKey:kDVDGenre]];
	[oYear setStringValue:[dvd objectForKey:kDVDYear]];
	oActors = [dvd objectForKey:kDVDActors];
	[oSynopsis setStringValue:[dvd objectForKey:kDVDSynopsis]];
	
	[img release];
	[oPanel setIsVisible:YES];
  }
}

- (IBAction) addDVDButtonClicked:(id)sender 
{
  NSMutableDictionary	*dvd = [NSMutableDictionary dictionaryWithObjectsAndKeys:
						@"", kDVDTitle, 
						@"", kDVDDirector,
						@"", kDVDGenre,
						@"", kDVDYear,
						[NSTokenField new], kDVDActors,
						@"", kDVDSynopsis,
						[[DVDItem alloc] initWithImagePath:@""], kDVDImageBrowserItem,
						nil];
  [dataSource addNewDVD:dvd];
  [self editMode];
  [self updateDataSource];
  NSLog(@"%i", [[dataSource dvds] count]);
  [oImageBrowser setSelectionIndexes:[NSIndexSet indexSetWithIndex:[[dataSource dvds] count] - 1]
				byExtendingSelection:NO];
  [[NSNotificationCenter defaultCenter] postNotificationName:kSelectedDVDDidChange object:nil];
  [oPanel setIsVisible:YES];
}

- (int)selectedDVDIndex
{
  return [[oImageBrowser selectionIndexes] firstIndex];
}

- (IBAction) zoomSliderDidChange:(id)sender
{
  [oImageBrowser setZoomValue:[sender floatValue]];
  [oImageBrowser setNeedsDisplay:YES];
}


- (void) setDirectorField:(NSString *)director
{
  [oDirector setStringValue:director];
}

- (void) setTitleField:(NSString *)title
{
  [oTitle setStringValue:title];
}

- (void) setGenreField:(NSString *)genre
{
  [oGenre setStringValue:genre];
}

- (void) setYearField:(NSString *)year
{
  [oYear setStringValue:year];
}

- (void) setImage:(id)sender
{
  
}

- (void) dealloc
{ 
  [oImageBrowser release];
  [dataSource release];
  [super dealloc];
}

@end
