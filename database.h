//
//  database.h
//  aces
//
//  Created by Madison L.H. Wass on 4/15/24.
//  Copyright 2024 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <sqlite3.h>


@interface database : NSObject {
	sqlite3 *_database;
}

- (sqlite3 *)get;
- (void)open:(NSString *)filePath;
- (void)close;

@end
