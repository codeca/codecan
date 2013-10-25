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

-(HexagonNode *)initWithResource:(Resource)resource{
	
	switch(resource){
		case BRICK:
			self = [HexagonNode spriteNodeWithImageNamed:[[NSString alloc] initWithFormat:@"%d",(int)BRICK]];
			break;
		case GRAIN:
			self = [HexagonNode spriteNodeWithImageNamed:[[NSString alloc] initWithFormat:@"%d",(int)GRAIN]];
			break;
		case WOOL:
			self = [HexagonNode spriteNodeWithImageNamed:[[NSString alloc] initWithFormat:@"%d",(int)WOOL]];
			break;
		case ORE:
			self = [HexagonNode spriteNodeWithImageNamed:[[NSString alloc] initWithFormat:@"%d",(int)ORE]];
			break;
		case LUMBER:
			self = [HexagonNode spriteNodeWithImageNamed:[[NSString alloc] initWithFormat:@"%d",(int)LUMBER]];
			break;
		case DESERT:
			self = [HexagonNode spriteNodeWithImageNamed:[[NSString alloc] initWithFormat:@"%d",(int)DESERT]];
			break;
	}
	
	if(self){
		
		self.resource = resource;
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
