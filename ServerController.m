//
//  ServerControler.m
//  Bonjour
//
//  Created by Charles Vu on 6/13/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ServerController.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>
#import <unistd.h>

@implementation ServerController

-(ServerController*) initWithData:(NSMutableArray*) dataSource {    
    [super init];
	
	data = dataSource;
	[self startService];
	return self;
}

-(void)startService {
    
	uint16_t chosenPort;
    if(!listeningSocket) 
	{
		int fdForListening;
        struct sockaddr_in serverAddress;
        int namelen = sizeof(serverAddress);
		
        if((fdForListening = socket(AF_INET, SOCK_STREAM, 0)) > 0) {
            memset(&serverAddress, 0, sizeof(serverAddress));
            serverAddress.sin_family = AF_INET;
            serverAddress.sin_addr.s_addr = htonl(INADDR_ANY);
            serverAddress.sin_port = 0;
	
            // Allow the kernel to choose a random port number by passing in 0 for the port.
            if (bind(fdForListening, (struct sockaddr *)&serverAddress, namelen) < 0) 
			{
				NSLog(@"not binded");
                close (fdForListening);
                return;
            }
			NSLog(@"Server binded");
            // Find out what port number was chosen.
            if (getsockname(fdForListening, (struct sockaddr *)&serverAddress, &namelen) < 0) 
			{
				
                close(fdForListening);
                return;
            }
			NSLog(@"sock");
            chosenPort = ntohs(serverAddress.sin_port);
			NSLog(@"Port = %i fd = %i", chosenPort, fdForListening);
            // Once we're here, we know bind must have returned, so we can start the listen
			netService = [[NSNetService alloc] initWithDomain:@"" type:@"_dvdlibrary._tcp." 
														 name:@"" port:chosenPort];
			netService.delegate = self;
			
			
			if(listen(fdForListening, 1) == 0) 
			{
                listeningSocket = [[NSFileHandle alloc] 
										initWithFileDescriptor:fdForListening 
										closeOnDealloc:YES];
            }
        }
    }
	
    if (netService && listeningSocket) 
	{
		[[NSNotificationCenter defaultCenter] 
				addObserver:self 
				selector:@selector(connectionReceived:) 
			    name:NSFileHandleConnectionAcceptedNotification 
			    object:listeningSocket];
			
		[listeningSocket acceptConnectionInBackgroundAndNotify];
		[netService publish];
    }
	
}

-(void)stopService {
    [netService stop];
    [netService release]; 
    netService = nil;
}

-(void)dealloc {
    [self stopService];
    [super dealloc];
}

-(void)netService:(NSNetService *)aNetService didNotPublish:(NSDictionary *)dict {
    NSLog(@"Failed to publish: %@", dict);
}

- (void)connectionReceived:(NSNotification *)aNotification 
{
	NSLog(@"Connetion etablished");
    NSFileHandle * incomingConnection = [[aNotification userInfo] objectForKey:NSFileHandleNotificationFileHandleItem];
	
	NSMutableData *resdata = [[NSMutableData alloc] init];
	NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:resdata];
	
	[archiver encodeObject:data forKey:@"thedata"];
	[archiver finishEncoding];
	[archiver release];
	
    [[aNotification object] acceptConnectionInBackgroundAndNotify];
    [incomingConnection writeData:resdata];
    [incomingConnection closeFile];
	[resdata release];
}

@end
