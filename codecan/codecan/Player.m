//
//  Player.m
//  codecan
//
//  Created by Felipe Fujioka on 23/10/13.
//  Copyright (c) 2013 Codeca. All rights reserved.
//

#import "Player.h"

@implementation Player



-(NSString*)removeRandomResource{
	
	NSMutableArray *resource;
	
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
	
	if (self.points <= 10) {
		return 1;
	}
	
	return 0;
	
}

@end
