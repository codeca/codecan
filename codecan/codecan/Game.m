//
//  Game.m
//  codecan
//
//  Created by Felipe Fujioka on 24/10/13.
//  Copyright (c) 2013 Codeca. All rights reserved.
//

#import "Game.h"

@implementation Game

-(id) initWithPlayers: (NSMutableArray*) players Id:(NSString*) Id{
	
	self.players = players;
	
	for(int i=0;i<self.players.count;i++){
		
		Player* auxPlayer = players[i];
		
		if(auxPlayer.ID == Id){
			self.me = auxPlayer;
			self.me.color = [SKColor greenColor];
		}else{
			switch(i){
				case 1:
					auxPlayer.color = [SKColor blueColor];
					break;
				case 2:
					auxPlayer.color = [SKColor redColor];
					break;
				case 3:
					auxPlayer.color = [SKColor yellowColor];
					break;
					
			}
		}
	}
	
	// ask to server for first player
	self.currentPlayer = self.players[0];
	self.turn = 1;
	if(self.currentPlayer == self.me){
		self.table = [[Table alloc] init];
	}
	if(self.currentPlayer == self.me){
		self.phase = INITIALIZATIONCITY;
		self.endInitialization = NO;
	}else{
		self.phase = WAITTURN;
	}
	
	
	return self;


}


@end
