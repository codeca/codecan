//
//  Player.h
//  codecan
//
//  Created by Felipe Fujioka on 23/10/13.
//  Copyright (c) 2013 Codeca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

typedef enum{
	PLAYERBRICK = 1,
	PLAYERWOOL,
	PLAYERORE,
	PLAYERGRAIN,
	PLAYERLUMBER,
	PLAYERDESERT
} PlayerRes;

@interface Player : NSObject

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString * ID;
@property (nonatomic, strong) SKColor* color;

@property (nonatomic)NSInteger wool;
@property (nonatomic)NSInteger brick;
@property (nonatomic)NSInteger ore;
@property (nonatomic)NSInteger grain;
@property (nonatomic)NSInteger lumber;

@property(nonatomic) NSInteger points;
@property(nonatomic) NSInteger cardPoints;


@property(nonatomic, strong) NSMutableArray* cards;
@property(nonatomic) NSInteger army;
@property(nonatomic) bool largestArmy;
@property(nonatomic) NSInteger roads;
@property(nonatomic) bool largestRoad;

-(NSString*) removeRandomResource;
-(BOOL) didPlayerWin;
-(NSArray*) mountPlayerHand;
- (NSInteger) numberOfResource:(NSInteger)resource;
-(void)removeCardOfType:(NSString*) type;

@end
