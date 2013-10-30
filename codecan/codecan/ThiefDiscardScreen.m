//
//  ThiefDiscardScreen.m
//  codecan
//
//  Created by Otávio Netto Zani on 30/10/13.
//  Copyright (c) 2013 Codeca. All rights reserved.
//

#import "ThiefDiscardScreen.h"

@implementation ThiefDiscardScreen

-(id) initInterfaceForPlayer:(Player *)player{
	
	if(self = [super init]){
		
		
	}
	
	return self;
}



-(NSInteger) discardCountForPlayer: (Player*) player{
	return (player.wool+player.brick+player.lumber+player.ore+player.grain)/2;
}

@end
