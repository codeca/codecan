//
//  ThiefDiscardScreen.h
//  codecan
//
//  Created by Otávio Netto Zani on 30/10/13.
//  Copyright (c) 2013 Codeca. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Player.h"
#import "MyScene.h"

typedef enum{
	
	DISLUMBER = 1,
	DISBRICK,
	DISORE,
	DISGRAIN,
	DISWOOL

} DiscardSelection;

@interface ThiefDiscardScreen : SKNode


@property(nonatomic, strong) SKSpriteNode* lumberImage;
@property(nonatomic, strong) SKSpriteNode* woolImage;
@property(nonatomic, strong) SKSpriteNode* grainImage;
@property(nonatomic, strong) SKSpriteNode* oreImage;
@property(nonatomic, strong) SKSpriteNode* brickImage;

@property(nonatomic, strong) SKLabelNode* lumberQuantity;
@property(nonatomic, strong) SKLabelNode* woolQuantity;
@property(nonatomic, strong) SKLabelNode* grainQuantity;
@property(nonatomic, strong) SKLabelNode* oreQuantity;
@property(nonatomic, strong) SKLabelNode* brickQuantity;

@property(nonatomic, strong) SKSpriteNode* background;
@property(nonatomic, strong) SKSpriteNode* fader;

@property (nonatomic, strong) SKSpriteNode * selections;
@property (nonatomic, strong) SKSpriteNode * options;

@property (nonatomic, strong) NSMutableArray * discardList;

@property (nonatomic, weak) Player * player;
@property (nonatomic) NSInteger discard;

@property (nonatomic, weak) MyScene * scene;


-(void) discardScreenForPlayer:(Player*) player andScene:(SKScene*) scene;
-(NSInteger) discardCountForPlayer: (Player*) player;


@end
