//
//  FileReader.h
//  codecan
//
//  Created by Otávio Netto Zani on 23/10/13.
//  Copyright (c) 2013 Codeca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileReader : NSObject


//the file we will read has the format 'headers' 'values'
//the headers have the name of each list of values, the first name will not be used, the others will be the key at the dictionary
//the values string has the format "index; list of values 1; list of values 2 ;..."
//the method will return an array where at the index we will have a dictionary of arrays of the values at the lists
+(NSArray *)createTableFromFile: (NSString *) path;

@end
