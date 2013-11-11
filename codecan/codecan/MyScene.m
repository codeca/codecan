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
@property (nonatomic) NSInteger playersAnswers;

@property (nonatomic, weak) SKSpriteNode * resourcesMenu;

@end

@implementation MyScene

+(instancetype)sceneWithSize:(CGSize)size andGame:(Game *) game{
	MyScene* newScene = [super sceneWithSize:size];
	newScene.game = game;
	[newScene buildMap];
	[newScene buildBuildInterface];
	[newScene buildTabs];
	[newScene buildTopMenu];
	
	if([newScene.game.me.name isEqual:@"debug1234"]){
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
		self.yourTurn.position = CGPointMake(700, 930);
		self.yourTurn.fontSize = 15;
		self.yourTurn.fontColor = [SKColor blackColor];
		
		self.helpButton = [SKSpriteNode spriteNodeWithImageNamed:@"helpicon"];
		self.helpButton.name = @"help";
		self.helpButton.position = CGPointMake(self.size.width/14, self.menu.position.y+self.size.height/7);
	
		
		[self addChild:backgroundImage];
		[self addChild:self.resourcesLabel];
        [self addChild:self.map];
		[self addChild:self.menu];
		[self addChild:self.tabs];
		[self addChild:self.stealInterface];
		[self addChild:self.topMenu];
		[self addChild:self.yourTurn];
		[self addChild:self.helpButton];
		
		
		
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
			
			//NSLog(@"Porto encontrado");
			
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
					
				default:
					break;
					
			}
			
			SKSpriteNode * resourceImage = [SKSpriteNode spriteNodeWithImageNamed:[NSString stringWithFormat: @"%@", imageName]];
			resourceImage.xScale*=0.05;
			resourceImage.yScale*=0.05;
			resourceImage.zPosition = 5;
			
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
	
	self.thief = [SKSpriteNode spriteNodeWithImageNamed:@"thief"];
	self.thief.size = CGSizeMake(50, 70);
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
		res.text = @"resources: 0";
		res.position = CGPointMake((i+counter-offset/2)*self.size.width/offset+75+30-40, 30);
		res.fontColor = [SKColor blackColor];
		res.name = [NSString stringWithFormat:@"resources%i",i];
		
		dev = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
		dev.fontSize = 15;
		dev.text = @"cards:";
		dev.position = CGPointMake((i+counter-offset/2)*self.size.width/offset+55+30-40, 10);
		dev.fontColor = [SKColor blackColor];
		dev.name = [NSString stringWithFormat:@"cards%i",i];
		
		points = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
		points.fontSize = 15;
		points.text = @"points:";
		points.position = CGPointMake((i+counter-offset/2)*self.size.width/offset+60+30-40, -10);
		points.fontColor = [SKColor blackColor];
		points.name = [NSString stringWithFormat:@"points%i",i];
		
		
		[self.topMenu addChild:res];
		[self.topMenu addChild:dev];
		[self.topMenu addChild:points];
		[self.topMenu addChild:name];
		[self.topMenu addChild:color];
	}
	
	SKLabelNode* myPoints;
	SKLabelNode* dice;
	
	myPoints = [SKLabelNode labelNodeWithFontNamed:@"ChalkDuster"];
	myPoints.fontSize = 15;
	myPoints.text = @"Your Points: 0";
	myPoints.fontColor = [SKColor blackColor];
	//NSLog(@"size %f", self.size.width);
	myPoints.position = CGPointMake(290, -15);
	myPoints.name = @"points";
	
	dice = [SKLabelNode labelNodeWithFontNamed:@"ChalkDuster"];
	dice.fontSize = 30;
	dice.text = @"D";
	dice.fontColor = [SKColor redColor];
	dice.position = CGPointMake(300, 10);
	dice.name = @"dice";

	
	[self.topMenu addChild:myPoints];
	[self.topMenu addChild:dice];
	
	
}

