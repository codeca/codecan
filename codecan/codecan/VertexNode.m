//
//  VertexNode.m
//  Codecan
//
//  Created by Sylvio Cardoso on 22/10/13.
//  Copyright (c) 2013 BEPiD. All rights reserved.
//

#import "VertexNode.h"

@implementation VertexNode

-(id)init{
	
	self = [VertexNode spriteNodeWithImageNamed:@"vertex"];
	
	if(self){
		_edges = [[NSMutableArray alloc] init];
		self.zPosition = 3;
	}
	return self;
}

-(void)becomeVillageFor: (Player *)player{
	
	self.owner = player;
	self.type =  VILLAGE;
	self.color = self.owner.color;
	self.colorBlendFactor = 1.0;
	
}

-(void)becomeCity{
	
	self.type = CITY;
	
}

@end
