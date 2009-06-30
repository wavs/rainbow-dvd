#import "AmazonController.h"

#define kDVDAddDVD @"kDVDAddDVD"


@implementation AmazonController

- (IBAction)showAmazonSheet:(id)sender {
	
	currentTitle = [[NSMutableString alloc] initWithString:@""];
	currentDirector = [[NSMutableString alloc] initWithString:@""];
	currentYear = [[NSMutableString alloc] initWithString:@""];
	currentActors = [[NSMutableString alloc] initWithString:@""];
	
	[NSApp beginSheet:amazonSheet
			modalForWindow:mainWindow
			modalDelegate:self
			didEndSelector:NULL
			contextInfo:NULL];
}

- (IBAction)endAmazonSheet:(id)sender {
	[NSApp endSheet:amazonSheet];
	
	[amazonSheet orderOut:sender];
}

- (IBAction)createNewDvd:(id)sender {
	[NSApp endSheet:amazonSheet];
	
	[amazonSheet orderOut:sender];
}

- (IBAction)addDvdAndEndAmazonSheet:(id)sender {
	
	NSArray *keys = [NSArray arrayWithObjects:kDVDTitle, kDVDDirector, kDVDYear, kDVDActors, nil];
	NSArray *objects = [NSArray arrayWithObjects:currentTitle, currentDirector, currentYear, currentActors, nil];
	currentCreatedDvd = [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys];
	
	[NSApp endSheet:amazonSheet];
	
	for (id key in currentCreatedDvd) {
		NSLog(@"key: %@, value: %@", key, [currentCreatedDvd objectForKey:key]);
	}
	
	[amazonSheet orderOut:sender];
	[[NSNotificationCenter defaultCenter] postNotificationName:kDVDAddDVD object:nil];
}

- (IBAction)didEnd:(NSWindow *)sheet returnCode:(int)returnCode data:(NSString *)data {
	NSLog(data);
}



-(void)awakeFromNib {
	[tableView setDoubleAction:@selector(openItem:)];
	[tableView setAction:@selector(selectItem:)];
	[tableView setTarget:self];
}

-(IBAction)fetchDvds:(id)sender {
	// About the progress bar indicator.
	[progress startAnimation:nil];
	
	NSString	*input = [titleTextField stringValue];
	NSString	*searchString = [input stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	// DEBUG.
	NSLog(@"Search string: %@", searchString);
	
	// Create the URL.
	NSString	*urlString = [NSString stringWithFormat:
							  @"http://webservices.amazon.com/onca/xml?"
							  @"Service=AWSECommerceService&"
							  @"SubscriptionId=%@&"
							  @"Operation=ItemSearch&"
							  @"Keywords=%@&"
							  @"SearchIndex=DVD",
							  AWS_ID,
							  searchString];
	
	NSURL		*url = [NSURL URLWithString:urlString];
	
	// Create the request.
	NSURLRequest	*request = [NSURLRequest requestWithURL:url
											 cachePolicy:NSURLRequestReturnCacheDataElseLoad
										 timeoutInterval:30];
	
	// Fetch the XML response.
	NSData			*data;
	NSURLResponse	*response;
	NSError			*error;
	
	data = [NSURLConnection sendSynchronousRequest:request
								 returningResponse:&response
											 error:&error];
	
	// Error.
	if (!data) {
		NSAlert		*alert = [NSAlert alertWithError:error];
		[alert runModal];
		[progress stopAnimation:nil];
		[addButton setTitle:@"Create a new Dvd"];
		[addButton setAction:@selector(createNewDvd:)];
		[addButton setEnabled:YES];
		return;
	}
	
	// Parse the XML response.
	[document release];
	document = [[NSXMLDocument alloc] initWithData:data
										   options:0
											 error:&error];
	
	// DEBUG.
	NSLog(@"Document = %@", document);
	
	// Error.
	if (!document) {
		NSAlert		*alert = [NSAlert alertWithError:error];
		[alert runModal];
		[progress stopAnimation:nil];
		return;
	}
	
	// Get items.
	[itemNodes release];
	itemNodes = [[document nodesForXPath:@"ItemSearchResponse/Items/Item"
								   error:&error] retain];
	
	// Error.
	if (!itemNodes) {
		NSAlert		*alert = [NSAlert alertWithError:error];
		[alert runModal];
		[progress stopAnimation:nil];
		return;
	}
	
	// Update user interface.
	[tableView reloadData];
	[progress stopAnimation:nil];
	
	if ([itemNodes count] == 0) {
		[titleTextField setTitleWithMnemonic:@"No Dvd found."];
		[addButton setTitle:@"Create a new Dvd"];
		[addButton setAction:@selector(createNewDvd:)];
		[addButton setEnabled:YES];
	}
	else {
		[addButton setTitle:@"Add a Dvd"];
		[addButton setAction:@selector(addDvdAndEndAmazonSheet:)];
		[addButton setEnabled:YES];
	}
}

#pragma mark TableView data source methods

-(int)numberOfRowsInTableView:(NSTableView*)tv {
	return [itemNodes count];
}

-(NSString*)stringForPath:(NSString*)xp ofNode:(NSXMLNode*)n {
	NSError	*error;
	NSArray	*nodes = [n nodesForXPath:xp error:&error];
	
	// Error.
	if (!nodes) {
		NSAlert		*alert = [NSAlert alertWithError:error];
		[alert runModal];
		return nil;
	}
	
	if ([nodes count] == 0) {
		return nil;
	} else {
		return [[nodes objectAtIndex:0] stringValue];
	}
}

-(id)tableView:(NSTableView*)tv objectValueForTableColumn:(NSTableColumn*)tableColumn row:(int)row {
	NSXMLNode	*node = [itemNodes objectAtIndex:row];
	NSString	*xPath = [tableColumn identifier];
	
	return [self stringForPath:xPath ofNode:node];
}

-(void)openItem:(id)sender {
	int row = [tableView clickedRow];
	
	// Nothing clicked.
	if (row == -1) {
		return;
	}
	
	NSXMLNode	*node = [itemNodes objectAtIndex:row];
	NSString	*urlString = [self stringForPath:@"DetailPageURL" ofNode:node];
	
	NSURL		*url = [NSURL URLWithString:urlString];
	
	[[NSWorkspace sharedWorkspace] openURL:url];
}

-(void)selectItem:(id)sender {
	int row = [tableView clickedRow];
	
	// Nothing clicked.
	if (row == -1) {
		return;
	}
	
	NSXMLNode	*node = [itemNodes objectAtIndex:row];
	
	[currentTitle setString:@""];
	[currentTitle setString:@""];
	[currentTitle setString:@""];
	[currentTitle setString:@""];

	if ([self stringForPath:@"ItemAttributes/Title" ofNode:node] != nil)
		[currentTitle setString:[self stringForPath:@"ItemAttributes/Title" ofNode:node]];
	
	if ([self stringForPath:@"ItemAttributes/Director" ofNode:node] != nil)
		[currentDirector setString:[self stringForPath:@"ItemAttributes/Director" ofNode:node]];
	
	if ([self stringForPath:@"ItemAttributes/Actor" ofNode:node] != nil)
		[currentActors setString:[self stringForPath:@"ItemAttributes/Actor" ofNode:node]];
	
	if ([self stringForPath:@"ItemAttributes/ReleaseDate" ofNode:node] != nil)	
		[currentYear setString:[self stringForPath:@"ItemAttributes/ReleaseDate" ofNode:node]];
}

@synthesize currentCreatedDvd;

@end
