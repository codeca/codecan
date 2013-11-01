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

typedef enum{
	BANKBLANK = 0,
	BANKBRICK,
	BANKWOOL,
	BANKORE,
	BANKGRAIN,
	BANKLUMBER,
	
	
} BankSelection;

@class MyScene;
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
@property (nonatomic, strong) SKLabelNode * tradeButton;


@property (nonatomic, weak) Player * player;

@property (nonatomic,weak) MyScene * myScene;

@property (nonatomic) SideSelector side;

@property (nonatomic) BankSelection selectionOffer;
@property (nonatomic) BankSelection selectionDemand;

-(void) bankTraderForPlayer:(Player*) player andScene:(MyScene*) scene;
-(void) setOfferTo:(BankSelection) selection;
-(void) setDemandTo:(BankSelection) selection;


@end
