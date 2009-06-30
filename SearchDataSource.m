#import "SearchDataSource.h"

@implementation SearchDataSource

- (id) init {
	self = [super init];
	if (self) {
		itemsForTest = [[NSMutableArray alloc] init];
		
		// Debug.
		NSLog(@"Initialization...");
		
		NSDictionary *item1 = [[NSDictionary init] alloc];
		item1 = [NSDictionary dictionaryWithObjectsAndKeys:
				 @"Star Wars", @"Title",
				 @"Georges Lucas", @"Director",
				 @"Luke Skywalker", @"Actor",
				 nil];
		
		NSDictionary *item2 = [[NSDictionary init] alloc];
		item2 = [NSDictionary dictionaryWithObjectsAndKeys:
				 @"Yesman", @"Title",
				 @"Blabla", @"Director",
				 @"Jim Carrey", @"Actor",
				 nil];
		
		// Create the array for test.
		itemsForTest = [NSMutableArray arrayWithObjects:
						item1,
						item2,
						nil];
	}
	return self;
}

- (void) dealloc {
	[itemsForTest release];
	[super dealloc];
}

-(NSMutableArray*)getItemsForTest {
	return itemsForTest;
}

-(void)setItemsForTest:(NSMutableArray*)array {
	[itemsForTest release];
	itemsForTest = [NSMutableArray alloc];
	itemsForTest = [NSMutableArray arrayWithArray:array];
}

- (NSInteger) numberOfRowsInTableView:(NSTableView *)tableView {
	return [itemsForTest count];
}

- (id) tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
	NSDictionary	*item = [itemsForTest objectAtIndex:row];
	
	if (YES == [[tableColumn identifier] isEqualToString:@"Title"]) {
		return [item objectForKey:@"Title"];
	}
	else if (YES == [[tableColumn identifier] isEqualToString:@"Director"]) {
		return [item objectForKey:@"Director"];
	}
	else if (YES == [[tableColumn identifier] isEqualToString:@"Actor"]) {
		return [item objectForKey:@"Actor"];
	}
	return nil;
}

@end
