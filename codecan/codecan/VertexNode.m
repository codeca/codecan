//
//  VertexNode.m
//  Codecan
//
//  Created by Sylvio Cardoso on 22/10/13.
//  Copyright (c) 2013 BEPiD. All rights reserved.
//

#import "VertexNode.h"
#import "EdgeNode.h"

@implementation VertexNode

-(id)init{
	
	self = [VertexNode spriteNodeWithImageNamed:@"vertex2"];
	
	if(self){
		_edges = [[NSMutableArray alloc] init];
		self.zPosition = 3;
	}
	return self;
}

-(void)becomeVillageFor: (Player *)player{
	
	if(self.owner==nil){
		self.owner = player;
		self.owner.points++;
		self.type =  VILLAGE;
		self.color = self.owner.color;
		self.colorBlendFactor = 1.0;
		self.texture = [SKTexture textureWithImageNamed:@"villageHouse"];
		self.size = self.texture.size;
		self.xScale = 0.20;
		self.yScale = 0.20;
	}
	
}

-(void)becomeCity{
	
	self.type = CITY;
	self.owner.points++;
	
	self.texture = [SKTexture textureWithImageNamed:@"city"];
	self.size = self.texture.size;
	self.xScale = 0.02;
	self.yScale = 0.02;
	
}

-(void)verifyNearRoads{
	for(EdgeNode* edge in self.edges){
		if(self.owner != edge.owner){
			edge.owner = nil;
			edge.color = [SKColor whiteColor];
		}
	}
}

@end
