//
//  EdgeNode.m
//  Codecan
//
//  Created by Sylvio Cardoso on 22/10/13.
//  Copyright (c) 2013 BEPiD. All rights reserved.
//

#import "EdgeNode.h"

@implementation EdgeNode

-(id)init{

	self = [EdgeNode spriteNodeWithImageNamed:@"edge"];
	
	if(self){
		_vertexes = [[NSMutableArray alloc] init];
		self.zPosition = 2;
	}
	return self;
}


-(void)receiveOwner:(Player *)player{
	
	BOOL valid = NO;
	
	for(VertexNode * vertex in self.vertexes){
		if(vertex.owner == player){
			valid = YES;
			break;
		}else{
			for(EdgeNode * edge in vertex.edges){
				if(edge.owner==player){
					valid=YES;
					break;
				}
			}
		}
	}
	
	if(valid){
		self.owner = player;
		self.color = self.owner.color;
		self.colorBlendFactor= 1.0;
	}
}

-(void)breakRoad{
	self.owner = nil;
	self.color = [SKColor colorWithRed:0 green:0 blue:0 alpha:0];
	self.colorBlendFactor = 0;
	
}
@end
