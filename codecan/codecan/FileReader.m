//
//  FileReader.m
//  codecan
//
//  Created by Otávio Netto Zani on 23/10/13.
//  Copyright (c) 2013 Codeca. All rights reserved.
//

#import "FileReader.h"

@implementation FileReader


+(NSArray *)createTableFromFile:(NSString *)path{
	NSMutableArray* table = [[NSMutableArray alloc] init];
	
	NSArray *aux;
	
	NSString *fileContents = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
	
	
	//expanding the string fileContents to arrays
	
	//first of all, we break the file at the end of lines, then, we break at the ';'
	
	NSArray* separatedAtEOL = [fileContents componentsSeparatedByString:@"\r\n"];
	
	NSMutableArray* fullySeparated = [[NSMutableArray alloc]init];
	
	for(NSString * part in separatedAtEOL)
		[fullySeparated addObject:[part componentsSeparatedByString:@";"]];
	
	
	
	// now we process the file as described at the .h
	
	//define the keys for the dictionary
	NSMutableArray * keysForDictionary = [[NSMutableArray alloc] init];
	
	aux = fullySeparated[0];
	
	
	for(int i=1; i<aux.count; i++)
		[keysForDictionary addObject:aux[i]];
		
	
	//define the dictionary with the values and put then into the table
	NSMutableArray *valuesForKeys = [[NSMutableArray alloc] init];
	
	for(int i=1; i<separatedAtEOL.count; i++){
		aux = fullySeparated[i];
		
		for(int j=1; j<aux.count; j++){
			NSString *auxString = aux[j];
			[valuesForKeys addObject:[auxString componentsSeparatedByString:@" "]];
		}
		
		[table addObject:[[NSDictionary alloc] initWithObjects:valuesForKeys forKeys:keysForDictionary]];
		[valuesForKeys removeAllObjects];
	}
	
	
	
	return table;
}

@end
