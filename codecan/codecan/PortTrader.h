//
//  PortTrader.h
//  codecan
//
//  Created by Felipe Fujioka on 30/10/13.
//  Copyright (c) 2013 Codeca. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Player.h"
#import "BankTrader.h"

@interface PortTrader : BankTrader

-(void) portTraderForPlayer:(Player*) player andScene:(SKScene*) scene;

@end
