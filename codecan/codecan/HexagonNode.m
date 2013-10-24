//
//  HexModel.m
//  codecan
//
//  Created by Felipe Fujioka on 22/10/13.
//  Copyright (c) 2013 Codeca. All rights reserved.
//

#import "HexagonNode.h"

@implementation HexagonNode

-(id)init{
	self = [HexagonNode spriteNodeWithImageNamed:@"tile"];
	if(self){
	
		_vertexes = [[NSMutableArray alloc] init];
		_edges = [[NSMutableArray alloc] init];
		self.zPosition = 1;
		
		
	}
	return self;
	
}

-(void)giveResourceForDices:(NSInteger)dicesValue{
	if(dicesValue != self.number)
		return;
	
	for(VertexNode * vertex in self.vertexes){
		if(vertex.owner == nil)
			continue;
		switch (self.resource) {
			case WOOL:
				vertex.owner.wool++;
				break;
			case BRICK:
				vertex.owner.brick++;
				break;
			case GRAIN:
				vertex.owner.grain++;
				break;
			case LUMBER:
				vertex.owner.lumber++;
				break;
			case ORE:
				vertex.owner.ore++;
				break;
		}
		
	}
	
}


@end
