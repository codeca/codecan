//
//  VertexNode.h
//  Codecan
//
//  Created by Sylvio Cardoso on 22/10/13.
//  Copyright (c) 2013 BEPiD. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Player.h"


@class EdgeNode;
@class Port;

typedef enum  {
	
	VILLAGE = 1,
	CITY = 2
	
} VertexType;

@interface VertexNode : SKSpriteNode

@property (nonatomic, weak) Player* owner;

@property (nonatomic) VertexType type;

@property (nonatomic,strong) NSMutableArray* edges;

@property (nonatomic, strong) Port* port;


-(void)becomeVillageFor: (Player*) player;
-(void)becomeCity ;

@end
