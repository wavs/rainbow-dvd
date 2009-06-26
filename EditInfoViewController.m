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

@end
