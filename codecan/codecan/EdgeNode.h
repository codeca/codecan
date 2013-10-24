//
//  EdgeNode.h
//  Codecan
//
//  Created by Sylvio Cardoso on 22/10/13.
//  Copyright (c) 2013 BEPiD. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Player.h"

@interface EdgeNode : SKSpriteNode


@property(nonatomic,strong) NSMutableArray* vertexes;

@property(nonatomic, weak) Player* owner;


-(void)receiveOwner: (Player*) player;

@end

