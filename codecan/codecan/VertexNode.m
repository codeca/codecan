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
		self.name = @"vertex";
	}
	return self;
}

-(void)becomeVillageFor: (Player *)player{
	
	if(self.owner==nil){
		self.owner = player;
		self.owner.points++;
		self.type =  VILLAGE;
		//self.color = self.owner.color;
		//self.colorBlendFactor = 1.0;
		//self.texture = [SKTexture textureWithImageNamed:@"villageHouseH"];
		//self.texture = [ManaCrystalAtlas sharedInstance].textures[0];
		
		VertexNode * crystal = (VertexNode*)[VertexNode spriteNodeWithTexture:[ManaCrystalAtlas sharedInstance].textures[0]];
		crystal.color = self.owner.color;
		crystal.colorBlendFactor = 1.0;
		crystal.xScale = 0.8;
		crystal.yScale = 0.8;
		crystal.name = @"vertex";
		crystal.type = VILLAGE;
		
		crystal.position = CGPointMake(-5, 40);
		
		[self addChild:crystal];
		
		self.size = self.texture.size;
		[self runAction:[SKAction playSoundFileNamed:@"buildingsound.mp3" waitForCompletion:YES]];
		//self.xScale = 0.20;
		//self.yScale = 0.20;
		
		[crystal runAction:[SKAction repeatActionForever:
						  [SKAction animateWithTextures:[ManaCrystalAtlas sharedInstance].textures
										   timePerFrame:0.1f
												 resize:NO
												restore:YES]] withKey:@"crystal"];
	}
	
	for(EdgeNode *road in self.edges){
		if(road.owner != player){
			[road breakRoad];
		}
	}
	
	
}

-(void)becomeCity{
	
	self.type = CITY;
	self.owner.points++;
	
	self.texture = [SKTexture textureWithImageNamed:@"cityH"];
	self.size = self.texture.size;
	self.xScale = 0.75;
	[self runAction:[SKAction playSoundFileNamed:@"buildingsound.mp3" waitForCompletion:YES]];
	//self.yScale = 0.02;
	
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
