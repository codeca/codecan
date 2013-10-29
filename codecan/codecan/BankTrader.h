//
//  BankTrader.h
//  codecan
//
//  Created by Jun Fujioka on 27/10/13.
//  Copyright (c) 2013 Codeca. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Player.h"

typedef enum{

	OFFERSIDE = 1,
	DEMANDSIDE
	
} SideSelector;

@interface BankTrader : SKNode

@property (nonatomic, strong) SKSpriteNode * back;
@property (nonatomic, strong) SKSpriteNode * fader;
@property (nonatomic, strong) SKSpriteNode * myOffer;
@property (nonatomic, strong) SKSpriteNode * myDemand;
@property (nonatomic, strong) SKSpriteNode * arrow;
@property (nonatomic, strong) SKSpriteNode * lumberImage;
@property (nonatomic, strong) SKSpriteNode * brickImage;
@property (nonatomic, strong) SKSpriteNode * oreImage;
@property (nonatomic, strong) SKSpriteNode * grainImage;
@property (nonatomic, strong) SKSpriteNode * woolImage;
@property (nonatomic, strong) SKSpriteNode * options;

@property (nonatomic, strong) SKLabelNode * lumberQuantity;
@property (nonatomic, strong) SKLabelNode * brickQuantity;
@property (nonatomic, strong) SKLabelNode * oreQuantity;
@property (nonatomic, strong) SKLabelNode * grainQuantity;
@property (nonatomic, strong) SKLabelNode * woolQuantity;

@property (nonatomic, weak) Player * player;

@property (nonatomic) SideSelector side;

-(void) bankTraderForPlayer:(Player*) player andScene:(SKScene*) scene;


@end
