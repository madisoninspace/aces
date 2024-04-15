//
//  database.m
//  aces
//
//  Created by Madison L.H. Wass on 4/15/24.
//  Copyright 2024 __MyCompanyName__. All rights reserved.
//

#import "database.h"


@implementation Database

- (sqlite3 *)get {
	return _database;
}

- (void)close {
	sqlite3_close(_database);
}

- (void)open:(NSString *)filePath {
	if (sqlite3_open([filePath UTF8String], &_database) != SQLITE_OK) {
		NSLog(@"Failed to open database!");
	}
}

- (NSMutableArray *)query:(NSString *)typeCode {
	NSString *queryString = [NSString stringWithFormat:@"SELECT * FROM types WHERE \"Designator\" LIKE \"%@%@%@\" ORDER BY \"Designator\" ASC;", @"%%", typeCode, @"%%"];
	
	sqlite3_stmt *statement;
	if (_database != NULL && sqlite3_prepare(_database, [queryString UTF8String], -1, &statement, NULL) != SQLITE_OK) {
		NSLog(@"Failed to prepare statement: %s", sqlite3_errmsg(_database));
		
		NSAlert *alert = [[NSAlert alloc] init];
		[alert setMessageText:@"Error"];
		[alert setInformativeText:@"Could not read from the database file."];
		[alert addButtonWithTitle:@"OK"];
		
		[alert runModal];
	}
	
	NSMutableArray *results = [NSMutableArray array];
	while (sqlite3_step(statement) == SQLITE_ROW) {
		NSMutableDictionary *row = [NSMutableDictionary dictionary];
		int columnCount = sqlite3_column_count(statement);
		
		for (int i = 0; i < columnCount; i++) {
			const char *colName = sqlite3_column_name(statement, i);
			const unsigned char *colValue = sqlite3_column_text(statement, i);
			
			if (colName && colValue) {
				NSString *colNameString = [NSString stringWithUTF8String:colName];
				NSString *colValueString = [NSString stringWithUTF8String:colValue];
				[row setObject:colValueString forKey:colNameString];
			}
		}
		
		[results addObject:row];
	}
	
	sqlite3_finalize(statement);
	return results;
}

@end
