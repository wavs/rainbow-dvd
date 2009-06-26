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
  IBOutlet NSTextView *oSynopsis;
  IBOutlet NSTextField *oTitle;
  IBOutlet NSPopUpButton *oYear;
}

- (NSView *) view;

@end
