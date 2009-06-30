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
#import "EditInfoViewController.h"
#import "InfoViewController.h"

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

@implementation DVDBrowserController

- (void) awakeFromNib 
{
	dataSource = [[DVDDataSource alloc] init];
	[dataSource retain];
	[oImageBrowser setDataSource:dataSource];
	
	nonEditableInfoView = [[InfoViewController alloc] init];
	[nonEditableInfoView retain];
	editableInfoView = [[EditInfoViewController alloc] init];
	[editableInfoView retain];
	[[self window] makeFirstResponder:nil];
	[drawer setDelegate:self];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshEditPanel:) name:kSelectedDVDDidChange object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closePanel:) name:kNoDVDSelected object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshImageInBrowser:) name:kDVDImageDidChange object:nil];
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
	[drawer open];
	if (editMode == NO)
	{
		;
	}
}

- (void) updateDataSource
{
	[oImageBrowser reloadData];
}

- (IBAction) saveButtonClicked:(id)sender
{
//	DVDItem *dvdItem = [[DVDItem alloc] initWithImage:[[editableInfoView oPoster] image]];
	[currentDVD setObject:[editableInfoView.oTitle stringValue] forKey:kDVDTitle];
	NSLog(@"[editableInfoView.oDirector stringValue] : %s", [editableInfoView.oDirector stringValue]);
	[currentDVD setObject:[editableInfoView.oDirector stringValue] forKey:kDVDDirector];
	[currentDVD setObject:[editableInfoView.oGenre stringValue] forKey:kDVDGenre];
	[currentDVD setObject:[editableInfoView.oYear stringValue] forKey:kDVDYear];
	[currentDVD setObject:editableInfoView.oActors forKey:kDVDActors];
	[currentDVD setObject:[editableInfoView.oSynopsis stringValue] forKey:kDVDSynopsis];
//	[currentDVD setObject:dvdItem forKey:kDVDImageBrowserItem];
	[oImageBrowser reloadData];
	[currentDVD release];
	[self cancelButtonClicked:nil];
}

- (IBAction) cancelButtonClicked:(id)sender
{
	currentDVD = [[dataSource dvds] objectAtIndex:[self selectedDVDIndex]];
	[currentDVD retain];
	[nonEditableInfoView.oTitle setStringValue:[currentDVD objectForKey:kDVDTitle]];
	NSLog(@"%s", [currentDVD objectForKey:kDVDTitle]); //[nonEditableInfoView.oTitle stringValue]);
	[nonEditableInfoView.oDirector setStringValue:[currentDVD objectForKey:kDVDDirector]];
	//[nonEditableInfoView.oActors setStringValue:[currentDVD objectForKey:kDVDActors]];
	[nonEditableInfoView.oGenre setStringValue:[currentDVD objectForKey:kDVDGenre]];
	[nonEditableInfoView.oSynopsis setStringValue:[currentDVD objectForKey:kDVDSynopsis]];
	[nonEditableInfoView.oYear setStringValue:[currentDVD objectForKey:kDVDYear]];
	[currentDVD release];
	[tabView selectFirstTabViewItem:nil];
	editMode = NO;
}

- (IBAction) editButtonClicked:(id)sender
{
	[tabView selectLastTabViewItem:nil];
	editMode = YES;
	currentDVD = [[dataSource dvds] objectAtIndex:[self selectedDVDIndex]];
	[currentDVD retain];
}

- (IBAction) addDVDButtonClicked:(id)sender
{
	DVDItem *dvdItem = [[DVDItem alloc] init];
	NSMutableDictionary	*dvd = [NSMutableDictionary dictionaryWithObjectsAndKeys:
								[NSMutableString stringWithString:@""], kDVDTitle, 
								@"", kDVDDirector,
								@"", kDVDGenre,
								@"", kDVDYear,
								[NSTokenField new], kDVDActors,
								@"", kDVDSynopsis,
								dvdItem, kDVDImageBrowserItem,
								nil];
	[dataSource addNewDVD:dvd];
	[self updateDataSource];
	NSLog(@"[dataSource dvds] count : %i", [[dataSource dvds] count]);
	[oImageBrowser setSelectionIndexes:[NSIndexSet indexSetWithIndex:[[dataSource dvds] count] - 1]
				  byExtendingSelection:NO];
	//[[NSNotificationCenter defaultCenter] postNotificationName:kSelectedDVDDidChange object:nil];
	[drawer open];
}

- (int)selectedDVDIndex
{
	return [[oImageBrowser selectionIndexes] firstIndex];
}

- (void) dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[editableInfoView release];
	[nonEditableInfoView release];
	[dataSource release];
	[super dealloc];
}

@synthesize oImageBrowser;
@synthesize dataSource;
@synthesize nonEditableInfoView;
@synthesize editableInfoView;
@synthesize editMode;
@synthesize currentDVD;
@end
