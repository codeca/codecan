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
#import "BankTrader.h"
#import "Plug.h"
#import "PortTrader.h"
#import "ThiefDiscardScreen.h"
#import "DevelopmentCards.h"
#import "PortResourceTrader.h"
#import "HelpScreen.h"
#import "PlayerTrader.h"
#import "ShowOfferScreen.h"

typedef enum{
	
	ROADSEL=1,
	VILLAGESEL,
	CITYSEL,
	CARDSEL,

} Selection;

@interface MyScene : SKScene <PlugDelegate>


@property (nonatomic) int debug;



@property (nonatomic, strong) SKNode * map;
@property (nonatomic, strong) SKNode *menu;
@property (nonatomic, strong) SKNode *resourcesList;
@property (nonatomic, strong) SKNode *tabs;
@property (nonatomic, strong) SKNode *properties;
@property (nonatomic, strong) SKNode *stealInterface;
@property (nonatomic, strong) SKNode *topMenu;

@property (nonatomic, strong) SKSpriteNode *victory;

@property (nonatomic, strong) SKSpriteNode * thief;
@property (nonatomic, strong) SKLabelNode * resourcesLabel;
@property (nonatomic, strong) BankTrader * bankTrader;
@property (nonatomic, strong) PortTrader * portTrader;
@property (nonatomic,strong)  PortResourceTrader * portResourceTrader;
@property (nonatomic,strong)  ThiefDiscardScreen * thiefScreen;
@property (nonatomic, strong) PlayerTrader * playerTrader;
@property (nonatomic, strong) ShowOfferScreen * showOfferScreen;
@property (nonatomic, strong) HelpScreen * helpScreen;
@property (nonatomic, strong) SKSpriteNode * helpButton;

@property (nonatomic, strong) Plug * plug;

@property (nonatomic) NSInteger playersDiscardedForThief;

@property (nonatomic, strong) Game * game;
@property (nonatomic) Selection selection;

//top menu
@property (nonatomic, strong) SKSpriteNode* backgroundTopMenu;
@property (nonatomic, strong) NSMutableArray* spriteResources;
@property (nonatomic, strong) NSMutableArray* spriteDevelopment;
@property (nonatomic, strong) NSMutableArray* spritePoints;


//
@property (nonatomic) bool endGame;

+(instancetype)sceneWithSize:(CGSize)size andGame:(Game *) game;
-(void)broadcastResourcesChangeForPlayer: (Player*) player add:(NSArray*)addResources remove:(NSArray*)removeResources;
-(void) updateResources;
-(void) waitForAnswer;
-(void) updateResourcesForPLayer:(Player*) player add:(NSArray*)added andRemove:(NSArray*) removed;
@end
