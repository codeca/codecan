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


@class Game;
@interface HexagonNode : SKSpriteNode

typedef enum {
	
	BRICK = 1,
	WOOL,
	ORE,
	GRAIN,
	LUMBER,
	DESERT
	
	
} Resource;

@property (nonatomic) Resource resource;
@property (nonatomic) NSUInteger number;
@property (nonatomic) NSUInteger diceValue;
@property (nonatomic, strong) NSMutableArray * vertexes;
@property (nonatomic, strong) NSMutableArray * edges;
@property (nonatomic) BOOL mine;
@property (nonatomic, weak) Player* mineOwner;

-(void)giveResourceForDices: (NSInteger)dicesValue;
-(HexagonNode *) initWithResource:(Resource) resource;

-(void) verifyMineOwnerForGame: (Game*) game;

@end
