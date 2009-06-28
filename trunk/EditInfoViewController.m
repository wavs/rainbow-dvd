#import "EditInfoViewController.h"

@implementation EditInfoViewController

- (id) init
{
  self = [super init];
  if (self != nil) {
	[oView display];
  }
  return self;
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
