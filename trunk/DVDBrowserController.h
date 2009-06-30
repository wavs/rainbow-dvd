//
//  DVDBrowserController.h
//  MacDVD
//
//  Created by Alexandre Testu on 10/06/09.
//  Copyright 2009 EpiMac. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>

@class InfoViewController, EditInfoViewController, DVDDataSource, DVDBrowserView, AmazonController;

@interface DVDBrowserController : NSWindowController
{
	IBOutlet DVDBrowserView *oImageBrowser;
	IBOutlet NSTabView *tabView;
	DVDDataSource	*dataSource;
	IBOutlet NSDrawer *drawer;
	BOOL editMode;
	DVDBrowserView *imageBrowserDelegate;
	InfoViewController *nonEditableInfoView;
	EditInfoViewController *editableInfoView;
	NSMutableDictionary *currentDVD;
	
	IBOutlet AmazonController *amazonControllerInstance;
}

- (IBAction) addDVDButtonClicked:(id)sender;
- (IBAction) saveButtonClicked:(id)sender;
- (IBAction) cancelButtonClicked:(id)sender;
- (IBAction) editButtonClicked:(id)sender;

- (void) closePanel:(NSNotification *)notification;

- (int) selectedDVDIndex;

@property (retain) id oImageBrowser;
@property BOOL editMode;
@property (retain) DVDDataSource	*dataSource;
@property (retain) InfoViewController *nonEditableInfoView;
@property (retain) EditInfoViewController *editableInfoView;
@property (retain) NSMutableDictionary *currentDVD;

@end
