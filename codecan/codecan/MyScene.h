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
#import "Game.h"

typedef enum{
	
	ROADSEL=1,
	VILLAGESEL,
	CITYSEL,
	CARDSEL,

} Selection;

@interface MyScene : SKScene

@property (nonatomic, strong) SKNode * map;
@property (nonatomic, strong) SKNode *menu;
@property (nonatomic, strong) SKNode *resourcesList;
@property (nonatomic, strong) SKNode *tabs;
@property (nonatomic, strong) SKNode *properties;


@property (nonatomic, strong) Game * game;
@property (nonatomic) Selection selection;

+(instancetype)sceneWithSize:(CGSize)size andGame:(Game *) game;
@end
