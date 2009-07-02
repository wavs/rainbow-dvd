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
#import "AmazonController.h"
#import "ClientController.h"
#import "ServerController.h"

#define kDVDTitle @"title"
#define kDVDDirector @"director"
#define kDVDGenre @"genre"
#define kDVDYear @"year"
#define kDVDSynopsis @"synopsis"
#define kDVDActors @"actors"
#define kDVDImageBrowserItem @"imageBrowserItem"
#define kSelectedDVDDidChange @"kSelectedDVDDidChange"
#define kDVDImageDidChange @"kDVDImageDidChange"
#define kNoDVDSelected @"kNoDVDSelected"
#define kDVDAddDVD @"kDVDAddDVD"
#define kMyComputer @"My Computer"
@implementation DVDBrowserController

- (void) awakeFromNib 
{
	// if Database not found
	dataSource = [[DVDDataSource alloc] init];
	[dataSource retain];
	// else
	// load it
	
	[oImageBrowser setDataSource:dataSource];
	
	
	[[self window] makeFirstResponder:nil];
	[drawer setDelegate:self];
	
	[oEditGenre removeAllItems];
	[oEditGenre addItemsWithTitles:[NSArray arrayWithObjects:@"comedy", @"romance", @"drama", nil]];
	NSMutableArray *years = [[NSMutableArray alloc] init];
	int year = 2009;
	while (year > 1900)
	{
		[years addObject:[NSString stringWithFormat:@"%d", year]];
		year = year - 1;
	}
	[oEditYear removeAllItems];
	[oEditYear addItemsWithTitles:years];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshEditPanel:) name:kSelectedDVDDidChange object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closePanel:) name:kNoDVDSelected object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshImageInBrowser:) name:kDVDImageDidChange object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addDVD:) name:kDVDAddDVD object:nil];
	
	// Network init
	serverController = [[ServerController alloc] initWithData:[dataSource dvds]];
	clientController = [[ClientController alloc] initWithDataSource:dataSource withServicesList:servicesList withMainView:oImageBrowser];
}

- (void) closePanel:(NSNotification *)notification
{
	if (editMode == NO)
	  [drawer close];
}

- (void) refreshImageInBrowser:(NSNotification *)notification
{
	[oImageBrowser reloadData];
}

- (void) refreshEditPanel:(NSNotification *)notification
{
	currentDVD = [[dataSource dvds] objectAtIndex:[self selectedDVDIndex]];
	if (editMode == NO)
	{		
		[currentDVD retain];
		[oTitle setStringValue:[currentDVD objectForKey:kDVDTitle]];
		[oDirector setStringValue:[currentDVD objectForKey:kDVDDirector]];
		//[nonEditableInfoView.oActors setStringValue:[currentDVD objectForKey:kDVDActors]];
		[oGenre setStringValue:[currentDVD objectForKey:kDVDGenre]];
		[oSynopsis setStringValue:[currentDVD objectForKey:kDVDSynopsis]];
		[oYear setStringValue:[currentDVD objectForKey:kDVDYear]];
		
		[oEditTitle setStringValue:[currentDVD objectForKey:kDVDTitle]];
		[oEditDirector setStringValue:[currentDVD objectForKey:kDVDDirector]];
		//[nonEditableInfoView.oActors setStringValue:[currentDVD objectForKey:kDVDActors]];
		[oEditGenre setStringValue:[currentDVD objectForKey:kDVDGenre]];
		[oEditSynopsis setStringValue:[currentDVD objectForKey:kDVDSynopsis]];
		[oEditYear setStringValue:[currentDVD objectForKey:kDVDYear]];
		
		[currentDVD release];
	}
	[tabView selectFirstTabViewItem:nil];
	editMode = NO;
	[drawer open];
}

- (void) updateDataSource
{
	[oImageBrowser reloadData];
}

