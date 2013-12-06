//
//  EdgeNode.h
//  Codecan
//
//  Created by Sylvio Cardoso on 22/10/13.
//  Copyright (c) 2013 BEPiD. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Player.h"
#import "VertexNode.h"
#import "ManaLinkAtlas.h"

@interface EdgeNode : SKSpriteNode


@property(nonatomic,strong) NSMutableArray* vertexes;

@property(nonatomic, weak) Player* owner;


-(BOOL)receiveOwner: (Player*) player;
-(void)breakRoad;


@end

