//
//  MyScene.m
//  codecan
//
//  Created by Guilherme Souza on 10/16/13.
//  Copyright (c) 2013 Codeca. All rights reserved.
//



#import "MyScene.h"

@interface MyScene()

-(void) selectItem:(SKNode*) item;
-(void) stopAnimationsInView:(SKNode *) parent;

@property (nonatomic, strong)SKLabelNode *yourTurn;

@end

@implementation MyScene

+(instancetype)sceneWithSize:(CGSize)size andGame:(Game *) game{
	MyScene* newScene = [super sceneWithSize:size];
	newScene.game = game;
	[newScene buildMap];
	[newScene buildBuildInterface];
	[newScene buildTabs];
	return newScene;
}

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
		
		self.plug.delegate = self;
		
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
		
		self.map = [[SKNode alloc] init];
		self. map.position = CGPointMake(self.size.width/2, self.size.height/2+44);
		
		self.menu = [[SKNode alloc] init];
		self. menu.position = CGPointMake(self.size.width/2, self.size.height*0.1);
				
		self.tabs = [[SKNode alloc] init];
		self.tabs.position = CGPointMake(self.size.width/2, self.menu.position.y+self.size.height/11);
	
		self.resourcesLabel = [SKLabelNode labelNodeWithFontNamed:@"ChalkDuster"];
		self.resourcesLabel.text = @"Lumber=0 Brick=0 Ore=0 Wool=0 Grain=0";
		self.resourcesLabel.position = CGPointMake(0, self.size.height*9/10);
		self.resourcesLabel.fontSize = 20;
		self.resourcesLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
	
		
		self.yourTurn = [SKLabelNode labelNodeWithFontNamed:@"ChalkDuster"];
		self.yourTurn.text = @"Your Turn!";
		self.yourTurn.position = CGPointMake(650, 900);
		self.yourTurn.fontSize = 20;

		
		
		[self addChild:self.resourcesLabel];
        [self addChild:self.map];
		[self addChild:self.menu];
		[self addChild:self.tabs];
		
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
	
	self.thief = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(40, 40)];
	self.thief.position = self.game.table.thief.position;
	self.thief.zPosition = 5;
	[self.map addChild:self.thief];
}

-(void) buildTabs{
	
	SKSpriteNode * background = [[SKSpriteNode alloc] initWithColor:[SKColor blackColor] size:CGSizeMake(self.size.width, 50)];
	[self.tabs addChild:background];
	
	SKLabelNode * buildTab = [SKLabelNode labelNodeWithFontNamed:@"ChalkDuster"];
	buildTab.text = @"Build";
	buildTab.fontSize = 20;
	buildTab.name=@"buildtab";
	buildTab.position = CGPointMake(-self.size.width/4, 0);
	
	SKLabelNode * handTab = [SKLabelNode labelNodeWithFontNamed:@"ChalkDuster"];
	handTab.text = @"Hand";
	handTab.fontSize = 20;
	handTab.name=@"handtab";
	handTab.position = CGPointMake(0, 0);
	
	SKLabelNode * tradeTab = [SKLabelNode labelNodeWithFontNamed:@"ChalkDuster"];
	tradeTab.text = @"Trade";
	tradeTab.fontSize = 20;
	tradeTab.name=@"tradetab";
	tradeTab.position = CGPointMake(self.size.width/4, 0);
	
	SKLabelNode *pass = [SKLabelNode labelNodeWithFontNamed:@"ChalkDuster"];
	pass.text = @"End Turn";
	pass.name = @"pass";
	pass.fontSize = 30;
	pass.position = CGPointMake(self.size.width*7/8, self.size.height*0.22);

	[self addChild:pass];
	[self.tabs addChild:buildTab];
	[self.tabs addChild:handTab];
	[self.tabs addChild:tradeTab];
	
}

