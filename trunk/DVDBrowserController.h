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
	NSMutableDictionary *currentDVD;
	
	IBOutlet NSTokenField *oEditActors;
	IBOutlet NSButton *oEditCancel;
	IBOutlet NSTextField *oEditDirector;
	IBOutlet NSPopUpButton *oEditGenre;
	IBOutlet NSImageView *oEditPoster;
	IBOutlet NSButton *oEditSave;
	IBOutlet NSTextField *oEditSynopsis;
	IBOutlet NSTextField *oEditTitle;
	IBOutlet NSPopUpButton *oEditYear;

	IBOutlet NSTokenField *oActors;
	IBOutlet NSTextField *oDirector;
	IBOutlet NSTextField *oGenre;
	IBOutlet NSTextField *oTitle;
	IBOutlet NSTextField *oSynopsis;
	IBOutlet NSTextField *oYear;
	IBOutlet NSButton *oEdit;

	IBOutlet AmazonController *amazonControllerInstance;
}

- (IBAction) saveButtonClicked:(id)sender;
- (IBAction) cancelButtonClicked:(id)sender;
- (IBAction) editButtonClicked:(id)sender;
- (IBAction) zoomSliderDidChange:(id)sender;

- (void) closePanel:(NSNotification *)notification;
- (void) addDVD:(NSNotification *)notification;

- (int) selectedDVDIndex;

@property (retain) id oImageBrowser;
@property BOOL editMode;
@property (retain) DVDDataSource	*dataSource;
@property (retain) NSMutableDictionary *currentDVD;

@end
