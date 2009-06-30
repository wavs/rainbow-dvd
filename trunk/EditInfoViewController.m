#import "EditInfoViewController.h"

@implementation EditInfoViewController

- (id) init
{
  self = [super init];
  if (self != nil) {
	[oView display];
	  oTitle = [[NSTextField alloc] init];
	  oDirector = [[NSTextField alloc] init];
	  oYear = [[NSPopUpButton alloc] init];
	  oGenre = [[NSPopUpButton alloc] init];
	  oPoster = [[NSImageView alloc] init];
	  oSynopsis = [[NSTextField	alloc] init];
	  oActors = [[NSTokenField alloc] init];
  }
  return self;
}

- (void) awakeFromNib
{
	
}

- (NSView *) view
{
  return oView;
}

- (void) dealloc
{
  [super dealloc];
}

@synthesize oView;
@synthesize oActors;
@synthesize oCancel;
@synthesize oDirector;
@synthesize oGenre;
@synthesize oPoster;
@synthesize oSave;
@synthesize oSynopsis;
@synthesize oTitle;
@synthesize oYear;
@end