-(void) selectItem:(SKNode*) item{

	SKAction * fadeIn = [SKAction fadeInWithDuration:0.4];
	SKAction * fadeOut = [SKAction fadeOutWithDuration:0.4];
	
	SKAction * sequence = [SKAction sequence:@[fadeOut, fadeIn]];
	SKAction * repeat = [SKAction repeatActionForever:sequence];
	[item runAction:repeat];

	
}

-(void) stopAnimationsInView:(SKNode *) parent{

	
	
	for(SKNode * child in parent.children){
		[child removeAllActions];
		child.alpha=1.0;
	}

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
						
						
						NSNumber *cityNumber = [NSNumber numberWithInt:[self.game.table.vertexes indexOfObject:vertex]];
						
						NSDictionary *data  = [NSDictionary dictionaryWithObjects:@[@(-1), cityNumber] forKeys:@[@"road", @"city"]];
						
						[self.plug sendMessage:MSG_BUILD data:data];
						
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
						
						else if (self.game.currentPlayer == self.game.players.firstObject && self.game.currentPlayer.points == 2){
							
							self.game.phase = RESOURCES;
							if(self.game.turn ==1){
								for(int i=2; i<13; i++)
									for(HexagonNode *hex in self.game.table.hexes)
										[hex giveResourceForDices:i];
								self.game.turn++;
								self.resourcesLabel.text = self.resourcesLabel.text =[NSString stringWithFormat:@"Lumber=%d Brick=%d Ore=%d Wool=%d Grain=%d",self.game.me.lumber,self.game.me.brick,self.game.me.ore,self.game.me.wool,self.game.me.grain] ;
							}
							
						}
						
						else {
							
							if (self.game.currentPlayer != self.game.players.lastObject && self.game.currentPlayer.points == 1) {
								
								self.game.currentPlayer = [self.game.players objectAtIndex:([self.game.players indexOfObject:self.game.currentPlayer]+1)];
								
								
							}
							
							else if (self.game.currentPlayer != self.game.players.firstObject && self.game.currentPlayer.points == 2){
								
								self.game.currentPlayer = [self.game.players objectAtIndex:([self.game.players indexOfObject:self.game.currentPlayer]-1)];
								
								
							}
							
							self.game.phase = INITIALIZATIONWAIT;
						}
						
						NSNumber *roadNumber = [NSNumber numberWithInt:[self.game.table.edges indexOfObject:edge]];
						
						NSDictionary *data  = [NSDictionary dictionaryWithObjects:@[roadNumber, @(-1)] forKeys:@[@"road", @"city"]];
						
						[self.plug sendMessage:MSG_BUILD data:data];
						
					}
					
					
					
				}
				
				break;
				
			case INITIALIZATIONWAIT:
				
				
				break;
			case RESOURCES:
				
				break;
				
			case ROBBER:
				if(clicked.class == HexagonNode.class){
					
					HexagonNode * hex = (HexagonNode*) clicked;
					
					[self.game.table moveThiefToHexagon:hex];
					self.thief.position = self.game.table.thief.position;
					NSLog(@"click no hexagono BITCH!");
					
				}else if(clicked.class == SKLabelNode.class){
					SKLabelNode * label = (SKLabelNode*) clicked;
					if(label.parent.class==HexagonNode.class){
						[self.game.table moveThiefToHexagon:(HexagonNode*)label.parent];
						self.thief.position = self.game.table.thief.position;
					}
				}
				
				break;
				
			case WAITDISCARD:
				
				break;
				
			case RUNNING:
				if(clicked.name == nil){
					
				}
				else if(![clicked.name compare:@"pass"]){
					[self.plug sendMessage:MSG_EOT data:@[]];
					self.game.phase = WAITTURN;
				}else if(![clicked.name compare:@"road"]){
				
					self.selection = ROADSEL;
					[self stopAnimationsInView:self.menu];
					[self selectItem:clicked];
					
				}else if(![clicked.name compare:@"village"]){
					
					self.selection = VILLAGESEL;
					[self stopAnimationsInView:self.menu];
					[self selectItem:clicked];
					
				}else if(![clicked.name compare:@"city"]){
					
					self.selection = CITYSEL;
					[self stopAnimationsInView:self.menu];
					[self selectItem:clicked];
					
				}else if(![clicked.name compare:@"card"]){
					
					self.selection = CARDSEL;
					[self stopAnimationsInView:self.menu];
					[self selectItem:clicked];
					
				}else if(![clicked.name compare:@"tradetab"]){
					[self buildTradeInterface];
					
				}else if(![clicked.name compare:@"buildtab"]){
					[self buildBuildInterface];
					
				}else if(![clicked.name compare:@"bank"]){
					[self buildBankTraderInterface];
				}
				
				if(clicked.class == EdgeNode.class && self.selection==ROADSEL && self.game.currentPlayer.lumber>0 && self.game.currentPlayer.brick>0){
					EdgeNode * edge = (EdgeNode *)clicked;
					[edge receiveOwner:self.game.currentPlayer];
					self.game.currentPlayer.lumber--;
					self.game.currentPlayer.brick--;
				}else if(clicked.class == VertexNode.class && self.selection==VILLAGESEL && self.game.currentPlayer.brick>0 && self.game
						 .currentPlayer.lumber>0 && self.game.currentPlayer.grain>0 && self.game.currentPlayer.wool>0){
					
					BOOL valid = NO;
					VertexNode * vertex = (VertexNode*) clicked;
					
					for(EdgeNode * edge in vertex.edges){
						
						if(edge.owner==self.game.currentPlayer){
							
							valid=YES;
							
						}
						
						for (VertexNode* neighbor in edge.vertexes) {
							
							if (neighbor.owner) {
								valid = NO;
								return;
							}
						}
						
					}
					
					if(valid){
						[vertex becomeVillageFor:self.game.currentPlayer];
						[vertex verifyNearRoads];
						self.game.currentPlayer.lumber--;
						self.game.currentPlayer.brick--;
						self.game.currentPlayer.grain--;
						self.game.currentPlayer.wool--;
					}
				}else if(clicked.class == VertexNode.class && self.selection==CITYSEL && self.game.currentPlayer.ore>2 && self.game
						 .currentPlayer.grain>1){
					VertexNode * vertex = (VertexNode*) clicked;
					
					if (vertex.owner == self.game.me && vertex.type == VILLAGE) {
						
						[vertex becomeCity];
						self.game.currentPlayer.ore-=3;
						self.game.currentPlayer.grain-=2;
					}
					
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
	
	
	
	if(self.game.currentPlayer == self.game.me && self.yourTurn.parent == nil){
		[self addChild:self.yourTurn];
	}
	else  if(self.game.currentPlayer != self.game.me){
		[self.yourTurn removeFromParent];
	}
	
	
	switch (self.game.phase){
		case INITIALIZATIONCITY:
			
			break;
			
		case INITIALIZATIONROAD:
			
			break;
			
		case INITIALIZATIONWAIT:
			
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
					if(hex!=self.game.table.thief)
						[hex giveResourceForDices:diceValue];
				}
				self.game.phase = RUNNING;
				self.resourcesLabel.text = self.resourcesLabel.text =[NSString stringWithFormat:@"Lumber=%d Brick=%d Ore=%d Wool=%d Grain=%d",self.game.me.lumber,self.game.me.brick,self.game.me.ore,self.game.me.wool,self.game.me.grain] ;
			}
				
			break;
			
		case ROBBER:
			// wait the current player to chose another hexagon to place the thief
			
			if(self.game.table.thiefHasBeenMoved){
				self.game.phase = RUNNING;
				self.game.table.thiefHasBeenMoved = NO;
			}
			
			break;
			
		case WAITDISCARD:
			
			break;
			
		case RUNNING:

			break;
			
		case WAITTRADES:
			
			break;
			
		case EOT:{
			
			NSUInteger index = [self.game.players indexOfObject:self.game.currentPlayer];
			if(index == self.game.players.count-1){
				index = 0;
				self.game.turn ++;
			}
			else{
				index++;
			}
			
			self.game.currentPlayer = [self.game.players objectAtIndex:index];
			
			break;
		}
		case WAITTURN:
			{
				if(self.game.turn ==1){
					for(int i=2; i<13; i++)
						for(HexagonNode *hex in self.game.table.hexes)
							[hex giveResourceForDices:i];
					self.game.turn++;
					self.resourcesLabel.text = self.resourcesLabel.text =[NSString stringWithFormat:@"Lumber=%d Brick=%d Ore=%d Wool=%d Grain=%d",self.game.me.lumber,self.game.me.brick,self.game.me.ore,self.game.me.wool,self.game.me.grain] ;
				}
				
				
				self.game.diceWasRolled = NO;
			}
			break;
	}
	
}

