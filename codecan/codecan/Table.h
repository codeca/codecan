//
//  Table.h
//  codecan
//
//  Created by Felipe Fujioka on 22/10/13.
//  Copyright (c) 2013 Codeca. All rights reserved.
//

#import <Foundation/Foundation.h>
<<<<<<< HEAD
#import "HexModel.h"
#import "VertexNode.h"
#import "EdgeNode.h"
=======
#import "HexagonNode.h"
#import "VertexNode.h"
#import "EdgeNode.h"
#import "FileReader.h"
>>>>>>> a805980b3f53b8c339660e71a8b3fe55034565b3

@interface Table : NSObject

@property (nonatomic, strong) NSMutableArray * hexes;
@property (nonatomic, strong) NSMutableArray * vertexes;
@property (nonatomic, strong) NSMutableArray * edges;

@end
