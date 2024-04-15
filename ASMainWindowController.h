/* ASMainWindowController */

#import <Cocoa/Cocoa.h>
#import "database.h"

@interface ASMainWindowController : NSWindowController
{
	Database *database;
	
	NSMutableArray *results;
	NSString *filePath;
	
	IBOutlet NSButton *openDatabaseButton;
	IBOutlet NSButton *searchButton;
	IBOutlet NSTextField *searchBox;
	IBOutlet NSTextView *resultBox;
}

- (IBAction)openDatabaseButtonClicked:(id)sender;
- (IBAction)searchButtonClicked:(id)sender;
@end