-(void) broadcastVillage:(NSNumber*) village{
	//parei aqui
			//NSDictionary * broadcast = []

}


-(void)buildTradeInterface{
	[self.menu removeAllChildren];
	
	SKSpriteNode *downMenu = [[SKSpriteNode alloc] initWithColor:[SKColor brownColor] size:CGSizeMake(self.size.width, self.size.height*0.2)];
	downMenu.position = CGPointMake(0, 0);
	[self.menu addChild:downMenu];
	
	float offset = -20;
	
	SKLabelNode *bankLabel = [SKLabelNode labelNodeWithFontNamed:@"ChalkDuster"];
	bankLabel.text = @"Bank Trade";
	bankLabel.position = CGPointMake(-downMenu.size.width/2 + 5, -40+offset);
	bankLabel.name = @"bank";
	bankLabel.fontSize = 20;
	bankLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
	[self.menu addChild:bankLabel];
	
	SKLabelNode *portLabel = [SKLabelNode labelNodeWithFontNamed:@"ChalkDuster"];
	portLabel.text = @"Port Trade";
	portLabel.position = CGPointMake(-downMenu.size.width/2+ 5, 0+offset);
	portLabel.name = @"port";
	portLabel.fontSize = 20;
	portLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
	[self.menu addChild:portLabel];
	
	SKLabelNode *friendLabel = [SKLabelNode labelNodeWithFontNamed:@"ChalkDuster"];
	friendLabel.text = @"Friends Trade";
	friendLabel.position = CGPointMake(-downMenu.size.width/2 + 5, 40+ offset);
	friendLabel.name = @"friend";
	friendLabel.fontSize = 20;
	friendLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
	[self.menu addChild:friendLabel];
	
}


