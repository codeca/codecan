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
@property (nonatomic) BOOL thiefInterface;

@end

@implementation MyScene

+(instancetype)sceneWithSize:(CGSize)size andGame:(Game *) game{
	MyScene* newScene = [super sceneWithSize:size];
	newScene.game = game;
	[newScene buildMap];
	[newScene buildBuildInterface];
	[newScene buildTabs];
	[newScene buildTopMenu];
	
	if(![newScene.game.me.name compare:@"debug1234"]){
		newScene.game.me.ore = 1000;
		newScene.game.me.lumber = 1000;
		newScene.game.me.wool = 1000;
		newScene.game.me.grain = 1000;
		newScene.game.me.brick = 1000;
	}
	
	return newScene;
}

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
		
		self.plug.delegate = self;
		
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
		
		SKSpriteNode *backgroundImage = [SKSpriteNode spriteNodeWithImageNamed:@"water"];
		backgroundImage.position=CGPointMake(self.size.width/2,self.size.height/2);
		
		
		self.map = [[SKNode alloc] init];
		self.map.position = CGPointMake(self.size.width/2, self.size.height/2+44);
		
		self.menu = [[SKNode alloc] init];
		self. menu.position = CGPointMake(self.size.width/2, self.size.height*0.1);
				
		self.tabs = [[SKNode alloc] init];
		self.tabs.position = CGPointMake(self.size.width/2, self.menu.position.y+self.size.height/11);
		
		self.topMenu = [[SKNode alloc] init];
		self.topMenu.position = CGPointMake(self.size.width/2, self.size.height-60);
		
		
		self.stealInterface = [[SKNode alloc] init];
		self.stealInterface.position = CGPointMake(self.size.width/2, self.size.height/2);
		self.stealInterface.zPosition = 7;
		
	
		self.resourcesLabel = [SKLabelNode labelNodeWithFontNamed:@"ChalkDuster"];
		self.resourcesLabel.text = @"Lumber=0 Brick=0 Ore=0 Wool=0 Grain=0";
		self.resourcesLabel.position = CGPointMake(0, self.size.height*9/10);
		self.resourcesLabel.fontSize = 20;
		self.resourcesLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
	
		
		self.yourTurn = [SKLabelNode labelNodeWithFontNamed:@"ChalkDuster"];
		self.yourTurn.text = @"Your Turn!";
		self.yourTurn.position = CGPointMake(650, 900);
		self.yourTurn.fontSize = 20;
		
		[self addChild:backgroundImage];
		[self addChild:self.resourcesLabel];
        [self addChild:self.map];
		[self addChild:self.menu];
		[self addChild:self.tabs];
		[self addChild:self.stealInterface];
		[self addChild:self.topMenu];
		
		
		
    }

	
    return self;
}



