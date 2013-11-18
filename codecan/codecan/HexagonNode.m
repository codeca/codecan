//
//  HexModel.m
//  codecan
//
//  Created by Felipe Fujioka on 22/10/13.
//  Copyright (c) 2013 Codeca. All rights reserved.
//

#import "HexagonNode.h"
#import "Game.h"
@implementation HexagonNode

-(id)init{
	self = [HexagonNode spriteNodeWithImageNamed:@"tile"];
	if(self){
	
		_vertexes = [[NSMutableArray alloc] init];
		_edges = [[NSMutableArray alloc] init];
		self.zPosition = 1;
		self.mine = NO;
		
		
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
		self.xScale = 0.78;
		self.yScale = 0.78;
		
		
	}
	return self;


}

-(void)giveResourceForDices:(NSInteger)dicesValue{
	if(dicesValue != self.number)
		return;
	
	for(VertexNode * vertex in self.vertexes){
		if(vertex.owner == nil)
			continue;
		if (vertex.type == VILLAGE) {
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
				
				default:
					break;
			}
		}else{
			switch (self.resource) {
				case WOOL:
					vertex.owner.wool+=2;
					break;
				case BRICK:
					vertex.owner.brick+=2;
					break;
				case GRAIN:
					vertex.owner.grain+=2;
					break;
				case LUMBER:
					vertex.owner.lumber+=2;
					break;
				case ORE:
					vertex.owner.ore+=2;
					break;
					
				default:
					break;
					
			}
			
		}
		
	}
	
	[self giveCristalToOwner];
	
}

-(void) verifyMineOwnerForGame: (Game*) game{
	
	Player* aux = nil;
	NSInteger ownerPoints = 0;
	
	if(self.mineOwner != nil){
		for(VertexNode * vertex in self.vertexes){
			if(vertex.type == VILLAGE && vertex.owner == self.mineOwner){
				ownerPoints++;
			}else if(vertex.type == CITY && vertex.owner == self.mineOwner){
				ownerPoints+=2;
			}
		}
	}
	
	for(Player* player in game.players){
		NSInteger points = 0;
		for(VertexNode * vertex in self.vertexes){
			if(vertex.type == VILLAGE && vertex.owner == player){
				points++;
			}else if(vertex.type == CITY && vertex.owner == player){
				points+=2;
			}
		}
		
		if(points > ownerPoints){
			aux = player;
		}
		
		if(points>1 && self.mineOwner == nil){
			self.mineOwner = player;
			break;
		}
		
	}
	
	if(aux!=nil){
		self.mineOwner = aux;
	}
}

-(void) giveCristalToOwner{
	self.mineOwner.crystal++;
}

@end
