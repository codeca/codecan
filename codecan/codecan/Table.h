//
//  Table.h
//  codecan
//
//  Created by Felipe Fujioka on 22/10/13.
//  Copyright (c) 2013 Codeca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HexagonNode.h"
#import "VertexNode.h"
#import "EdgeNode.h"
#import "HexagonNode.h"
#import "VertexNode.h"
#import "EdgeNode.h"
#import "FileReader.h"

@interface Table : NSObject

@property (nonatomic, strong) NSMutableArray * hexes;
@property (nonatomic, strong) NSMutableArray * vertexes;
@property (nonatomic, strong) NSMutableArray * edges;
@property (nonatomic, weak) HexagonNode * thief;
@property (nonatomic, getter = hasThiefMoved) BOOL thiefHasBeenMoved;

-(void) moveThiefToHexagon: (HexagonNode*) hex;

-(id) initWithTable:(NSDictionary*) table;

@end
