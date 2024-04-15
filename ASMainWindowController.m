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

- (IBAction)openDatabaseButtonClicked:(id)sender {
	NSOpenPanel *panel = [NSOpenPanel openPanel];
	[panel setCanChooseFiles:YES];
	[panel setCanChooseDirectories:NO];
	
	int result = [panel runModal];
	if (result == NSFileHandlingPanelOKButton) {
		NSArray *fileUrls = [panel URLs];
		if ([fileUrls count] > 0) {
			NSURL *selectedFile = [fileUrls objectAtIndex:0];
			filePath = [selectedFile path];
			NSLog(@"Using DB path: %@", filePath);
			
			[database open:filePath];
		}
	}
}

- (IBAction)searchButtonClicked:(id)sender {
	NSLog(@"Search button clicked.");
}
@end
