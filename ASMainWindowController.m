#import "ASMainWindowController.h"

@implementation ASMainWindowController

- (id) init {
	self = [super init];
	if (self != nil) {
		NSLog(@"Window init.");
		results = [NSMutableArray array];
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
			
			[database open:filePath];
		}
	}
}

- (IBAction)searchButtonClicked:(id)sender {
	[resultBox setString:@""];

	NSString *resultText = @"";
	NSString *queryType = [searchBox stringValue];
	NSLog(queryType);
	
	results = [database query:queryType];
	
	if ([results count] > 0) {
		int count = [results count];
		
		for (int i = 0; i < count; i++) {
			NSDictionary *dic = [results objectAtIndex:i];
			NSString *designator = (NSString *)[dic objectForKey:@"Designator"];
			NSString *manufacturer = (NSString *)[dic objectForKey:@"ManufacturerCode"];
			NSString *model = (NSString *)[dic objectForKey:@"ModelFullName"];
			NSString *engines = (NSString *)[dic objectForKey:@"EngineCount"];
			
			resultText = [NSString stringWithFormat:@"%@\n\n%@\t%@ %@\n\t\tEngines: %@", resultText, 
																						designator, 
																						manufacturer, 
																						model, 
																						engines];
		}
		
		NSFont *font = [NSFont fontWithName:@"Monaco" size:12.0];
		[resultBox setString:[resultText substringFromIndex:1]];
		[resultBox setFont:font];
	}
}
@end