- (void) buildMap{

	for(HexagonNode * hex in self.game.table.hexes){
		[self.map addChild:hex];
	}
	
	for(VertexNode * vertex in self.game.table.vertexes){
		
		if (vertex.port.type == STANDARD) {
			
			//NSLog(@"Porto encontrado");
			
			vertex.colorBlendFactor = 1;
			vertex.color = [SKColor purpleColor];
			
		}
		
		else if (vertex.port.type == RESOURCE){
			
			NSLog(@"Porto encontrado");
			
			NSString * imageName;
			
			switch(vertex.port.resource){
				case BRICK:
					imageName=@"brick";
					break;
				case LUMBER:
					imageName=@"lumber";
					break;
				case ORE:
					imageName=@"ore";
					break;
				case GRAIN:
					imageName=@"grain";
					break;
				case WOOL:
					imageName=@"wool";
					break;
					
			}
			
			SKSpriteNode * resourceImage = [SKSpriteNode spriteNodeWithImageNamed:[NSString stringWithFormat: @"%@", imageName]];
			resourceImage.xScale*=0.05;
			resourceImage.yScale*=0.05;
			resourceImage.zPosition = 9;
			
			if(vertex.position.x<0 && vertex.position.y<0){
				resourceImage.position = CGPointMake(-10, -10);
			}else if(vertex.position.x<0 && vertex.position.y>0){
				resourceImage.position = CGPointMake(-10, 10);
			}else if(vertex.position.x>0 && vertex.position.y>0){
				resourceImage.position = CGPointMake(10, 10);
			}else if(vertex.position.x>0 && vertex.position.y<0){
				resourceImage.position = CGPointMake(10, -10);
			}
			
			[vertex addChild:resourceImage];
			
			
			vertex.colorBlendFactor = 1;
			vertex.color = [SKColor blackColor];
			
		}
		
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

-(void) buildTopMenu{

	self.backgroundTopMenu = [SKSpriteNode spriteNodeWithImageNamed:@"topMenu"];
	self.backgroundTopMenu.size =CGSizeMake(self.size.width, 130);
	self.backgroundTopMenu.position = CGPointMake(0, 0);
	
	
	SKSpriteNode *color;
	SKLabelNode *name;
	
	SKLabelNode *res;
	SKLabelNode *dev;
	SKLabelNode *points;
	
	[self.topMenu addChild:self.backgroundTopMenu];
	
	int offset =self.game.players.count;
	int counter = 0;
	
	for(int i=0; i<offset; i++){
		Player * player = self.game.players[i];
		
		if(player == self.game.me){
			counter--;
			continue;
		}
			
		
		color = [[SKSpriteNode alloc] initWithColor:player.color size:CGSizeMake(40, 40)];
		color.position = CGPointMake((i+counter-offset/2)*self.size.width/offset-40, 20);
		
		name = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
		name.fontSize = 15;
		name.text = player.name;
		name.position = CGPointMake((i+counter-offset/2)*self.size.width/offset-40, -15);
		name.fontColor = [SKColor blackColor];
		
		res = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
		res.fontSize = 15;
		res.text = @"resources:";
		res.position = CGPointMake((i+counter-offset/2)*self.size.width/offset+75+30-40, 30);
		res.fontColor = [SKColor blackColor];
		
		dev = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
		dev.fontSize = 15;
		dev.text = @"cards:";
		dev.position = CGPointMake((i+counter-offset/2)*self.size.width/offset+55+30-40, 10);
		dev.fontColor = [SKColor blackColor];
		
		points = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
		points.fontSize = 15;
		points.text = @"points:";
		points.position = CGPointMake((i+counter-offset/2)*self.size.width/offset+60+30-40, -10);
		points.fontColor = [SKColor blackColor];
		
		
		[self.topMenu addChild:res];
		[self.topMenu addChild:dev];
		[self.topMenu addChild:points];
		[self.topMenu addChild:name];
		[self.topMenu addChild:color];
	}
	
	
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

#pragma mark - touch events

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
								self.resourcesLabel.text =[NSString stringWithFormat:@"Lumber=%d Brick=%d Ore=%d Wool=%d Grain=%d",self.game.me.lumber,self.game.me.brick,self.game.me.ore,self.game.me.wool,self.game.me.grain] ;
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
				if(!self.game.table.thiefHasBeenMoved){
					if(clicked.class == HexagonNode.class){
						
						HexagonNode * hex = (HexagonNode*) clicked;
						
						[self.game.table moveThiefToHexagon:hex];
						self.thief.position = self.game.table.thief.position;
						
					}else if(clicked.class == SKLabelNode.class){
						SKLabelNode * label = (SKLabelNode*) clicked;
						if(label.parent.class==HexagonNode.class){
							[self.game.table moveThiefToHexagon:(HexagonNode*)label.parent];
							self.thief.position = self.game.table.thief.position;
						}
					}
					
				
					{
						
					NSNumber* hexTo = [NSNumber numberWithInt:[self.game.table.hexes indexOfObject:self.game.table.thief]];
					
					NSDictionary  * robberDictionary = [NSDictionary dictionaryWithObjects:@[@YES, hexTo] forKeys:@[@"discard", @"hexTo"]];
					
					[self.plug sendMessage:MSG_ROBBER data:robberDictionary];
						
					}
				}
				break;
				
			case WAITDISCARD:
			{
				NSScanner * scanner = [[NSScanner alloc] initWithString:clicked.name];
				int index;
				[scanner scanInt:&index];
				if(index>=0 && index <self.game.players.count){
					Player *robbed = self.game.players[index];
					Player *robber = self.game.me;
					
					NSString *robbedResource = [robbed removeRandomResource];
					
					[self broadcastResourcesChangeForPlayer:robbed add:@[] remove:@[robbedResource]];
					
					
					[self broadcastResourcesChangeForPlayer:robber add:@[robbedResource] remove:@[]];
					
					if(![robbedResource compare:@"lumber"])
						robber.lumber++;
					else if(![robbedResource compare:@"ore"])
						robber.ore++;
					else if(![robbedResource compare:@"grain"])
						robber.grain++;
					else if(![robbedResource compare:@"wool"])
						robber.wool++;
					else if(![robbedResource compare:@"brick"])
						robber.brick++;
					
					
					self.game.phase = RUNNING;
					
					[self.stealInterface removeAllChildren];
				}
			}
				break;
				
			case RUNNING:
				if(clicked.name == nil){
					
				}
				else if(![clicked.name compare:@"pass"]){
					[self stopAnimationsInView:self.menu];
					self.game.phase = EOT;
					self.game.currentPlayer = [self nextPlayer];
					
					if(self.game.players.count == 1){
						self.game.phase = RESOURCES;
					}
					
				}else if(![clicked.name compare:@"road"]){
					if(self.selection != ROADSEL){
						self.selection = ROADSEL;
						[self stopAnimationsInView:self.menu];
						[self selectItem:clicked];
					}else{
						self.selection = 0;
						[self stopAnimationsInView:self.menu];
					}
					
				}else if(![clicked.name compare:@"village"]){
					if(self.selection!=VILLAGESEL){
						self.selection = VILLAGESEL;
						[self stopAnimationsInView:self.menu];
						[self selectItem:clicked];
					}else{
						self.selection = 0;
						[self stopAnimationsInView:self.menu];
					}
					
				}else if(![clicked.name compare:@"city"]){
					if(self.selection != CITYSEL){
						self.selection = CITYSEL;
						[self stopAnimationsInView:self.menu];
						[self selectItem:clicked];
					}else{
						self.selection = 0;
						[self stopAnimationsInView:self.menu];
					}
					
				}else if(![clicked.name compare:@"card"]){
					
					[self stopAnimationsInView:self.menu];
					self.selection = 0;
					if(self.game.currentPlayer.ore>0 && self.game.currentPlayer.grain>0 && self.game.currentPlayer.wool>0 && self.game.table.deck.deck.count>0){
						
						self.game.currentPlayer.ore--;
						self.game.currentPlayer.grain--;
						self.game.currentPlayer.wool--;
					
						NSInteger card = [self.game.table.deck getDeckCard];
					
						switch(card){
							case SCORE:
								self.game.currentPlayer.cardPoints++;
							default:
								[self.game.currentPlayer.cards addObject:[NSNumber numberWithInt:card]];
						}
						
						[self.plug sendMessage:MSG_CARD_BUILD data:@[]];
					
						
						
					}
					
					
				}else if(![clicked.name compare:@"tradetab"]){
					[self buildTradeInterface];
					[self stopAnimationsInView:self.menu];
					self.selection = 0;
					
				}else if(![clicked.name compare:@"buildtab"]){
					[self buildBuildInterface];
					
				}else if(![clicked.name compare:@"bank"]){
					[self buildBankTraderInterface];
				}else if(![clicked.name compare:@"port"]){
					[self buildPortTraderInterface];
				}else if(![clicked.name compare:@"handtab"]){
					[self buildHandInteface];
				}else if(![clicked.name compare:@"army"]){
					
					
				}else if(![clicked.name compare:@"roads"]){
					
					
				}else if(![clicked.name compare:@"monopoly"]){
					
					
				}else if(![clicked.name compare:@"plenty"]){
					
					
				}
				
				if(clicked.class == EdgeNode.class && self.selection==ROADSEL && self.game.currentPlayer.lumber>0 && self.game.currentPlayer.brick>0){
					
					EdgeNode * edge = (EdgeNode *)clicked;
					[edge receiveOwner:self.game.currentPlayer];
					[self broadcastBuilding:-1 andRoad:[self.game.table.edges indexOfObject:edge]];
					
					if (edge.owner == self.game.currentPlayer) {
						self.game.currentPlayer.lumber--;
						self.game.currentPlayer.brick--;
					}
					
					
				}
				else if(clicked.class == VertexNode.class && self.selection==VILLAGESEL && self.game.currentPlayer.brick>0 && self.game
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
						[self broadcastBuilding:[self.game.table.vertexes indexOfObject:vertex] andRoad:-1];
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
						[self broadcastBuilding:[self.game.table.vertexes indexOfObject:vertex] andRoad:-1];
						self.game.currentPlayer.ore-=3;
						self.game.currentPlayer.grain-=2;
					}
					
				}else if(clicked.class == VertexNode.class && self.selection==0){
					VertexNode * vertex = (VertexNode*)clicked;
					
					if(vertex.owner == self.game.me){
						if(vertex.port.type == STANDARD){
							[self buildPortTraderInterface];
						}else if(vertex.port.type == RESOURCE && [self.game.currentPlayer numberOfResource:(NSInteger)vertex.port.resource]>=2){
							[self buildPortTraderInterface];
						}
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


#pragma mark - time based events
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
				NSLog(@"Dice = %i", diceValue);
				
				[self.plug sendMessage:MSG_DICE data:[NSNumber numberWithInt:diceValue]];
				
				if(diceValue == 7){
					self.game.phase=ROBBER;
					self.playersDiscardedForThief = 0;
					break;
				}
				
				
				for(HexagonNode * hex in self.game.table.hexes){
					if(hex!=self.game.table.thief)
						[hex giveResourceForDices:diceValue];
				}
				self.game.phase = RUNNING;
				
				
				[self tempRes];
			}
				
			break;
			
		case ROBBER:
			// wait the current player to chose another hexagon to place the thief
			
			if(self.game.table.thiefHasBeenMoved){
				if(!self.thiefInterface){
					[self buildThiefInterface];
					self.thiefInterface = YES;
				}
				if(self.playersDiscardedForThief == self.game.players.count){
					self.game.phase = WAITDISCARD;
					self.game.table.thiefHasBeenMoved = NO;
					self.thiefInterface = NO;
					self.playersDiscardedForThief = 0;
				}
			}
			
			break;
			
		case WAITDISCARD:
			if(self.stealInterface.children.count==0)
				[self buildStealInterface];
			
			break;
			
		case RUNNING:
			
			[self tempRes];
			if ([self.game.currentPlayer didPlayerWin]) {
				
				//Condicao de vitoria aqui
				
			}
			
			break;
			
		case WAITTRADES:
			
			break;
			
		case EOT:{
			
			[self broadcastResourcesChangeForPlayer:self.game.me add:[self.game.me mountPlayerHand] remove:@[@"all"]];
			[self.plug sendMessage:MSG_EOT data:@[]];
			self.game.phase = WAITTURN;
			
			break;
		}
		case WAITTURN:
			{
				if(self.game.turn ==1){
					for(int i=2; i<13; i++)
						for(HexagonNode *hex in self.game.table.hexes)
							[hex giveResourceForDices:i];
					self.game.turn++;
					
					[self tempRes];
				}
				
				
				self.game.diceWasRolled = NO;
			}
			
			[self tempRes];
			break;
	}
	
}

-(void) broadcastBuilding:(NSInteger) building andRoad:(NSInteger) road{
	
	NSNumber *roadNumber = [NSNumber numberWithInt:road];
	
	NSNumber *buildingNumber = [NSNumber numberWithInt:building];
	
	NSDictionary *data = [NSDictionary dictionaryWithObjects:@[roadNumber, buildingNumber] forKeys:@[@"road", @"city"]];
	
	[self.plug sendMessage:MSG_BUILD data:data];
}


-(void)buildStealInterface{
	
	SKSpriteNode *background = [[SKSpriteNode alloc] initWithColor:[SKColor brownColor] size:CGSizeMake(400, 400)];
	
	int counter=100;
	int verifier[4] = {0,0,0,0};
	for(VertexNode* vertex in self.game.table.thief.vertexes){
		if(vertex.owner==nil || vertex.owner == self.game.me )
			continue;
		
		int index =[self.game.players indexOfObject:vertex.owner];
		
		if(verifier[index])
			continue;
		
		verifier[index]=1;
		
		
		
		SKLabelNode* label = [SKLabelNode labelNodeWithFontNamed:@"ChalkDuster"];
		label.name = [NSString stringWithFormat:@"%i",index];
		label.text = vertex.owner.name;
		label.position = CGPointMake(0, counter);
		counter +=100;
		
		[background addChild:label];
	}
	

	if(background.children.count==0){
		self.game.phase = RUNNING;
	}else{
		[self.stealInterface addChild:background];
	}
	
	
}

-(void)buildTradeInterface{
	[self.menu removeAllChildren];
	
	SKSpriteNode *downMenu = [SKSpriteNode spriteNodeWithImageNamed:@"botMenu"];
	downMenu.size =CGSizeMake(self.size.width, self.size.height*0.2);
	downMenu.position = CGPointMake(0, -self.size.height*0.015);
	downMenu.zPosition = 2;
	[self.menu addChild:downMenu];
		
	SKLabelNode *bankLabel = [SKLabelNode labelNodeWithFontNamed:@"ChalkDuster"];
	bankLabel.text = @"Bank Trade";
	bankLabel.position = CGPointMake(-downMenu.size.width/4 , -15);
	bankLabel.name = @"bank";
	bankLabel.fontSize = 20;
	bankLabel.zPosition = 3;
	bankLabel.fontColor = [SKColor blackColor];
	[self.menu addChild:bankLabel];
	
	SKLabelNode *friendLabel = [SKLabelNode labelNodeWithFontNamed:@"ChalkDuster"];
	friendLabel.text = @"Friends Trade";
	friendLabel.position = CGPointMake(downMenu.size.width/4, -15);
	friendLabel.name = @"friend";
	friendLabel.fontSize = 20;
	friendLabel.zPosition = 3;
	friendLabel.fontColor = [SKColor blackColor];
	[self.menu addChild:friendLabel];
	
}


-(void)buildBuildInterface{
	
	[self.menu removeAllChildren];
	
	SKSpriteNode *downMenu = [SKSpriteNode spriteNodeWithImageNamed:@"botMenu"];
	downMenu.size =CGSizeMake(self.size.width, self.size.height*0.2);
	downMenu.position = CGPointMake(0, -self.size.height*0.015);
	downMenu.zPosition = 2;
	[self.menu addChild:downMenu];
	
	
	SKLabelNode *roadLabel = [SKLabelNode labelNodeWithFontNamed:@"ChalkDuster"];
	roadLabel.text = @"Road";
	roadLabel.position = CGPointMake(-downMenu.size.width*3/10, -15);
	roadLabel.name = @"road";
	roadLabel.fontSize = 30;
	roadLabel.zPosition = 3;
	roadLabel.fontColor = [SKColor blackColor];
	[self.menu addChild:roadLabel];
	
	SKLabelNode *villageLabel = [SKLabelNode labelNodeWithFontNamed:@"ChalkDuster"];
	villageLabel.text = @"Village";
	villageLabel.position = CGPointMake(-downMenu.size.width*1/10, -15);
	villageLabel.name = @"village";
	villageLabel.fontSize = 30;
	villageLabel.zPosition = 3;
	villageLabel.fontColor = [SKColor blackColor];
	[self.menu addChild:villageLabel];
	
	SKLabelNode *cityLabel = [SKLabelNode labelNodeWithFontNamed:@"ChalkDuster"];
	cityLabel.text = @"City";
	cityLabel.position = CGPointMake(downMenu.size.width*1/10, -15);
	cityLabel.name = @"city";
	cityLabel.fontSize = 30;
	cityLabel.zPosition = 3;
	cityLabel.fontColor = [SKColor blackColor];
	[self.menu addChild:cityLabel];
	
	SKLabelNode *cardLabel = [SKLabelNode labelNodeWithFontNamed:@"ChalkDuster"];
	cardLabel.text = @"Card";
	cardLabel.position = CGPointMake(downMenu.size.width*3/10, -15);
	cardLabel.name = @"card";
	cardLabel.fontSize = 30;
	cardLabel.zPosition = 3;
	cardLabel.fontColor = [SKColor blackColor];
	[self.menu addChild:cardLabel];
	
}


-(void) buildHandInteface{
	[self.menu removeAllChildren];
	
	SKSpriteNode *downMenu = [SKSpriteNode spriteNodeWithImageNamed:@"botMenu"];
	downMenu.size =CGSizeMake(self.size.width, self.size.height*0.2);
	downMenu.position = CGPointMake(0, -self.size.height*0.015);
	downMenu.zPosition = 2;
	[self.menu addChild:downMenu];
	
	NSInteger offset = self.game.me.cards.count;
	
	NSInteger counterx =-offset/2;
	for(NSNumber *card in self.game.me.cards){
		SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"ChalkDuster"];
		switch ([card integerValue]){
			case ARMY:
				label.text=@"army";
				label.name=@"army";
				break;
			case ROADS:
				label.text=@"Roads";
				label.name=@"roads";
				break;
			case MONOPOLY:
				label.text=@"Monopoly";
				label.name=@"monopoly";
				break;
			case YEAR_OF_PLENTY:
				label.text=@"Year Of Plenty";
				label.name=@"plenty";
				break;
			case SCORE:
				label.text=@"Score";
				label.name=@"score";
				break;
		}
		
		label.fontSize=20;
		label.fontColor = [SKColor blackColor];
		
		if(offset%2)
			label.position = CGPointMake(counterx*downMenu.size.width/offset+15,0);
		else
			label.position = CGPointMake((counterx+0.5)*downMenu.size.width/offset,0);
		counterx++;
		
		[downMenu addChild:label];
	}
		
}


