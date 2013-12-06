//
//  Player.m
//  codecan
//
//  Created by Felipe Fujioka on 23/10/13.
//  Copyright (c) 2013 Codeca. All rights reserved.
//

#import "Player.h"
#import "HexagonNode.h"

@implementation Player



-(NSString*)removeRandomResource{
	
	NSMutableArray *resource = [[NSMutableArray alloc] init];
	
	if(self.lumber>0)
		[resource addObject:@"lumber"];
	if(self.wool>0)
		[resource addObject:@"wool"];
	if(self.ore>0)
		[resource addObject:@"ore"];
	if(self.grain>0)
		[resource addObject:@"grain"];
	if(self.brick>0)
		[resource addObject:@"brick"];
	
	
	NSString* lose = resource[arc4random_uniform(resource.count)];
	
	if(![lose compare:@"lumber"])
		self.lumber--;
	else if(![lose compare:@"ore"])
		self.ore--;
	else if(![lose compare:@"grain"])
		self.grain--;
	else if(![lose compare:@"wool"])
		self.wool--;
	else if(![lose compare:@"brick"])
		self.brick--;

	return lose;
	
}

-(BOOL)didPlayerWin {
	
	//Precisa adicionar as cartas de desenvolvimento aqui para ver se tudo funciona
	
	if (self.points + self.cardPoints + 2*self.largestArmy + 2*self.largestRoad < 10) {
		return 0;
	}
	
	return 1;
	
}


-(NSArray*) mountPlayerHand{
	NSMutableArray* hand = [[NSMutableArray alloc] init];
	
	for(int i=0; i<self.ore ;i++)
		[hand addObject:@"ore"];
	
	for(int i=0; i<self.wool ;i++)
		[hand addObject:@"wool"];
	
	for(int i=0; i<self.lumber ;i++)
		[hand addObject:@"lumber"];
	
	for(int i=0; i<self.brick ;i++)
		[hand addObject:@"brick"];
	
	for(int i=0; i<self.grain ;i++)
		[hand addObject:@"grain"];
	
	return hand;
}

- (NSInteger) numberOfResource:(NSInteger) resource{
	
	switch (resource) {
		case BRICK:
			return self.brick;
			break;
		case LUMBER:
			return self.lumber;
			break;
		case ORE:
			return self.ore;
			break;
		case WOOL:
			return self.wool;
			break;
		case GRAIN:
			return self.grain;
			break;
		default:
			break;
	}
	return 0;
}


-(void)removeCardOfType:(NSString *)type{
	
	int remove;
	
	if(![type compare:@"army"]){
		remove=0;
	}else if(![type compare:@"roads"]){
		remove=1;
	}else if(![type compare:@"monopoly"]){
		remove=2;
	}else if(![type compare:@"plenty"]){
		remove=3;
	}
	
	for(int i=0; i<self.cards.count; i++){
		if([(NSNumber*)self.cards[i] integerValue] == remove){
			[self.cards removeObjectAtIndex:i];
			return;
		}
	}
	
	
}

-(NSInteger) returnPoints{
	
	return _points + self.cardPoints + 2*self.largestArmy + 2*self.largestRoad;
}

-(NSInteger) points{
	
	return _points + 2*self.largestArmy +2*self.largestRoad;
}

@end
