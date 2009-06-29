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
	[oImageBrowser setDataSource:dataSource];
	
	nonEditableInfoView = [[InfoViewController alloc] init];
	editableInfoView = [[EditInfoViewController alloc] init];
	[drawer setDelegate:self];
	
	//[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshEditPanel:) name:kSelectedDVDDidChange object:nil];
	NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
	[nc addObserver:self selector:@selector(closePanel:) name:kNoDVDSelected object:nil];
	//  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshImageInBrowser:) name:kDVDImageDidChange object:nil];
}

- (void) closePanel:(NSNotification *)notification
{
	NSLog(@"test");
	[drawer close];
}

- (void) updateDataSource
{
	[oImageBrowser reloadData];
}

- (IBAction) saveChanges:(id)sender
{
	
}

- (IBAction) cancelChanges:(id)sender
{
}

- (IBAction) edit:(id)sender
{
}

- (void) viewMode
{
	[drawer setContentView:nonEditableInfoView.view];
	editable = NO;
}

- (void) editMode
{
	[drawer setContentView:editableInfoView.view];
	editable = YES;
}

// switch from view to edit
- (void) switchMode:(NSNotification *)notification
{
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
								[[DVDItem alloc] init], kDVDImageBrowserItem,
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
	NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
	[nc removeObserver:self];
	[editableInfoView release];
	[nonEditableInfoView release];
	[dataSource release];
	[super dealloc];
}

@synthesize oImageBrowser;
@synthesize dataSource;
@synthesize editable;
@synthesize infoView;
@synthesize nonEditableInfoView;
@synthesize editableInfoView;
@end
