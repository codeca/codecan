//
//  PortResourceTrader.h
//  codecan
//
//  Created by Felipe Fujioka on 01/11/13.
//  Copyright (c) 2013 Codeca. All rights reserved.
//

#import "BankTrader.h"
#import "BankTrader.h"

@interface PortResourceTrader : BankTrader

@property (nonatomic) BankSelection resource;


-(void) buildInterfaceForPlayer: (Player*) player andResource:(BankSelection) resource andScene:(SKScene*) scene;
@end
