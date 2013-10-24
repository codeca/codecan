//
//  HexModel.h
//  codecan
//
//  Created by Felipe Fujioka on 22/10/13.
//  Copyright (c) 2013 Codeca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "VertexNode.h"

typedef enum {
	
		BRICK = 1,
		WOOL,
		ORE,
		GRAIN,
		LUMBER,
		DESERT

} Resource;

@interface HexagonNode : SKSpriteNode

@property (nonatomic) Resource resource;
@property (nonatomic) NSUInteger number;
@property (nonatomic) NSUInteger diceValue;
@property (nonatomic, strong) NSMutableArray * vertexes;
@property (nonatomic, strong) NSMutableArray * edges;

-(void)giveResourceForDices: (NSInteger)dicesValue;

@end
