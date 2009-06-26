#import <Cocoa/Cocoa.h>

@interface InfoViewController : NSObject
{
  IBOutlet NSView *oView;
  
  IBOutlet NSTokenField *oActors;
  IBOutlet NSTextField *oDirector;
  IBOutlet NSTextField *oGenre;
  IBOutlet NSTextField *oTitle;
  IBOutlet NSTextView *oSynopsis;
  IBOutlet NSTextField *oYear;
  IBOutlet NSButton *oEdit;
}

- (NSView *) view;

@end