-(void)buildBuildInterface{
	
	[self.menu removeAllChildren];
	
	SKSpriteNode *downMenu = [[SKSpriteNode alloc] initWithColor:[SKColor brownColor] size:CGSizeMake(self.size.width, self.size.height*0.2)];
	downMenu.position = CGPointMake(0, 0);
	[self.menu addChild:downMenu];
	
	
	SKLabelNode *roadLabel = [SKLabelNode labelNodeWithFontNamed:@"ChalkDuster"];
	roadLabel.text = @"Road";
	roadLabel.position = CGPointMake(-downMenu.size.width*3/10, 0);
	roadLabel.name = @"road";
	roadLabel.fontSize = 30;
	[self.menu addChild:roadLabel];
	
	SKLabelNode *villageLabel = [SKLabelNode labelNodeWithFontNamed:@"ChalkDuster"];
	villageLabel.text = @"Village";
	villageLabel.position = CGPointMake(-downMenu.size.width*1/10, 0);
	villageLabel.name = @"village";
	villageLabel.fontSize = 30;
	[self.menu addChild:villageLabel];
	
	SKLabelNode *cityLabel = [SKLabelNode labelNodeWithFontNamed:@"ChalkDuster"];
	cityLabel.text = @"City";
	cityLabel.position = CGPointMake(downMenu.size.width*1/10, 0);
	cityLabel.name = @"city";
	cityLabel.fontSize = 30;
	[self.menu addChild:cityLabel];
	
	SKLabelNode *cardLabel = [SKLabelNode labelNodeWithFontNamed:@"ChalkDuster"];
	cardLabel.text = @"Card";
	cardLabel.position = CGPointMake(downMenu.size.width*3/10, 0);
	cardLabel.name = @"card";
	cardLabel.fontSize = 30;
	[self.menu addChild:cardLabel];
	
}

