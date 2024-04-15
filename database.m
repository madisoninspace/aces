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

- (void)open:(NSString *)filePath {
	if (sqlite3_open([filePath UTF8String], &_database) != SQLITE_OK) {
		NSLog(@"Failed to open database!");
	}
}

- (void)close {
	sqlite3_close(_database);
}

@end
