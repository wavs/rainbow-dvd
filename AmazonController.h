#import <Cocoa/Cocoa.h>

#define AWS_ID @"AKIAJFE33EMO36VN6E6A"

#define kDVDTitle @"title"
#define kDVDDirector @"director"
#define kDVDYear @"year"
#define kDVDActors @"actors"

@interface AmazonController : NSObject {
	
	IBOutlet NSWindow				*mainWindow;
	IBOutlet NSWindow				*amazonSheet;
	IBOutlet NSProgressIndicator	*progress;
    IBOutlet NSTableView			*tableView;
	IBOutlet NSTextField			*titleTextField;
	IBOutlet NSButton				*addButton;
	
	NSXMLDocument					*document;
	NSArray							*itemNodes;
	NSMutableDictionary				*currentCreatedDvd;
	NSMutableString					*currentTitle;
	NSMutableString					*currentDirector;
	NSMutableString					*currentYear;
	NSMutableString					*currentActors;
	
}

- (IBAction)showAmazonSheet:(id)sender;
- (IBAction)endAmazonSheet:(id)sender;
- (IBAction)AddDvdAndEndAmazonSheet:(id)sender;
- (IBAction)didEnd:(NSWindow *)sheet returnCode:(int)returnCode data:(NSString *)data;
- (IBAction)fetchDvds:(id)sender;

@end
