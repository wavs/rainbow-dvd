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

  [nonEditableInfoView init];
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshEditPanel:) name:kSelectedDVDDidChange object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closePanel:) name:kNoDVDSelected object:nil];
//  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshImageInBrowser:) name:kDVDImageDidChange object:nil];
}



- (void) updateDataSource
{
  [oImageBrowser reloadData];
}

- (void) viewMode
{
  editable = NO;
}

- (void) editMode
{
  editable = YES;
}

// switch from view to edit
- (void) switchMode:(NSNotification *)notification
{
}

- (void) refreshEditPanel
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
  [self editMode];
  [self updateDataSource];
  [oImageBrowser setSelectionIndexes:[NSIndexSet indexSetWithIndex:[[dataSource dvds] count] - 1]
				byExtendingSelection:NO];
  [[NSNotificationCenter defaultCenter] postNotificationName:kSelectedDVDDidChange object:nil];
}

- (int)selectedDVDIndex
{
  return [[oImageBrowser selectionIndexes] firstIndex];
}

- (void) dealloc
{ 
  [oImageBrowser release];
  [dataSource release];
  [super dealloc];
}

@end
