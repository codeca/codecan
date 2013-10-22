//
//  Table.h
//  codecan
//
//  Created by Felipe Fujioka on 22/10/13.
//  Copyright (c) 2013 Codeca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HexModel.h"

@interface Table : NSObject

@property (nonatomic, strong) NSMutableArray * hexes;
@property (nonatomic, strong) NSMutableArray * vertex;
@property (nonatomic, strong) NSMutableArray * edges;

@end