- (void) buildBankTraderInterface{
	
	if(!self.bankTrader){
		self.bankTrader = [[BankTrader alloc] init];
		self.bankTrader.position = CGPointMake(self.size.width/2, self.size.height/2);
	}
	
	[self.bankTrader bankTraderForPlayer:self.game.currentPlayer andScene:self];
	
	
}

-(Player *) nextPlayer{
	
	NSInteger index = [self.game.players indexOfObject:self.game.currentPlayer];
	if(index == self.game.players.count-1){
		index = 0;
		self.game.turn++;
	}else{
		index++;
	}
	
	return [self.game.players objectAtIndex:index];

}

- (void)plug:(Plug *)plug receivedMessage:(PlugMsgType)type data:(id)data {
	
	NSLog(@"message received, type = %i",type);
	NSLog(@"message - complete = %@",data);
	
	switch(type){
		case MSG_EOT:
			self.game.currentPlayer = [self nextPlayer];
			if(self.game.currentPlayer == self.game.me){
				self.game.phase = RESOURCES;
			}
			break;
			
		case MSG_BUILD:{
			NSDictionary* build = data;
			NSInteger roadAtIndex = [(NSNumber*)[build objectForKey:@"road"] integerValue];
			NSInteger cityAtIndex = [(NSNumber*)[build objectForKey:@"city"] integerValue];

			if(roadAtIndex>=0){
				
				[(EdgeNode*)[self.game.table.edges objectAtIndex:roadAtIndex] receiveOwner: self.game.currentPlayer];
				
				if (self.game.phase == INITIALIZATIONWAIT) {
					
					if (self.game.currentPlayer != self.game.players.lastObject && self.game.currentPlayer.points == 1) {
						
						self.game.currentPlayer = [self.game.players objectAtIndex:([self.game.players indexOfObject:self.game.currentPlayer]+1)];
						
						if (self.game.currentPlayer == self.game.me) {
							
							self.game.phase = INITIALIZATIONCITY;
							
						}
						
					}
					
					else if (self.game.currentPlayer != self.game.players.firstObject && self.game.currentPlayer.points == 2){
						
						self.game.currentPlayer = [self.game.players objectAtIndex:([self.game.players indexOfObject:self.game.currentPlayer]-1)];
						
						if (self.game.currentPlayer == self.game.me) {
							
							self.game.phase = INITIALIZATIONCITY;
							
						}
						
					}
					
					else if (self.game.currentPlayer == self.game.players.firstObject && self.game.currentPlayer.points == 2){
						
						self.game.phase = WAITTURN;
						
					}
					
				}
				
			}else{
			
				VertexNode *city = [self.game.table.vertexes objectAtIndex:cityAtIndex];
				if(city.owner == nil){
					[city becomeVillageFor:self.game.currentPlayer];
				}else{
					[city becomeCity];
				}
			}
			
			break;
		}
			
	}
	
	
}
- (void)plugHasConnected:(Plug *)plug {
	NSLog(@"connected");
	
	
}

- (void)plug:(Plug *)plug hasClosedWithError:(BOOL)error {
	NSLog(@"closed %hhd", error);
	
	
}

@end
