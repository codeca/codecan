//
//  Game.h
//  codecan
//
//  Created by Felipe Fujioka on 24/10/13.
//  Copyright (c) 2013 Codeca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Table.h"
#import "Player.h"
#import "Plug.h"

typedef enum{
	INITIALIZATIONCITY=1,
	INITIALIZATIONROAD,
	INITIALIZATIONWAIT,
	RESOURCES,
	ROBBER,
	WAITDISCARD,
	RUNNING,
	WAITTRADES,
	EOT,
	WAITTURN,
	ARMYTURN,
	WINNER,
	LOSER,
	ROADS_CARD,
	ROADS_CARD2
} Phase;

@interface Game : NSObject

@property (nonatomic, strong) Table * table;
@property (nonatomic, strong) Player * currentPlayer;
@property (nonatomic, strong) Player * me;
@property (nonatomic, strong) NSArray * players;
@property (nonatomic) Phase phase;
@property (nonatomic, strong) Plug * plug;
@property (nonatomic, weak) VertexNode* cityCreated;

@property (nonatomic) bool endInitialization;
@property (nonatomic) bool diceWasRolled;
@property (nonatomic) NSInteger turn;

-(id) initWithPlayers: (NSArray*) players Id:(NSString*) Id;

@end
