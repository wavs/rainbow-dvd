#import "InfoViewController.h"

@implementation InfoViewController

- (id) init
{
  self = [super init];
  if (self != nil) {
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
@synthesize oDirector;
@synthesize oGenre;
@synthesize oTitle;
@synthesize oSynopsis;
@synthesize oYear;
@synthesize oEdit;
@end