-(void) buildTabs{
	
	SKSpriteNode * background = [[SKSpriteNode alloc] initWithColor:[SKColor blackColor] size:CGSizeMake(self.size.width, 50)];
	[self.tabs addChild:background];
	
	SKLabelNode * buildTab = [SKLabelNode labelNodeWithFontNamed:@"ChalkDuster"];
	buildTab.text = @"Build";
	buildTab.fontSize = 20;
	buildTab.name=@"buildtab";
	buildTab.position = CGPointMake(-self.size.width*2/5, 0);
	
	SKLabelNode * handTab = [SKLabelNode labelNodeWithFontNamed:@"ChalkDuster"];
	handTab.text = @"Hand";
	handTab.fontSize = 20;
	handTab.name=@"handtab";
	handTab.position = CGPointMake(-self.size.width/5, 0);
	
	SKLabelNode * tradeTab = [SKLabelNode labelNodeWithFontNamed:@"ChalkDuster"];
	tradeTab.text = @"Trade";
	tradeTab.fontSize = 20;
	tradeTab.name=@"tradetab";
	tradeTab.position = CGPointMake(self.size.width/5, 0);
	
	SKLabelNode * resourcesTab = [SKLabelNode labelNodeWithFontNamed:@"ChalkDuster"];
	resourcesTab.text = @"Resources";
	resourcesTab.fontSize = 20;
	resourcesTab.name=@"resources";
	resourcesTab.position = CGPointMake(self.size.width*2/5, 0);
	
	SKLabelNode *pass = [SKLabelNode labelNodeWithFontNamed:@"ChalkDuster"];
	pass.text = @"End Turn";
	pass.name = @"pass";
	pass.fontSize = 30;
	pass.position = CGPointMake(0, 0);

	[self.tabs addChild:pass];
	[self.tabs addChild:buildTab];
	[self.tabs addChild:handTab];
	[self.tabs addChild:tradeTab];
	[self.tabs addChild:resourcesTab];
	
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

-(void) updateResources{
	for(SKLabelNode *label in self.resourcesMenu.children){
		if([label.name isEqualToString:@"brick"]){
			label.text = [NSString stringWithFormat:@"%d", self.game.me.brick];
		}else if([label.name isEqualToString:@"lumber"]){
			label.text = [NSString stringWithFormat:@"%d", self.game.me.lumber];
		}else if([label.name isEqualToString:@"ore"]){
			label.text = [NSString stringWithFormat:@"%d", self.game.me.ore];
		}else if([label.name isEqualToString:@"grain"]){
			label.text = [NSString stringWithFormat:@"%d", self.game.me.grain];
		}else if([label.name isEqualToString:@"wool"]){
			label.text = [NSString stringWithFormat:@"%d", self.game.me.wool];
		}
		
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
						
						if([self.game.table moveThiefToHexagon:hex]){
							self.thief.position = self.game.table.thief.position;
						
							NSNumber* hexTo = [NSNumber numberWithInt:[self.game.table.hexes indexOfObject:self.game.table.thief]];
						
							NSDictionary  * robberDictionary = [NSDictionary dictionaryWithObjects:@[@YES, hexTo] forKeys:@[@"discard", @"hexTo"]];
						
							[self.plug sendMessage:MSG_ROBBER data:robberDictionary];
						}
					}else if(clicked.class == SKLabelNode.class){
						SKLabelNode * label = (SKLabelNode*) clicked;
						if(label.parent.class==HexagonNode.class){
							
							if([self.game.table moveThiefToHexagon:(HexagonNode*)label.parent]){
								self.thief.position = self.game.table.thief.position;
							
								NSNumber* hexTo = [NSNumber numberWithInt:[self.game.table.hexes indexOfObject:self.game.table.thief]];
							
								NSDictionary  * robberDictionary = [NSDictionary dictionaryWithObjects:@[@YES, hexTo] forKeys:@[@"discard", @"hexTo"]];
							
								[self.plug sendMessage:MSG_ROBBER data:robberDictionary];
							}
						}
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
					
					if([robbedResource isEqual:@"lumber"])
						robber.lumber++;
					else if([robbedResource isEqual:@"ore"])
						robber.ore++;
					else if([robbedResource isEqual:@"grain"])
						robber.grain++;
					else if([robbedResource isEqual:@"wool"])
						robber.wool++;
					else if([robbedResource isEqual:@"brick"])
						robber.brick++;
					
					
					self.game.phase = RUNNING;
					[self updateResources];
					[self.stealInterface removeAllChildren];
				}
			}
				break;
				
			case RUNNING:
				
				if(clicked.name == nil){
					
				}
				else if([clicked.name isEqual:@"pass"]){
					[self stopAnimationsInView:self.menu];
					self.game.phase = EOT;
					self.game.currentPlayer = [self nextPlayer];
					
					if(self.game.players.count == 1){
						self.game.phase = RESOURCES;
					}
					
				}else if([clicked.name isEqual:@"road"]){
					if(self.selection != ROADSEL){
						self.selection = ROADSEL;
						[self stopAnimationsInView:self.menu];
						[self selectItem:clicked];
					}else{
						self.selection = 0;
						[self stopAnimationsInView:self.menu];
					}
					
				}else if([clicked.name isEqual:@"village"]){
					if(self.selection!=VILLAGESEL){
						self.selection = VILLAGESEL;
						[self stopAnimationsInView:self.menu];
						[self selectItem:clicked];
					}else{
						self.selection = 0;
						[self stopAnimationsInView:self.menu];
					}
					
				}else if([clicked.name isEqual:@"city"]){
					if(self.selection != CITYSEL){
						self.selection = CITYSEL;
						[self stopAnimationsInView:self.menu];
						[self selectItem:clicked];
					}else{
						self.selection = 0;
						[self stopAnimationsInView:self.menu];
					}
					
				}else if([clicked.name isEqual:@"card"]){
					
					[self stopAnimationsInView:self.menu];
					self.selection = 0;
					if(self.game.currentPlayer.ore>0 && self.game.currentPlayer.grain>0 && self.game.currentPlayer.wool>0 && self.game.table.deck.deck.count>0){
						
						[clicked runAction:[SKAction sequence:@[[SKAction fadeOutWithDuration:0.3], [SKAction fadeInWithDuration:0.3]]]];
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
					
					
				}else if([clicked.name isEqual:@"tradetab"]){
					[self buildTradeInterface];
					[self stopAnimationsInView:self.menu];
					self.selection = 0;
					
				}else if([clicked.name isEqual:@"buildtab"]){
					[self buildBuildInterface];
					
				}else if([clicked.name isEqual:@"bank"]){
					[self buildBankTraderInterface];
				}else if([clicked.name isEqual:@"port"]){
					[self buildPortTraderInterface];
				}else if([clicked.name isEqual:@"handtab"]){
					[self buildHandInteface];
				}else if([clicked.name isEqual:@"resources"]){
					[self buildResourceInteface];
				}else if([clicked.name isEqual:@"friend"]){
					[self buildPlayerTraderInterface];
				}else if([clicked.name isEqual:@"army"]){
					[self.game.currentPlayer removeCardOfType:@"army"];
					[clicked removeFromParent];
					self.game.table.thiefHasBeenMoved = NO;
					self.game.phase = ARMYTURN;
										
					[self.plug sendMessage:MSG_CARD_USED data:@"army"];
					
					self.game.currentPlayer.army++;
					
					int armyCount=2;
					int index=0;
					for(Player* player in self.game.players){
						if(player.largestArmy && player.army>armyCount){
							armyCount = player.army;
							index = [self.game.players indexOfObject:player];
							break;
						}
					}
					
					
					Player* aux;
					for(Player* player in self.game.players){
						if(player.army>armyCount){
							armyCount = player.army;
							aux= [self.game.players objectAtIndex:index];
							aux.largestArmy = NO;
							player.largestArmy=YES;
							index = [self.game.players indexOfObject:player];
						}
					}
					
					
				}else if([clicked.name isEqual:@"roads"]){
					[self.game.currentPlayer removeCardOfType:@"roads"];
					[clicked removeFromParent];
					
					self.game.phase = ROADS_CARD;
					
				}else if([clicked.name isEqual:@"monopoly"]){
					[self.game.currentPlayer removeCardOfType:@"monopoly"];
					[clicked removeFromParent];
					
					NSArray *resources =@[@"lumber", @"wool", @"grain", @"ore", @"brick"];
					
					int index = arc4random_uniform(5);
					
					if([(NSString*)resources[index] isEqual: @"lumber"]){
						
						for(Player * player in self.game.players){
							if(player != self.game.me){
								self.game.currentPlayer.lumber += player.lumber;
								player.lumber = 0;
							}
						}
						
					}else if([(NSString*)resources[index] isEqual: @"grain"]){
						
						for(Player * player in self.game.players){
							if(player != self.game.me){
								self.game.currentPlayer.grain += player.grain;
								player.grain = 0;
							}
						}
						
					}else if([(NSString*)resources[index] isEqual: @"ore"]){
						
						for(Player * player in self.game.players){
							if(player != self.game.me){
								self.game.currentPlayer.ore += player.ore;
								player.ore = 0;
							}
						}
						
					}else if([(NSString*)resources[index] isEqual: @"wool"]){
						
						for(Player * player in self.game.players){
							if(player != self.game.me){
								self.game.currentPlayer.wool += player.wool;
								player.wool = 0;
							}
						}
						
					}else if([(NSString*)resources[index] isEqual: @"brick"]){
						
						for(Player * player in self.game.players){
							if(player != self.game.me){
								self.game.currentPlayer.brick += player.brick;
								player.brick = 0;
							}
						}
						
					}
					
					
					for(Player * player in self.game.players){
						
						[self broadcastResourcesChangeForPlayer:player add:[player mountPlayerHand] remove:@[@"all"]];
						
					}
					
					
				}else if([clicked.name isEqual:@"plenty"]){
					[self.game.currentPlayer removeCardOfType:@"plenty"];
					[clicked removeFromParent];
					
					NSArray *resources =@[@"lumber", @"wool", @"grain", @"ore", @"brick"];
					
					int index1 = arc4random_uniform(5);
					int index2 = arc4random_uniform(5);
					
					if([(NSString*)resources[index1] isEqual: @"lumber"]){
						self.game.currentPlayer.lumber++;
					}else if([(NSString*)resources[index1] isEqual: @"grain"]){
						self.game.currentPlayer.grain++;
					}else if([(NSString*)resources[index1] isEqual: @"ore"]){
						self.game.currentPlayer.ore++;
					}else if([(NSString*)resources[index1] isEqual: @"wool"]){
						self.game.currentPlayer.wool++;
					}else if([(NSString*)resources[index1] isEqual: @"brick"]){
						self.game.currentPlayer.brick++;
					}
					
					
					if([(NSString*)resources[index2] isEqual: @"lumber"]){
						self.game.currentPlayer.lumber++;
					}else if([(NSString*)resources[index2] isEqual: @"grain"]){
						self.game.currentPlayer.grain++;
					}else if([(NSString*)resources[index2] isEqual: @"ore"]){
						self.game.currentPlayer.ore++;
					}else if([(NSString*)resources[index2] isEqual: @"wool"]){
						self.game.currentPlayer.wool++;
					}else if([(NSString*)resources[index2] isEqual: @"brick"]){
						self.game.currentPlayer.brick++;
					}
					
					
					[self broadcastResourcesChangeForPlayer:self.game.currentPlayer add:@[resources[index1],resources[index2]] remove:@[]];
					
					
					
				}
				
				if(clicked.class == EdgeNode.class && self.selection==ROADSEL && self.game.currentPlayer.lumber>0 && self.game.currentPlayer.brick>0){
					
					EdgeNode * edge = (EdgeNode *)clicked;
					[edge receiveOwner:self.game.currentPlayer];
					[self broadcastBuilding:-1 andRoad:[self.game.table.edges indexOfObject:edge]];
					
					if (edge.owner == self.game.currentPlayer) {
						self.game.currentPlayer.lumber--;
						self.game.currentPlayer.brick--;
					}
					
					
					
					int roadsCount=4;
					int index=0;
					for(Player* player in self.game.players){
						if(player.largestRoad && player.roads>roadsCount){
							roadsCount = player.roads;
							index = [self.game.players indexOfObject:player];
							break;
						}
					}
					
					
					Player* aux;
					for(Player* player in self.game.players){
						if(player.roads>roadsCount){
							roadsCount = player.roads;
							aux= [self.game.players objectAtIndex:index];
							aux.largestRoad = NO;
							player.largestRoad=YES;
							index = [self.game.players indexOfObject:player];
							NSLog(@"LargestRoad!!!");
						}
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
						
						int roadsCount=4;
						int index=0;
						for(Player* player in self.game.players){
							if(player.largestRoad && player.roads>roadsCount){
								roadsCount = player.roads;
								index = [self.game.players indexOfObject:player];
								break;
							} else{
								player.largestRoad = NO;
							}
						}
						
						
						Player* aux;
						for(Player* player in self.game.players){
							if(player.roads>roadsCount){
								roadsCount = player.roads;
								aux= [self.game.players objectAtIndex:index];
								aux.largestRoad = NO;
								player.largestRoad=YES;
								index = [self.game.players indexOfObject:player];
								NSLog(@"LargestRoad!!!");
							}
						}
						
						
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
					
				}else if(clicked.class == VertexNode.class && self.selection!=CITYSEL){
					VertexNode * vertex = (VertexNode*)clicked;
					
					if(vertex.owner == self.game.currentPlayer){
						if(vertex.port.type == STANDARD){
							[self buildPortTraderInterface];
						}else if(vertex.port.type == RESOURCE && [self.game.currentPlayer numberOfResource:(NSInteger)vertex.port.resource]>=2){
							[self buildPortResourceTraderInterfaceForResource:(Selection)vertex.port.resource];
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
				
			case ARMYTURN:
				if(!self.game.table.thiefHasBeenMoved){
					if(clicked.class == HexagonNode.class){
						
						HexagonNode * hex = (HexagonNode*) clicked;
						
						[self.game.table moveThiefToHexagon:hex];
						self.thief.position = self.game.table.thief.position;
						
						
						self.game.phase = WAITDISCARD;
						self.game.table.thiefHasBeenMoved = NO;
						
					}else if(clicked.class == SKLabelNode.class){
						SKLabelNode * label = (SKLabelNode*) clicked;
						if(label.parent.class==HexagonNode.class){
							[self.game.table moveThiefToHexagon:(HexagonNode*)label.parent];
							self.thief.position = self.game.table.thief.position;
							
							self.game.phase = WAITDISCARD;
							self.game.table.thiefHasBeenMoved = NO;
						}
					}
					
					
					{
						
						NSNumber* hexTo = [NSNumber numberWithInt:[self.game.table.hexes indexOfObject:self.game.table.thief]];
						
						NSDictionary  * robberDictionary = [NSDictionary dictionaryWithObjects:@[@NO, hexTo] forKeys:@[@"discard", @"hexTo"]];
						
						[self.plug sendMessage:MSG_ROBBER data:robberDictionary];
						
					}
				}

				break;
				
			case WINNER:
				self.endGame = YES;
				
				break;
				
			case LOSER:
				self.endGame = YES;
				
				break;
				
			case ROADS_CARD:
				
				if(clicked.class == EdgeNode.class ){
					
					EdgeNode * edge = (EdgeNode *)clicked;
					[edge receiveOwner:self.game.currentPlayer];
					[self broadcastBuilding:-1 andRoad:[self.game.table.edges indexOfObject:edge]];
					
					if(edge.owner == self.game.currentPlayer)
						self.game.phase = ROADS_CARD2;
					
					int roadsCount=4;
					int index=0;
					for(Player* player in self.game.players){
						if(player.largestRoad && player.roads>roadsCount){
							roadsCount = player.roads;
							index = [self.game.players indexOfObject:player];
							break;
						}
					}
					
					
					Player* aux;
					for(Player* player in self.game.players){
						if(player.roads>roadsCount){
							roadsCount = player.roads;
							aux= [self.game.players objectAtIndex:index];
							aux.largestRoad = NO;
							player.largestRoad=YES;
							index = [self.game.players indexOfObject:player];
							NSLog(@"LargestRoad!!!");
						}
					}
					
					
				}
				break;
				
			case ROADS_CARD2:
				if(clicked.class == EdgeNode.class ){
					
					
					EdgeNode * edge = (EdgeNode *)clicked;
					[edge receiveOwner:self.game.currentPlayer];
					[self broadcastBuilding:-1 andRoad:[self.game.table.edges indexOfObject:edge]];
					
					if(edge.owner == self.game.currentPlayer)
						self.game.phase = RUNNING;
					
					int roadsCount=4;
					int index=0;
					for(Player* player in self.game.players){
						if(player.largestRoad && player.roads>roadsCount){
							roadsCount = player.roads;
							index = [self.game.players indexOfObject:player];
							break;
						}
					}
					
					
					Player* aux;
					for(Player* player in self.game.players){
						if(player.roads>roadsCount){
							roadsCount = player.roads;
							aux= [self.game.players objectAtIndex:index];
							aux.largestRoad = NO;
							player.largestRoad=YES;
							index = [self.game.players indexOfObject:player];
							NSLog(@"LargestRoad!!!");
						}
					}
					
					
					
				}
				
				break;
				default:
				break;
		}
		
		if([clicked.name isEqualToString:@"help"]){
			[self buildHelpScreen];
		}else if([clicked.name isEqual:@"handtab"]){
			[self buildHandInteface];
		}else if([clicked.name isEqual:@"resources"]){
			[self buildResourceInteface];
		}
		
		[self updateResources];
		
    }
}


#pragma mark - time based events
-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
	
	SKLabelNode *aux = (SKLabelNode*)[self.topMenu childNodeWithName:@"points"];
	aux.text = [NSString stringWithFormat:@"Your Points:%i", [self.game.me returnPoints]];
	
	for (int i = 0; i < [self.game.players count]; i++) {
		
		Player * player  = [self.game.players objectAtIndex:i];
		
		if (self.game.me != player) {
		
		aux = (SKLabelNode*)[self.topMenu childNodeWithName:[NSString stringWithFormat:@"resources%i",i]];
		aux.text = [NSString stringWithFormat:@"resources: %i",(player.wool+player.ore+player.brick+player.lumber+player.grain)];
		aux = (SKLabelNode*)[self.topMenu childNodeWithName:[NSString stringWithFormat:@"cards%i",i]];
		aux.text = [NSString stringWithFormat:@"cards: %i",[player.cards count]];
		aux = (SKLabelNode*)[self.topMenu childNodeWithName:[NSString stringWithFormat:@"points%i",i]];
		aux.text = [NSString stringWithFormat:@"points: %i",player.points];
		
		}
	}
	
	if(self.game.currentPlayer == self.game.me && self.yourTurn.hidden == YES){ //self.yourTurn.parent == nil
		//[self addChild:self.yourTurn];
		self.yourTurn.hidden = NO;
		SKAction * moveAndScale = [SKAction group:@[[SKAction playSoundFileNamed:@"yourturnwarning.mp3" waitForCompletion:YES]]];
		[self.yourTurn runAction:moveAndScale];
									   
	}
	else  if(self.game.currentPlayer != self.game.me){
		//[self.yourTurn removeFromParent];
		self.yourTurn.hidden = YES;
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
				
				NSDictionary* diceDictionary = [NSDictionary dictionaryWithObjects:@[@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12"] forKeys:@[@2,@3,@4,@5,@6,@7,@8,@9,@10,@11,@12]];
				
				NSMutableString *diceNumber = [diceDictionary objectForKey:([NSNumber numberWithInt:diceValue])];
				SKLabelNode *diceLabel = (SKLabelNode*)[self.topMenu childNodeWithName:@"dice"];
				
				diceLabel.text = diceNumber;
				
				[diceLabel runAction:[SKAction sequence:@[[SKAction scaleBy:2 duration:0.2], [SKAction scaleBy:0.5 duration:0.2]]]];
												
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
				
				[self updateResources];
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
				
				[self.plug sendMessage:MSG_WINNER data:@[]];
				self.game.phase = WINNER;
				
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
			
			
		case WINNER:
			
			if(self.victory.parent == nil){
				self.victory = [SKSpriteNode spriteNodeWithImageNamed:@"victory"];
				self.victory.zPosition = 10;
				self.victory.size = CGSizeMake(600, 300);
				self.victory.position = CGPointMake(self.size.width/2, self.size.height/2);
				[self addChild:self.victory];
			}
			
			break;
			
		case LOSER:
			
			if(self.victory.parent == nil){
				self.victory = [SKSpriteNode spriteNodeWithImageNamed:@"defeat"];
				self.victory.zPosition = 10;
				self.victory.size = CGSizeMake(600, 300);
				self.victory.position = CGPointMake(self.size.width/2, self.size.height/2);
				[self addChild:self.victory];
			}
			
			break;
		default:
			break;
	}
	
}

-(void) broadcastBuilding:(NSInteger) building andRoad:(NSInteger) road{
	
	NSNumber *roadNumber = [NSNumber numberWithInt:road];
	
	NSNumber *buildingNumber = [NSNumber numberWithInt:building];
	
	NSDictionary *data = [NSDictionary dictionaryWithObjects:@[roadNumber, buildingNumber] forKeys:@[@"road", @"city"]];
	
	[self.plug sendMessage:MSG_BUILD data:data];
}

- (void) buildHelpScreen{
	if(!self.helpScreen){
		self.helpScreen = [[HelpScreen alloc] init];
	}
	
	[self addChild:self.helpScreen];
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

-(void) buildResourceInteface{
	[self.menu removeAllChildren];

	SKSpriteNode *downMenu = [SKSpriteNode spriteNodeWithImageNamed:@"botMenu"];
	downMenu.size =CGSizeMake(self.size.width, self.size.height*0.2);
	downMenu.position = CGPointMake(0, -self.size.height*0.015);
	downMenu.zPosition = 2;
	[self.menu addChild:downMenu];
	
	self.resourcesMenu = downMenu;
	
	for(int i =1; i <= 5; i++){
		
		NSString * imageName;
		NSString * quantityS;
		
		switch(i){
			case BRICK:
				imageName=@"brick";
				quantityS = [NSString stringWithFormat:@"%d", self.game.currentPlayer.brick];
				break;
			case LUMBER:
				imageName=@"lumber";
				quantityS = [NSString stringWithFormat:@"%d", self.game.currentPlayer.lumber];
				break;
			case ORE:
				imageName=@"ore";
				quantityS = [NSString stringWithFormat:@"%d", self.game.currentPlayer.ore];
				break;
			case GRAIN:
				imageName=@"grain";
				quantityS = [NSString stringWithFormat:@"%d", self.game.currentPlayer.grain];
				break;
			case WOOL:
				imageName=@"wool";
				quantityS = [NSString stringWithFormat:@"%d", self.game.currentPlayer.wool];
				break;
				
		}

		
		SKSpriteNode * resource = [SKSpriteNode spriteNodeWithImageNamed:imageName];
		resource.position = CGPointMake(i*downMenu.size.width/6-downMenu.size.width/2, 0);
		resource.size = CGSizeMake(resource.texture.size.width*0.1, resource.texture.size.height*0.1);
		[downMenu addChild:resource];
		
		SKLabelNode * quantity = [SKLabelNode labelNodeWithFontNamed:@"ChalkDuster"];
		quantity.text = quantityS;
		quantity.name = imageName;
		quantity.fontSize = 20;
		quantity.fontColor = [SKColor blackColor];
		quantity.position = CGPointMake(resource.position.x, resource.position.y-40);
		[downMenu addChild:quantity];
	}

	
	
}



- (void) buildBankTraderInterface{
	
	if(!self.bankTrader){
		self.bankTrader = [[BankTrader alloc] init];
		self.bankTrader.position = CGPointMake(self.size.width/2, self.size.height/2);
	}
	
	[self.bankTrader bankTraderForPlayer:self.game.currentPlayer andScene:self];
	
	
}

- (void) buildPlayerTraderInterface{
	
	if(!self.playerTrader){
		self.playerTrader = [[PlayerTrader alloc] init];
		self.playerTrader.position = CGPointMake(self.size.width/2, self.size.height/2);
	}
	self.playersAnswers = 0;
	[self.playerTrader playerTraderForPlayer:self.game.currentPlayer andScene:self];
	
	
}

- (void) buildPortTraderInterface{
	
	if(!self.portTrader){
		self.portTrader = [[PortTrader alloc] init];
		self.portTrader.position = CGPointMake(self.size.width/2, self.size.height/2);
	}
	
	[self.portTrader portTraderForPlayer:self.game.currentPlayer andScene:self];
	
	
}

- (void) buildPortResourceTraderInterfaceForResource:(Selection) resource{
	
	if(!self.portResourceTrader){
		self.portResourceTrader = [[PortResourceTrader alloc] init];
		self.portResourceTrader.position = CGPointMake(self.size.width/2, self.size.height/2);
	}
	
	[self.portResourceTrader buildInterfaceForPlayer:self.game.currentPlayer andResource:(BankSelection) resource andScene:self];
	
	
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

- (void) buildShowOfferForOffer:(NSDictionary*) data{
	
	if(!self.showOfferScreen){
		self.showOfferScreen = [[ShowOfferScreen alloc] init];
		self.showOfferScreen.position = CGPointMake(self.size.width/2, self.size.height/2);
	}
	
	[self.showOfferScreen showOfferScreenForData:data andScene:self andPlayer:self.game.me];
	
}

-(void) updateResourcesForPLayer:(Player*) player add:(NSArray*)added andRemove:(NSArray*) removed{
	
	for(NSString* resource in removed){
		if([resource isEqual:@"wool"]){
			player.wool--;
		}else if([resource isEqual:@"grain"]){
			player.grain--;
		}else if([resource isEqual:@"brick"]){
			player.brick--;
		}else if([resource isEqual:@"ore"]){
			player.ore--;
		}else if([resource isEqual:@"lumber"]){
			player.lumber--;
		}else if([resource isEqual:@"all"]){
			player.lumber = 0;
			player.wool = 0;
			player.brick = 0;
			player.grain = 0;
			player.ore = 0;
		}
		
	}
	
	for(NSString* resource in added){
		if([resource isEqual:@"wool"]){
			player.wool++;
		}else if([resource isEqual:@"grain"]){
			player.grain++;
		}else if([resource isEqual:@"brick"]){
			player.brick++;
		}else if([resource isEqual:@"ore"]){
			player.ore++;
		}else if([resource isEqual:@"lumber"]){
			player.lumber++;
		}
	}
}

- (void) waitForAnswer{
	
	self.game.phase = WAITING_ANSWER;
	
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
			
		case MSG_DICE:{
			
			for(HexagonNode * hex in self.game.table.hexes){
				if(hex!=self.game.table.thief)
					[hex giveResourceForDices:[data integerValue]];
			}
			
			SKLabelNode *diceLabel = (SKLabelNode*)[self.topMenu childNodeWithName:@"dice"];
			
			diceLabel.text = [NSString stringWithFormat:@"%d", [data integerValue]];
			
			break;
			
		}
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
				
				
				
				int roadsCount=4;
				int index=0;
				for(Player* player in self.game.players){
					if(player.largestRoad && player.roads>roadsCount){
						roadsCount = player.roads;
						index = [self.game.players indexOfObject:player];
						break;
					}
				}
				
				
				Player* aux;
				for(Player* player in self.game.players){
					if(player.roads>roadsCount){
						roadsCount = player.roads;
						aux= [self.game.players objectAtIndex:index];
						aux.largestRoad = NO;
						player.largestRoad=YES;
						index = [self.game.players indexOfObject:player];
					}
				}
				
				
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
					
					int roadsCount=4;
					int index=0;
					for(Player* player in self.game.players){
						if(player.largestRoad && player.roads>roadsCount){
							roadsCount = player.roads;
							index = [self.game.players indexOfObject:player];
							break;
						} else{
							player.largestRoad = NO;
						}
					}
					
					
					Player* aux;
					for(Player* player in self.game.players){
						if(player.roads>roadsCount){
							roadsCount = player.roads;
							aux= [self.game.players objectAtIndex:index];
							aux.largestRoad = NO;
							player.largestRoad=YES;
							index = [self.game.players indexOfObject:player];
							NSLog(@"LargestRoad!!!");
						}
					}
					
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
				if([resource isEqual:@"wool"]){
					changed.wool--;
				}else if([resource isEqual:@"grain"]){
					changed.grain--;
				}else if([resource isEqual:@"brick"]){
					changed.brick--;
				}else if([resource isEqual:@"ore"]){
					changed.ore--;
				}else if([resource isEqual:@"lumber"]){
					changed.lumber--;
				}else if([resource isEqual:@"all"]){
					changed.lumber = 0;
					changed.wool = 0;
					changed.brick = 0;
					changed.grain = 0;
					changed.ore = 0;
				}
				
			}
			
			for(NSString* resource in added){
				if([resource isEqual:@"wool"]){
					changed.wool++;
				}else if([resource isEqual:@"grain"]){
					changed.grain++;
				}else if([resource isEqual:@"brick"]){
					changed.brick++;
				}else if([resource isEqual:@"ore"]){
					changed.ore++;
				}else if([resource isEqual:@"lumber"]){
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
			
		case MSG_CARD_USED:{
			
			NSString *card = data;
			
			if([card isEqual:@"army"]){
				self.game.currentPlayer.army ++;
				
				int armyCount=2;
				int index=0;
				for(Player* player in self.game.players){
					if(player.largestArmy && player.army>armyCount){
						armyCount = player.army;
						index = [self.game.players indexOfObject:player];
						break;
					}
				}
				
				
				Player* aux;
				for(Player* player in self.game.players){
					if(player.army>armyCount){
						armyCount = player.army;
						aux= [self.game.players objectAtIndex:index];
						aux.largestArmy = NO;
						player.largestArmy=YES;
						index = [self.game.players indexOfObject:player];
					}
				}
				
			}
			
			
			break;
		}
			
		case MSG_WINNER:
			
			self.game.phase = LOSER;
			
			break;
			
		case MSG_OFFER:
			
			if([self isTradePossibleForPlayer:self.game.me withDemand:[(NSDictionary*)data objectForKey:@"demand"]])
				[self buildShowOfferForOffer:(NSDictionary*) data];
			else{
				NSDictionary * responseData = [NSDictionary dictionaryWithObject:@NO forKey:@"answer"];
				[self.plug sendMessage:MSG_RESPONSE_OFFER data:responseData];
			}
			
			break;
		case MSG_RESPONSE_OFFER:
			if([[data objectForKey:@"answer"] boolValue]){
				
				if(self.game.phase == WAITING_ANSWER){
					self.game.phase = RUNNING;
					
					Player * player = self.game.players[[[data objectForKey:@"player"] integerValue]];
					
					[self.playerTrader performTradeBetweenMeAndPlayer:player];
					[self.playerTrader dismissForResult:YES];
				}
				
			}else{
				self.playersAnswers++;
				if(self.playersAnswers == self.game.players.count-1){
					self.game.phase = RUNNING;
					[self.playerTrader dismissForResult:NO];
				}
			}
			
			break;
		default:
			
			break;
	}
	[self updateResources];
	
	
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

-(BOOL)isTradePossibleForPlayer: (Player*)player withDemand: (NSDictionary*) resources{
	
	int wool = [[resources valueForKey:@"wool"] integerValue];
	int lumber =[[resources valueForKey:@"lumber"] integerValue];
	int grain =[[resources valueForKey:@"grain"] integerValue];
	int ore =[[resources valueForKey:@"ore"] integerValue];
	int brick =[[resources valueForKey:@"brick"] integerValue];
	
		
	
	if(self.game.me.lumber >= lumber && self.game.me.wool >= wool && self.game.me.grain >= grain && self.game.me.ore >= ore && self.game.me.brick >= brick)
		return YES;
	
	return NO;
}

@end
