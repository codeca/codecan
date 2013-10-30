//
//  DevelopmentCards.h
//  codecan
//
//  Created by Otávio Netto Zani on 30/10/13.
//  Copyright (c) 2013 Codeca. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface DevelopmentCards : NSObject

typedef enum {
	ARMY=0,
	ROADS,
	MONOPOLY,
	YEAR_OF_PLENTY,
	SCORE
} cardType;

@property (nonatomic, strong) NSMutableArray* deck;


-(id)initDeck;

-(NSInteger)getDeckCard;

@end
