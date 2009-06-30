#import "InfoViewController.h"

@implementation InfoViewController

- (id) init
{
  self = [super init];
	if (self != nil) {
		oTitle = [[NSTextField alloc] init];
		oDirector = [[NSTextField alloc] init];
		oYear = [[NSPopUpButton alloc] init];
		oGenre = [[NSPopUpButton alloc] init];
		oSynopsis = [[NSTextField	alloc] init];
		oActors = [[NSTokenField alloc] init];
  }
  return self;
}

- (void) awakeFromNib
{
	[[self view] display]; 
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
@synthesize oDirector;
@synthesize oGenre;
@synthesize oTitle;
@synthesize oSynopsis;
@synthesize oYear;
@synthesize oEdit;
@end
