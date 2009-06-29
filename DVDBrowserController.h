//
//  DVDBrowserController.h
//  MacDVD
//
//  Created by Alexandre Testu on 10/06/09.
//  Copyright 2009 EpiMac. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>

@class InfoViewController, EditInfoViewController;

@class DVDDataSource, DVDEditController, DVDBrowserView;

@interface DVDBrowserController : NSWindowController
{
	IBOutlet id oImageBrowser;
	DVDDataSource	*dataSource;
	BOOL editable;
	IBOutlet NSView *infoView;
	IBOutlet NSDrawer *drawer;
	
	InfoViewController *nonEditableInfoView;
	EditInfoViewController *editableInfoView;
}

- (IBAction) addDVDButtonClicked:(id)sender;
- (IBAction) saveChanges:(id)sender;
- (IBAction) cancelChanges:(id)sender;
- (IBAction) edit:(id)sender;

- (int) selectedDVDIndex;

- (void) viewMode;
- (void) editMode;

@property (retain) id oImageBrowser;
@property (retain) DVDDataSource	*dataSource;
@property BOOL editable;
@property (retain) NSView *infoView;
@property (retain) InfoViewController *nonEditableInfoView;
@property (retain) EditInfoViewController *editableInfoView;

@end
