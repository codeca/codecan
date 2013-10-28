//
//  Game.m
//  codecan
//
//  Created by Felipe Fujioka on 24/10/13.
//  Copyright (c) 2013 Codeca. All rights reserved.
//

#import "Game.h"

@implementation Game

-(id)initWithNumberOfPLayers:(NSUInteger) players{
	
	self=[super init];
	
	if(self){
		/*
		 connect to server
		 match of number of players
		 wait for server to match
		 verify if we are the first player
		 if true setup the board
		 else wait for board to be broadcasted
		 */
		//self.plug = [[Plug alloc] init];
		
		
		
		self.players = [[NSMutableArray alloc] init];
		
		for(int i=0;i<players;i++){
			if(self.players.count == 0){
				self.me = [[Player alloc] init];
				[self.players addObject:self.me];
				self.me.color = [SKColor greenColor];
			}else{
				[self.players addObject:[[Player alloc] init]];
				switch(i){
					case 1:
						((Player *)self.players.lastObject).color = [SKColor blueColor];
						break;
					case 2:
						((Player *)self.players.lastObject).color = [SKColor redColor];
						break;
					case 3:
						((Player *)self.players.lastObject).color = [SKColor yellowColor];
						break;
				
				}
			}
		}
		
		// ask to server for first player
		self.currentPlayer = self.me;
		self.turn = 1;
		if(self.currentPlayer == self.me){
			self.table = [[Table alloc] init];
			//broadcast table
		}else{
			// receive table from server
		}
		if(self.currentPlayer == self.me){
			self.phase = INITIALIZATIONCITY;
			self.endInitialization = NO;
		}else{
			self.phase = WAITTURN;
		}
		
	}
	return self;
}


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
	
	
	
	// MUDAR DAQUI PRA BAIXO
	// ask to server for first player
	self.currentPlayer = self.me;
	self.turn = 1;
	if(self.currentPlayer == self.me){
		self.table = [[Table alloc] init];
		//broadcast table
	}else{
		// receive table from server
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
