//
//  ThiefDiscardScreen.h
//  codecan
//
//  Created by Otávio Netto Zani on 30/10/13.
//  Copyright (c) 2013 Codeca. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Player.h"

@interface ThiefDiscardScreen : SKNode


@property(nonatomic, strong) SKSpriteNode* lumber;
@property(nonatomic, strong) SKSpriteNode* wool;
@property(nonatomic, strong) SKSpriteNode* grain;
@property(nonatomic, strong) SKSpriteNode* ore;
@property(nonatomic, strong) SKSpriteNode* brick;

@property(nonatomic, strong) SKLabelNode* lumberCount;
@property(nonatomic, strong) SKLabelNode* woolCount;
@property(nonatomic, strong) SKLabelNode* grainCount;
@property(nonatomic, strong) SKLabelNode* oreCount;
@property(nonatomic, strong) SKLabelNode* brickCount;

@property(nonatomic, strong) SKSpriteNode* background;
@property(nonatomic, strong) SKSpriteNode* fader;


-(id)initInterfaceForPlayer:(Player *) player;



@end
