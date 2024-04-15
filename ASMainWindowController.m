#import "ASMainWindowController.h"

@implementation ASMainWindowController

- (id) init {
	self = [super init];
	if (self != nil) {
		NSLog(@"Window init.");
		database = [[Database alloc] init];
	}
	return self;
}


@end
