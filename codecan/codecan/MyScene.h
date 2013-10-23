//
//  MyScene.h
//  codecan
//

//  Copyright (c) 2013 Codeca. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Table.h"
#import "HexagonNode.h"
#import "VertexNode.h"
#import "EdgeNode.h"

@interface MyScene : SKScene

@property (nonatomic, strong) SKSpriteNode * map;
@property (nonatomic, strong) Table * table;

@end
