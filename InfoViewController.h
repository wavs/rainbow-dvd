#import <Cocoa/Cocoa.h>

@interface InfoViewController : NSObject
{
  IBOutlet NSView *oView;
  
  IBOutlet NSTokenField *oActors;
  IBOutlet NSTextField *oDirector;
  IBOutlet NSTextField *oGenre;
  IBOutlet NSTextField *oTitle;
  IBOutlet NSTextField *oSynopsis;
  IBOutlet NSTextField *oYear;
  IBOutlet NSButton *oEdit;
}

- (NSView *) view;

@property (retain,getter=view) NSView *oView;
@property (retain) NSTokenField *oActors;
@property (retain) NSTextField *oDirector;
@property (retain) NSTextField *oGenre;
@property (retain) NSTextField *oTitle;
@property (retain) NSTextField *oSynopsis;
@property (retain) NSTextField *oYear;
@property (retain) NSButton *oEdit;
@end
