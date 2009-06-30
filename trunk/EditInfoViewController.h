#import <Cocoa/Cocoa.h>

@interface EditInfoViewController : NSObject
{
  IBOutlet NSView *oView;
  
  IBOutlet NSTokenField *oActors;
  IBOutlet NSButton *oCancel;
  IBOutlet NSTextField *oDirector;
  IBOutlet NSPopUpButton *oGenre;
  IBOutlet NSImageView *oPoster;
  IBOutlet NSButton *oSave;
  IBOutlet NSTextField *oSynopsis;
  IBOutlet NSTextField *oTitle;
  IBOutlet NSPopUpButton *oYear;
}

- (NSView *) view;

@property (retain,getter=view) NSView *oView;
@property (retain) NSTokenField *oActors;
@property (retain) NSButton *oCancel;
@property (retain) NSTextField *oDirector;
@property (retain) NSPopUpButton *oGenre;
@property (retain) NSImageView *oPoster;
@property (retain) NSButton *oSave;
@property (retain) NSTextField *oSynopsis;
@property (retain) NSTextField *oTitle;
@property (retain) NSPopUpButton *oYear;
@end
