//
//  ShowOfferScreen.h
//  codecan
//
//  Created by Felipe Fujioka on 07/11/13.
//  Copyright (c) 2013 Codeca. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Player.h"

@class MyScene;
@interface ShowOfferScreen : SKNode

@property (nonatomic, strong) SKSpriteNode * back;
@property (nonatomic, strong) SKSpriteNode * fader;
@property (nonatomic, strong) SKSpriteNode * theOffer;
@property (nonatomic, strong) SKSpriteNode * theDemand;
@property (nonatomic, strong) SKSpriteNode * lumberImage;
@property (nonatomic, strong) SKSpriteNode * brickImage;
@property (nonatomic, strong) SKSpriteNode * oreImage;
@property (nonatomic, strong) SKSpriteNode * grainImage;
@property (nonatomic, strong) SKSpriteNode * woolImage;

@property (nonatomic, strong) SKLabelNode * lumberQuantity;
@property (nonatomic, strong) SKLabelNode * brickQuantity;
@property (nonatomic, strong) SKLabelNode * oreQuantity;
@property (nonatomic, strong) SKLabelNode * grainQuantity;
@property (nonatomic, strong) SKLabelNode * woolQuantity;
@property (nonatomic, strong) SKLabelNode * offerLabel;
@property (nonatomic, strong) SKLabelNode * demandLabel;


@property (nonatomic, strong) SKLabelNode * acceptButton;
@property (nonatomic, strong) SKLabelNode * declineButton;

@property (nonatomic, weak) Player * player;

@property (nonatomic,weak) MyScene * myScene;

-(void) showOfferScreenForData:(NSDictionary*) data andScene:(MyScene *)scene andPlayer:(Player*) player;

@end