- (void) buildBankTraderInterface{
	
	if(!self.bankTrader){
		self.bankTrader = [[BankTrader alloc] init];
		self.bankTrader.position = CGPointMake(self.size.width/2, self.size.height/2);
	}
	
	[self.bankTrader bankTraderForPlayer:self.game.currentPlayer andScene:self];
	
	
}

- (void) buildPortTraderInterface{
	
	if(!self.portTrader){
		self.portTrader = [[PortTrader alloc] init];
		self.portTrader.position = CGPointMake(self.size.width/2, self.size.height/2);
	}
	
	[self.portTrader portTraderForPlayer:self.game.currentPlayer andScene:self];
	
	
}

- (void) buildThiefInterface{
	
	if(!self.thiefScreen){
		self.thiefScreen = [[ThiefDiscardScreen alloc] init];
		self.thiefScreen.position = CGPointMake(self.size.width/2, self.size.height/2);
	}
	
	if([self.thiefScreen discardCountForPlayer:self.game.me]>=4 ){
		[self.thiefScreen discardScreenForPlayer:self.game.me andScene:self];
	}else{
		self.playersDiscardedForThief++;
		[self.plug sendMessage:MSG_HAND_CHANGED data:@[]];
	}
	
	
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


#pragma mark - server functions
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
			
		case MSG_DICE:
			
			for(HexagonNode * hex in self.game.table.hexes){
				if(hex!=self.game.table.thief)
					[hex giveResourceForDices:[data integerValue]];
			}
			
			break;
			
			
		case MSG_ROBBER:
			{
				
				NSDictionary* robberData = data;
				NSInteger hexTo= [(NSNumber*)[robberData objectForKey:@"hexTo"] integerValue];
				BOOL discard = [[robberData objectForKey:@"discard"] boolValue];
			
				self.game.table.thief = self.game.table.hexes[hexTo];
				
				self.thief.position = self.game.table.thief.position;
			
				if(discard){
					if(self.thiefScreen.parent == nil){
						[self buildThiefInterface];
					}
				}
				
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
				
				else {
					
					self.game.currentPlayer.brick--;
					self.game.currentPlayer.lumber--;
					
				}
				
			}
			
			else{
			
				VertexNode *city = [self.game.table.vertexes objectAtIndex:cityAtIndex];
				if(city.owner == nil){
					
					[city becomeVillageFor:self.game.currentPlayer];
					
					if (self.game.phase != INITIALIZATIONWAIT) {
				
						self.game.currentPlayer.lumber--;
						self.game.currentPlayer.brick--;
						self.game.currentPlayer.wool--;
						self.game.currentPlayer.grain--;
						
					}
					
				}
				
				else{
					
					[city becomeCity];
					
					if (self.game.phase != INITIALIZATIONWAIT) {
					
						self.game.currentPlayer.ore-=3;
						self.game.currentPlayer.grain-=2;
						
					}
				}
			}
			
			break;

		}
			
			
		case MSG_HAND_CHANGED:
		{
			NSDictionary* changes = data;
			
			self.playersDiscardedForThief++;

			if(changes.count ==0)
				break;
			
			Player * changed = self.game.players[[[changes valueForKey:@"player"] integerValue]];
			
			NSArray* added = [changes valueForKey:@"add"];
			
			NSArray* removed = [changes valueForKey:@"remove"];
			
			
			for(NSString* resource in removed){
				if(![resource compare:@"wool"]){
					changed.wool--;
				}else if(![resource compare:@"grain"]){
					changed.grain--;
				}else if(![resource compare:@"brick"]){
					changed.brick--;
				}else if(![resource compare:@"ore"]){
					changed.ore--;
				}else if(![resource compare:@"lumber"]){
					changed.lumber--;
				}else if(![resource compare:@"all"]){
					changed.lumber = 0;
					changed.wool = 0;
					changed.brick = 0;
					changed.grain = 0;
					changed.ore = 0;
				}
				
			}
			
			for(NSString* resource in added){
				if(![resource compare:@"wool"]){
					changed.wool++;
				}else if(![resource compare:@"grain"]){
					changed.grain++;
				}else if(![resource compare:@"brick"]){
					changed.brick++;
				}else if(![resource compare:@"ore"]){
					changed.ore++;
				}else if(![resource compare:@"lumber"]){
					changed.lumber++;
				}
				
			}
			
			self.resourcesLabel.text =[NSString stringWithFormat:@"Lumber=%d Brick=%d Ore=%d Wool=%d Grain=%d",self.game.me.lumber,self.game.me.brick,self.game.me.ore,self.game.me.wool,self.game.me.grain] ;
			
		}
			break;
		case MSG_CARD_BUILD:
				
			self.game.currentPlayer.ore--;
			self.game.currentPlayer.grain--;
			self.game.currentPlayer.wool--;
			
			NSInteger card = [self.game.table.deck getDeckCard];
			
			switch(card){
				case SCORE:
					self.game.currentPlayer.cardPoints++;
				default:
					[self.game.currentPlayer.cards addObject:[NSNumber numberWithInt:card]];
			}
			
			
			break;
	}
	
	
}
- (void)plugHasConnected:(Plug *)plug {
	NSLog(@"connected");
	
	
}

- (void)plug:(Plug *)plug hasClosedWithError:(BOOL)error {
	NSLog(@"closed %hhd", error);
	
	
}


//Array com strings dos resources!!!!
//Pode ser enviado @"all" no remove, nesse caso, tudo será removido, e o add precisará conter a mão final do player
-(void)broadcastResourcesChangeForPlayer: (Player*) player add:(NSArray*)addResources remove:(NSArray*)removeResources{
	NSDictionary * data;
	NSNumber* indexPlayer = [NSNumber numberWithInt:[self.game.players indexOfObject:player]];
	
	
	data = [NSDictionary dictionaryWithObjects:@[indexPlayer, addResources, removeResources] forKeys:@[@"player", @"add", @"remove"]];
	
	
	[self.plug sendMessage:MSG_HAND_CHANGED data:data];
	
}


#pragma mark - temporary
-(void) tempRes{
	self.resourcesLabel.text =[NSString stringWithFormat:@"Lumber=%d Brick=%d Ore=%d Wool=%d Grain=%d",self.game.me.lumber,self.game.me.brick,self.game.me.ore,self.game.me.wool,self.game.me.grain] ;
}

@end
