//
//  PlayerTrader.h
//  codecan
//
//  Created by Felipe Fujioka on 07/11/13.
//  Copyright (c) 2013 Codeca. All rights reserved.
//

#import "PortTrader.h"

@interface PlayerTrader : PortTrader

@property (nonatomic, strong) NSMutableDictionary * offerdic;
@property (nonatomic, strong) NSMutableDictionary * demand;

@property (nonatomic, strong) SKLabelNode * clearButton;
@property (nonatomic, strong) SKSpriteNode * blockScreen;

-(void) playerTraderForPlayer:(Player*) player andScene:(MyScene*) scene;
- (void) performTradeBetweenMeAndPlayer:(Player*) player;
-(void) dismissForResult:(BOOL) result;


@end
