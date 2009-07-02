
#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>
#import "DVDDataSource.h"

@interface ClientController : NSObject {
    NSNetServiceBrowser *browser;
    NSNetService *connectedService;
    NSMutableArray *services;
	NSNetService* serviceBeingResolved;
	NSMutableArray* result;
	DVDDataSource* datasource;
	
	// OUtlet
	NSTableView* servicesList;
	IKImageBrowserView *mainView;
}

@property (readonly, retain) NSMutableArray *services;

-(ClientController*) initWithDataSource:(DVDDataSource*) source 
					   withServicesList:(NSTableView*) tableView
						   withMainView:(IKImageBrowserView*) aMainView;
-(void)connect:(int)index;

-(NSString*) serviceNameForIndex:(int) index;

- (int) servicesCount;

@end
