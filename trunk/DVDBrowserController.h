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
  
  InfoViewController *nonEditableInfoView;
  EditInfoViewController *editableInfoView;
}

- (IBAction) addDVDButtonClicked:(id)sender;

- (int) selectedDVDIndex;

- (void) refreshEditPanel;

- (void) viewMode;
- (void) editMode;

@end
