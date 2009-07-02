#import "ClientController.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>
#import <unistd.h>

@interface ClientController ()

@property (readwrite, retain) NSNetServiceBrowser *browser;
@property (readwrite, retain) NSMutableArray *services;
@property (readwrite, retain) NSNetService *connectedService;

@end

@implementation ClientController

@synthesize browser;
@synthesize services;
@synthesize connectedService;

-(ClientController*) initWithDataSource:(DVDDataSource*) source 
					 withServicesList:(NSTableView*) tableView
						   withMainView:(IKImageBrowserView*) aMainView
{
	[super init];
    self.services = [NSMutableArray new];
    self.browser = [[NSNetServiceBrowser new] autorelease];
    self.browser.delegate = self;
	[self.browser searchForServicesOfType:@"_dvdlibrary._tcp." inDomain:@""];
	datasource = [source retain];
	servicesList = [tableView retain];
	mainView = [aMainView retain];
	return self;
}

-(void)dealloc
{
    self.connectedService = nil;
    self.browser = nil;
    [services release];
	[datasource release];
	[servicesList release];
	[mainView release];
    [super dealloc];
}

-(void)connect:(int)index 
{
	if (serviceBeingResolved) 
	{
        [serviceBeingResolved stop];
        [serviceBeingResolved release];
        serviceBeingResolved = nil;
    }
	
	if ((index != -1) && ([services count] >= 1)) 
	{        
        serviceBeingResolved = [services objectAtIndex:index];
        [serviceBeingResolved retain];
        [serviceBeingResolved setDelegate:self];
        [serviceBeingResolved resolve];
    }
}

// DELEGATES
-(void)netServiceBrowser:(NSNetServiceBrowser *)aBrowser didFindService:(NSNetService *)aService moreComing:(BOOL)more {
	NSLog(@"Service %@ is alive", [aService name]);	
	[services addObject:aService];
	[servicesList reloadData];
}

-(void)netServiceBrowser:(NSNetServiceBrowser *)aBrowser didRemoveService:(NSNetService *)aService moreComing:(BOOL)more {
    NSLog(@"Service %@ is dead", [aService name]);
	NSEnumerator* enumerator = [services objectEnumerator];
    NSNetService* currentNetService;
	
    while(currentNetService = [enumerator nextObject]) 
	{
        if ([currentNetService isEqual:aService])
		{
            [services removeObject:currentNetService];
            break;
        }
    }
	
    if (serviceBeingResolved && [serviceBeingResolved isEqual:aService]) {
        [serviceBeingResolved stop];
        [serviceBeingResolved release];
        serviceBeingResolved = nil;
    }
	[servicesList reloadData];
}

-(void)netServiceDidResolveAddress:(NSNetService *)sender {
	NSLog(@"Service %@ is resolved", [sender name]);
	if ([[sender addresses] count] > 0) 
	{
        NSData* address;
        struct sockaddr * socketAddress;
        NSString* ipAddressString = nil;
        NSString* portString = nil;
        int socketToRemoteServer;
        char buffer[1024];
        int index;
		
		for (index = 0; index < [[sender addresses] count]; index++) 
		{
            address = [[sender addresses] objectAtIndex:index];
            socketAddress = (struct sockaddr *)[address bytes];
			
            if (socketAddress->sa_family == AF_INET) 
				break;
        }
		
        if (socketAddress) 
		{
			switch(socketAddress->sa_family) 
			{
                case AF_INET:
                    if (inet_ntop(AF_INET, &((struct sockaddr_in *)socketAddress)->sin_addr, buffer, sizeof(buffer)))
					{
                        ipAddressString = [NSString stringWithCString:buffer];
                        portString = [NSString stringWithFormat:@"%d", ntohs(((struct sockaddr_in *)socketAddress)->sin_port)];
                    }
                    NSLog(@"ip = %@ port = %@", ipAddressString, portString);
                    [sender stop];
                    [sender release];
                    serviceBeingResolved = nil;
					break;
                case AF_INET6:
                    return;
            }
        }   
		
        socketToRemoteServer = socket(AF_INET, SOCK_STREAM, 0);
		if(socketToRemoteServer > 0) // open connexion
		{
            NSFileHandle* remoteConnection = [[NSFileHandle alloc] initWithFileDescriptor:socketToRemoteServer closeOnDealloc:YES];
            if(remoteConnection) // open stream
			{
				[[NSNotificationCenter defaultCenter] 
													addObserver:self
													selector:@selector(readAllTheData:) 
													name:NSFileHandleReadToEndOfFileCompletionNotification 
													object:remoteConnection];
				
                if(connect(socketToRemoteServer, (struct sockaddr *)socketAddress, sizeof(*socketAddress)) == 0) 
				{
                    NSLog(@"Connected to Dvd library of %@", [sender name]);
					[remoteConnection readToEndOfFileInBackgroundAndNotify];
                }
            } 
			else 
			{
                close(socketToRemoteServer);
            }
        }
    }
}

- (void)readAllTheData:(NSNotification *)note 
{
	NSData *messageData = [NSData dataWithData:[[note userInfo]
										 objectForKey:NSFileHandleNotificationDataItem]];

	NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:messageData];
	result = [[unarchiver decodeObjectForKey:@"thedata"] retain];
	NSLog(@"Recieved data = %@", result);
	[unarchiver finishDecoding];
	[unarchiver release];
	[messageData release];
	[datasource setDvds:result];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSFileHandleReadToEndOfFileCompletionNotification object:[note object]];
    [[note object] release];
	[mainView reloadData];
	
}

-(void)netService:(NSNetService *)service didNotResolve:(NSDictionary *)errorDict
{
    NSLog(@"Could not resolve: %@", errorDict);
}


-(NSString*) serviceNameForIndex:(int) index
{
	return [[services objectAtIndex:index] name];
}

- (int) servicesCount
{
	return [services count];
}
@end
