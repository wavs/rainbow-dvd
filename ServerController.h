//
//  ServerControler.h
//  Bonjour
//
//  Created by Charles Vu on 6/13/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface ServerController : NSObject {
	NSNetService *netService;
	NSFileHandle *listeningSocket;
	NSMutableArray *data;
}

-(ServerController*) initWithData:(NSMutableArray*) dataSource;

-(IBAction) stopService;

-(void) startService;

@end