- (IBAction) saveButtonClicked:(id)sender
{
	DVDItem *dvdItem = [currentDVD objectForKey:kDVDImageBrowserItem];
	[dvdItem retain];
	[dvdItem setImageRepresentation:[oEditPoster image]];
	[dvdItem setImageUID:[NSString stringWithFormat:@"%i", NSTimeIntervalSince1970]];
	[dvdItem setImageTitle:[oEditTitle stringValue]];
	[dvdItem setImageSubtitle:[oEditDirector stringValue]];
	[dvdItem release];
	[oEditDirector selectText:nil];
	[currentDVD setObject:[oEditTitle stringValue] forKey:kDVDTitle];
	[currentDVD setObject:[oEditDirector stringValue] forKey:kDVDDirector];
	[currentDVD setObject:[[oEditGenre selectedItem] title] forKey:kDVDGenre];
	[currentDVD setObject:[[oEditYear selectedItem] title] forKey:kDVDYear];
	[currentDVD setObject:oEditActors forKey:kDVDActors];
	[currentDVD setObject:[oEditSynopsis stringValue] forKey:kDVDSynopsis];
//	[currentDVD setObject:dvdItem forKey:kDVDImageBrowserItem];
	editMode = NO;
	[oImageBrowser reloadData];
	[self refreshEditPanel:nil];
}

- (IBAction) cancelButtonClicked:(id)sender
{
	[tabView selectFirstTabViewItem:nil];
	editMode = NO;
}

- (IBAction) editButtonClicked:(id)sender
{
	[tabView selectLastTabViewItem:nil];
	editMode = YES;
}

- (void) addDVD:(NSNotification *)notification
{
	DVDItem *dvdItem = [[DVDItem alloc] init];
	NSMutableDictionary	*dvd = [[NSMutableDictionary alloc] init];
	if (amazonControllerInstance.currentCreatedDvd == nil)
	{
		dvd = [NSMutableDictionary dictionaryWithObjectsAndKeys:
									[NSMutableString stringWithString:@""], kDVDTitle, 
									@"", kDVDDirector,
									@"", kDVDGenre,
									@"", kDVDYear,
									[NSTokenField new], kDVDActors,
									@"", kDVDSynopsis,
									dvdItem, kDVDImageBrowserItem,
									nil];
	}
	else
	{
		dvd = [NSMutableDictionary dictionaryWithDictionary:amazonControllerInstance.currentCreatedDvd];
		[dvd setObject:dvdItem forKey:kDVDImageBrowserItem];
		[dvd setObject:@"" forKey:kDVDGenre];
		[dvd setObject:@"" forKey:kDVDSynopsis];
	}
	[dataSource addNewDVD:dvd];
	[self updateDataSource];
	NSLog(@"[dataSource dvds] count : %i", [[dataSource dvds] count]);
	[oImageBrowser setSelectionIndexes:[NSIndexSet indexSetWithIndex:[[dataSource dvds] count] - 1]
				  byExtendingSelection:NO];
	currentDVD = [[dataSource dvds] objectAtIndex:[self selectedDVDIndex]];
	dvdItem = [currentDVD objectForKey:kDVDImageBrowserItem];
	[dvdItem retain];
	[dvdItem setImageTitle:[dvd objectForKey:kDVDTitle]];
	[dvdItem setImageSubtitle:[dvd objectForKey:kDVDDirector]];
	[dvdItem release];	
	[[NSNotificationCenter defaultCenter] postNotificationName:kSelectedDVDDidChange object:nil];
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

- (void) dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[amazonControllerInstance release];
	[dataSource release];
	[super dealloc];
}

- (IBAction) removeDVD:(id)sender
{
	[[dataSource dvds] removeObjectAtIndex:[self selectedDVDIndex]];
	[oImageBrowser reloadData];
}
////////////////////
// NEtwork
- (IBAction) bonjourToggle:(id)sender
{
	[oNetworkDrawer toggle:sender];
}

- (void)tableViewSelectionDidChange:(NSNotification *)aNotification
{
	
}

- (id)tableView:(NSTableView *)aTableView
objectValueForTableColumn:(NSTableColumn *)aTableColumn
			row:(int)rowIndex
{
	if (rowIndex == 0)
	{
		return kMyComputer;
	}
	else
	{
		return [clientController serviceNameForIndex:rowIndex];
	}
}

- (int)numberOfRowsInTableView:(NSTableView *)aTableView
{
	return [clientController servicesCount];
}
@synthesize oImageBrowser;
@synthesize dataSource;
@synthesize editMode;
@synthesize currentDVD;
@end
