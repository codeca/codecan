//
//  DevelopmentCards.m
//  codecan
//
//  Created by Otávio Netto Zani on 30/10/13.
//  Copyright (c) 2013 Codeca. All rights reserved.
//

#import "DevelopmentCards.h"

@implementation DevelopmentCards

-(id)initDeck{
	
	self = [super init];
	
	if(self){
		NSMutableArray * cards = [[NSMutableArray alloc] init];
		
		NSNumber* aux;
		
		aux = [NSNumber numberWithInt:ARMY];
		for(int i=0; i<14 ; i++){
			[cards addObject:aux];
		}
		
		aux = [NSNumber numberWithInt:SCORE];
		for(int i=0; i<5 ; i++){
			[cards addObject:aux];
		}
		
		for(int i=0; i<2; i++){
			[cards addObject:[NSNumber numberWithInt:YEAR_OF_PLENTY]];
			[cards addObject:[NSNumber numberWithInt:MONOPOLY]];
			[cards addObject:[NSNumber numberWithInt:ROADS]];
		}
		
		self.deck=cards;
	}
	
	
	return self;
}


-(NSInteger)getDeckCard{
	
	int index = arc4random_uniform(self.deck.count);
	
	int typeOfCard = [(NSNumber *)self.deck[index] integerValue];
	
	[self.deck removeObjectAtIndex:index];
	
	return typeOfCard;
}

@end
