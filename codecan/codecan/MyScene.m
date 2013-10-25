//
//  MyScene.m
//  codecan
//
//  Created by Guilherme Souza on 10/16/13.
//  Copyright (c) 2013 Codeca. All rights reserved.
//



#import "MyScene.h"

@implementation MyScene

+(instancetype)sceneWithSize:(CGSize)size andGame:(Game *) game{
	MyScene* newScene = [super sceneWithSize:size];
	newScene.game = game;
	[newScene buildMap];
	[newScene buildMenu];
	return newScene;
}

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
		
		self.map = [[SKNode alloc] init];
		self. map.position = CGPointMake(self.size.width/2, self.size.height/2+44);
		
		self.menu = [[SKNode alloc] init];
		self. menu.position = CGPointMake(self.size.width/2, self.size.height*0.1);
				
        [self addChild:self.map];
		[self addChild:self.menu];
		
    }

	
    return self;
}



- (void) buildMap{

	for(HexagonNode * hex in self.game.table.hexes){
		[self.map addChild:hex];
	}
	
	for(VertexNode * vertex in self.game.table.vertexes){
		[self.map addChild:vertex];
	}
	
	for(EdgeNode * edge in self.game.table.edges){
		[self.map addChild:edge];
	}

}

-(void) buildMenu{
	
	SKSpriteNode* downMenu = [[SKSpriteNode alloc] initWithColor:[SKColor brownColor] size:CGSizeMake(self.size.width, self.size.height*0.2)];
	downMenu.position = CGPointMake(0, 0);
	[self.menu addChild:downMenu];
	
	SKLabelNode *roadLabel = [SKLabelNode labelNodeWithFontNamed:@"ChalkDuster"];
	roadLabel.text = @"Road";
	roadLabel.position = CGPointMake(-downMenu.size.width*3/10, 0);
	roadLabel.name = @"road";
	roadLabel.fontSize = 30;
	[self.menu addChild:roadLabel];
	
	SKLabelNode *pass = [SKLabelNode labelNodeWithFontNamed:@"ChalkDuster"];
	pass.text = @"->";
	pass.name = @"pass";
	pass.fontSize = 30;
	[self.menu addChild:pass];
	
}

//alterei aqui duas vezes

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
		SKNode* clicked = [self nodeAtPoint:location];
		
		switch (self.game.phase){
			case INITIALIZATIONCITY:
				
				if(clicked.class == VertexNode.class){
					VertexNode* vertex = (VertexNode*)clicked;
					bool canConstruct= YES;
					
					for(EdgeNode* edge in vertex.edges)
						for(VertexNode* hasOwner in edge.vertexes)
							if(hasOwner.owner != nil)
								canConstruct = NO;
					
					if (canConstruct) {
						[vertex becomeVillageFor: self.game.currentPlayer];
						self.game.phase = INITIALIZATIONROAD;
						self.game.cityCreated = vertex;
					}
					
				}
				
				break;
				
			case INITIALIZATIONROAD:
				if(clicked.class == EdgeNode.class){
					EdgeNode* edge = (EdgeNode*)clicked;
					bool canConstruct= NO;
					
					for(VertexNode* vertex in edge.vertexes)
						if(vertex == self.game.cityCreated)
							canConstruct = YES;
					
					if (canConstruct) {
						[edge receiveOwner: self.game.currentPlayer];
						if(self.game.players.lastObject == self.game.me && !self.game.endInitialization){
							self.game.phase = INITIALIZATIONCITY;
							self.game.endInitialization = YES;
						}
						else{
							self.game.phase = WAITTURN;
						}
					}
					
				}
				
				break;
			case RESOURCES:
				
				break;
				
			case ROBBER:
				
				break;
				
			case WAITDISCARD:
				
				break;
				
			case RUNNING:
				if([clicked.name compare:@"pass"]){
					self.game.phase = WAITTURN;
				}
				if([clicked.name compare:@"road"]){
				
					
				}
				
				break;
				
			case WAITTRADES:
				
				break;
				
			case EOT:
				
				break;
				
			case WAITTURN:

				break;
		}
		
		
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
	
	switch (self.game.phase){
		case INITIALIZATIONCITY:
			
			break;
		case INITIALIZATIONROAD:
			
			break;
		case RESOURCES:
			if(!self.game.diceWasRolled){
				NSInteger diceValue = arc4random_uniform(6)+arc4random_uniform(6)+2;
				NSLog(@"%i", diceValue);
				if(diceValue == 7){
					self.game.phase=ROBBER;
					break;
				}
				for(HexagonNode * hex in self.game.table.hexes){
					[hex giveResourceForDices:diceValue];
				}
				self.game.phase = RUNNING;
			}
				
			break;
			
		case ROBBER:
			
			break;
			
		case WAITDISCARD:
			
			break;
			
		case RUNNING:

			break;
			
		case WAITTRADES:
			
			break;
			
		case EOT:
			
			break;
			
		case WAITTURN:
			{
				if(self.game.turn ==1){
					for(int i=2; i<13; i++)
						for(HexagonNode *hex in self.game.table.hexes)
							[hex giveResourceForDices:i];
					self.game.turn++;
				}
				
				
				self.game.diceWasRolled = NO;
				NSUInteger index = [self.game.players indexOfObject:self.game.currentPlayer];
				if(index == self.game.players.count-1){
					index = 0;
					self.game.turn ++;
				}
				else
					index++;
			
				self.game.phase = RESOURCES;
			}
			break;
	}
	
}

@end
