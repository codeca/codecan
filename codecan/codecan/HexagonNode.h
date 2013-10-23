//
//  HexModel.h
//  codecan
//
//  Created by Felipe Fujioka on 22/10/13.
//  Copyright (c) 2013 Codeca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

typedef enum {
	HILL = 1,
	PASTURE,
	MOUNTAINS,
	FIELDS,
	FOREST,
	DESERT
} Resource;

@interface HexagonNode : SKSpriteNode

@property (nonatomic) Resource resource;

@property (nonatomic) NSUInteger number;

@property (nonatomic) NSUInteger diceValue;

@property (nonatomic, strong) NSMutableArray * vertexes;

@property (nonatomic, strong) NSMutableArray * edges;


@end
