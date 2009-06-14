//
//  DVDBrowserController.h
//  MacDVD
//
//  Created by Alexandre Testu on 10/06/09.
//  Copyright 2009 EpiMac. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>

@class DVDDataSource, DVDEditController, DVDBrowserView;

@interface DVDBrowserController : NSWindowController
{
  // Main Window
  IBOutlet DVDBrowserView *oImageBrowser;
  DVDDataSource	*dataSource;
  IBOutlet NSSlider	*oSlider;
  
  // Edit Panel
  IBOutlet NSPanel *oPanel;
  // Edit Panel Controls
  IBOutlet NSImageView *oImage;
  IBOutlet NSTextField *oDirector;
  IBOutlet NSPopUpButton *oGenre;
  IBOutlet NSTextField *oTitle;
  IBOutlet NSPopUpButton *oYear;
  IBOutlet NSTextField *oSynopsis;
  IBOutlet NSTokenField *oActors;
  IBOutlet NSButton *oEditSave;
  
  BOOL editable;
}

- (IBAction) addDVDButtonClicked:(id)sender;
- (IBAction) zoomSliderDidChange:(id)sender;
- (IBAction) editSaveButtonClicked:(id)sender;

- (void) setImage:(id)sender;

- (void) setDirectorField:(NSString *)director;
- (void) setTitleField:(NSString *)title;
- (void) setGenreField:(NSString *)genre;
- (void) setYearField:(NSString *)year;

- (int) selectedDVDIndex;

- (void) refreshEditPanel:(NSNotification *)notification;

- (void) viewMode;
- (void) editMode;

@end
