#import <Cocoa/Cocoa.h>

@interface SearchDataSource : NSObject {
	
	NSMutableArray	*itemsForTest;
	
}

-(NSMutableArray*)getItemsForTest;
-(void)setItemsForTest:(NSMutableArray*)array;


@end
