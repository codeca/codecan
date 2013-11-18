//
//  PlayerTrader.m
//  codecan
//
//  Created by Felipe Fujioka on 07/11/13.
//  Copyright (c) 2013 Codeca. All rights reserved.
//

#import "PlayerTrader.h"
#import "MyScene.h"

@interface PlayerTrader()

@property (nonatomic, strong) NSArray * resources;

@end

@implementation PlayerTrader

- (id)init{
	
	self = [super init];
	
	if(self){
	
		[self.myOffer removeAllChildren];
		
		self.myOffer.position =CGPointMake(0, self.back.size.height/4);
		self.myOffer.size = CGSizeMake(self.back.size.width*0.8, self.options.size.height);
		
		self.myDemand.position = CGPointMake(0, -self.back.size.height/4);
		self.myDemand.size = self.myOffer.size;
		
		self.tradeButton.position = CGPointMake(-self.back.size.width/4, 0);
		
		self.clearButton = self.tradeButton.copy;
		self.clearButton.name = @"clear";
		self.clearButton.text = @"Clear";
		self.clearButton.position = CGPointMake(self.back.size.width/4, 0);
		[self.back addChild:self.clearButton];
		
		SKLabelNode * offerLabel = (SKLabelNode*)[self.back childNodeWithName:@"offerlabel"];
		offerLabel.position = CGPointMake(0, offerLabel.position.y);
		
		SKLabelNode * demandLabel = (SKLabelNode*)[self.back childNodeWithName:@"demandlabel"];
		demandLabel.position = CGPointMake(0, self.myDemand.position.y+self.myDemand.size.height/2);
		
		self.blockScreen = self.fader.copy;
		self.blockScreen.name = @"block";
		self.blockScreen.zPosition = 20;
		self.blockScreen.alpha = 0.8;
		
		SKLabelNode * waitingLabel = [SKLabelNode labelNodeWithFontNamed:@"ChalkDuster"];
		waitingLabel.fontColor = [SKColor whiteColor];
		waitingLabel.fontSize = 40;
		waitingLabel.text = @"Waiting answer";
		waitingLabel.name = @"waitinglabel";
		[self.blockScreen addChild:waitingLabel];
		
		self.arrow.zRotation = M_PI/2;
		self.arrow.position = CGPointMake(self.myOffer.position.x-self.myOffer.size.width/2-self.arrow.size.width/2, self.myOffer.position.y);
		
		for(SKSpriteNode * resource in self.options.children){
			if(resource.class != SKSpriteNode.class)
				continue;
			[self.myDemand addChild:resource.copy];
			[self.myOffer addChild:resource.copy];
		}
		
		for(SKLabelNode * quantity in self.options.children){
			if(quantity.class != SKLabelNode.class)
				continue;
			SKLabelNode * demandQuantity = quantity.copy;
			SKLabelNode * offerQuantity = quantity.copy;
		
			
			offerQuantity.name = [NSString stringWithFormat:@"%@%@", offerQuantity.name, @"offer"];
			demandQuantity.name = [NSString stringWithFormat:@"%@%@", demandQuantity.name, @"demand"];
			
			[self.myDemand addChild:demandQuantity];
			[self.myOffer addChild:offerQuantity];
		}
		
		self.resources = @[@"brick", @"wool", @"ore", @"grain", @"lumber"];
		[self.options removeFromParent];
		self.options = nil;
	}
	
	return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

	for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
		SKNode* clicked = [self nodeAtPoint:location];
		
		if([clicked.parent.name isEqualToString:@"myoffer"] || [clicked.name isEqualToString:@"myoffer"]){
			
			SKAction * moveToOffer = [SKAction moveTo:CGPointMake(self.arrow.position.x, self.myOffer.position.y) duration:0.2];
			[self.arrow runAction:moveToOffer];
			self.side = OFFERSIDE;
		}else if([clicked.name isEqualToString:@"mydemand"] || [clicked.parent.name isEqualToString:@"mydemand"]){
			
			SKAction * moveToDemand = [SKAction moveTo:CGPointMake(self.arrow.position.x, self.myDemand.position.y) duration:0.2];
			[self.arrow runAction:moveToDemand];
			self.side = DEMANDSIDE;
		}else if([clicked.name isEqualToString:@"options"]){
			
		}else if([clicked.name isEqualToString:@"fader"]){
			[self removeFromParent];
		}
		
		if([clicked.name isEqualToString:@"lumber"]){
			
			
			if(self.player.lumber > [self totalOfOfferForResource:BANKLUMBER]){
				if(self.side == OFFERSIDE){
					[self addResourceToOffer:BANKLUMBER];
				}
			}
			if(self.side == DEMANDSIDE){
				[self addResourceToDemand:BANKLUMBER];
			}
			
		}else if([clicked.name isEqualToString:@"ore"]){
			
			if(self.player.ore > [self totalOfOfferForResource:BANKORE]){
				if(self.side == OFFERSIDE){
					[self addResourceToOffer:BANKORE];
				}
			}
			if(self.side == DEMANDSIDE){
				[self addResourceToDemand:BANKORE];
			}
			
		}else if([clicked.name isEqualToString:@"grain"]){
			
			if(self.player.grain > [self totalOfOfferForResource:BANKGRAIN]){
				if(self.side == OFFERSIDE){
					[self addResourceToOffer:BANKGRAIN];
				}
			}
			if(self.side == DEMANDSIDE){
				[self addResourceToDemand:BANKGRAIN];
			}
			
		}else if([clicked.name isEqualToString:@"wool"]){
			
			if(self.player.wool > [self totalOfOfferForResource:BANKWOOL]){
				if(self.side == OFFERSIDE){
					[self addResourceToOffer:BANKWOOL];
				}
			}
			if(self.side == DEMANDSIDE){
				[self addResourceToDemand:BANKWOOL];
			}
			
		}else if([clicked.name isEqualToString:@"brick"]){
			
			if(self.player.brick > [self totalOfOfferForResource:BANKBRICK]){
				if(self.side == OFFERSIDE){
					[self addResourceToOffer:BANKBRICK];
				}
			}
			if(self.side == DEMANDSIDE){
				[self addResourceToDemand:BANKBRICK];
			}
		}else if([clicked.name isEqualToString:@"trade"]){
			if([self resourcesInDemand]>0 && [self resourcesInOffer]>0){
				
				SKLabelNode * label = (SKLabelNode*)[self.blockScreen childNodeWithName:@"waitinglabel"];
				label.text = @"Waiting answer";
				
				[self addChild:self.blockScreen];
				[self.myScene waitForAnswer];
				
				NSDictionary * data = [NSDictionary dictionaryWithObjects:@[self.offerdic, self.demand] forKeys:@[@"offer", @"demand"]];
				
				[self.myScene.plug sendMessage:MSG_OFFER data:data];
				
			}
		}else if([clicked.name isEqualToString:@"clear"]){
			self.offerdic = [NSMutableDictionary dictionaryWithObjects:@[@0,@0,@0,@0,@0] forKeys:@[@"lumber", @"brick", @"wool", @"grain", @"ore"]];
			self.demand = [NSMutableDictionary dictionaryWithObjects:@[@0,@0,@0,@0,@0] forKeys:@[@"lumber", @"brick", @"wool", @"grain", @"ore"]];
		}
		[self updateView];
		
	}

	
}

-(void) updateView{

	for(SKLabelNode * label in self.myOffer.children){
		if([label.name isEqualToString:@"woolquantityoffer"]){
			label.text = [NSString stringWithFormat:@"%d/%d", [[self.offerdic objectForKey:@"wool"] integerValue], self.player.wool];
		}else if([label.name isEqualToString:@"grainquantityoffer"]){
			label.text = [NSString stringWithFormat:@"%d/%d", [[self.offerdic objectForKey:@"grain"] integerValue], self.player.grain];
		}else if([label.name isEqualToString:@"brickquantityoffer"]){
			label.text = [NSString stringWithFormat:@"%d/%d", [[self.offerdic objectForKey:@"brick"] integerValue], self.player.brick];
		}else if([label.name isEqualToString:@"orequantityoffer"]){
			label.text = [NSString stringWithFormat:@"%d/%d", [[self.offerdic objectForKey:@"ore"] integerValue], self.player.ore];
		}else if([label.name isEqualToString:@"lumberquantityoffer"]){
			label.text = [NSString stringWithFormat:@"%d/%d", [[self.offerdic objectForKey:@"lumber"] integerValue], self.player.lumber];
		}
	}
	
	for(SKLabelNode * label in self.myDemand.children){
		if([label.name isEqualToString:@"woolquantitydemand"]){
			label.text = [NSString stringWithFormat:@"%d", [[self.demand objectForKey:@"wool"] integerValue]];
		}else if([label.name isEqualToString:@"grainquantitydemand"]){
			label.text = [NSString stringWithFormat:@"%d", [[self.demand objectForKey:@"grain"] integerValue]];
		}else if([label.name isEqualToString:@"brickquantitydemand"]){
			label.text = [NSString stringWithFormat:@"%d", [[self.demand objectForKey:@"brick"] integerValue]];
		}else if([label.name isEqualToString:@"orequantitydemand"]){
			label.text = [NSString stringWithFormat:@"%d", [[self.demand objectForKey:@"ore"] integerValue]];
		}else if([label.name isEqualToString:@"lumberquantitydemand"]){
			label.text = [NSString stringWithFormat:@"%d", [[self.demand objectForKey:@"lumber"] integerValue]];
		}
	}
	
}

- (void)addResourceToOffer:(BankSelection)resource{
	[self.offerdic setObject:[NSNumber numberWithInt:[[self.offerdic objectForKey:self.resources[resource-1]] integerValue]+1] forKey:self.resources[resource-1]];
}

- (void) addResourceToDemand:(BankSelection)resource{
	[self.demand setObject:[NSNumber numberWithInt:[[self.demand objectForKey:self.resources[resource-1]] integerValue]+1] forKey:self.resources[resource-1]];
	
}

- (void) playerTraderForPlayer:(Player*) player andScene:(MyScene*) scene{
	
	self.player = player;
	self.myScene = scene;
	self.offerdic = [NSMutableDictionary dictionaryWithObjects:@[@0,@0,@0,@0,@0] forKeys:@[@"lumber", @"brick", @"wool", @"grain", @"ore"]];
	self.demand = [NSMutableDictionary dictionaryWithObjects:@[@0,@0,@0,@0,@0] forKeys:@[@"lumber", @"brick", @"wool", @"grain", @"ore"]];
	[self.blockScreen removeFromParent];
	
	[self.myScene addChild:self];
	[self updateView];
	
}

-(NSInteger) totalOfOfferForResource:(BankSelection) resource{
	
	return [[self.offerdic objectForKey:self.resources[resource-1]] integerValue];
	
}

-(NSInteger) resourcesInOffer{
	
	NSInteger count = 0;
	
	for(NSNumber* resource in self.offerdic.allValues){
		count+=[resource integerValue];
	}
	
	return count;
}

-(NSInteger) resourcesInDemand{
	NSInteger count = 0;
	
	for(NSNumber* resource in self.demand.allValues){
		count+=[resource integerValue];
	}
	
	return count;
}

- (void) performTradeBetweenMeAndPlayer:(Player*) player{
	
	NSMutableArray * earned = [[NSMutableArray alloc] init];
	NSMutableArray * given = [[NSMutableArray alloc] init];
	
	for(NSString * resource in self.offerdic.allKeys){
		NSInteger quantity = [[self.offerdic objectForKey:resource] integerValue];
		
		for(int i = 0; i<quantity; i++){
			[given addObject:resource.copy];
		}
	}
	
	for(NSString * resource in self.demand.allKeys){
		NSInteger quantity = [[self.demand objectForKey:resource] integerValue];
		
		for(int i = 0; i<quantity; i++){
			[earned addObject:resource.copy];
		}
	}
	
	[self.myScene broadcastResourcesChangeForPlayer:self.player add:earned remove:given];
	[self.myScene updateResourcesForPLayer:self.player add:earned andRemove:given];
	
	[self.myScene broadcastResourcesChangeForPlayer:player add:given remove:earned];
	[self.myScene updateResourcesForPLayer:player add:earned andRemove:given];
	
}

-(NSInteger) offerForResource:(BankSelection) resource{
	
	switch (resource) {
		case BANKBRICK:
			return [[self.offerdic objectForKey:@"brick"] integerValue];
			break;
		case BANKLUMBER:
			return [[self.offerdic objectForKey:@"lumber"] integerValue];
			break;
		case BANKGRAIN:
			return [[self.offerdic objectForKey:@"grain"] integerValue];
			break;
		case BANKWOOL:
			return [[self.offerdic objectForKey:@"wool"] integerValue];
			break;
		case BANKORE:
			return [[self.offerdic objectForKey:@"ore"] integerValue];
			break;
			
		default:
			break;
	}
	
	return 0;
}


-(NSInteger) demandForResource:(BankSelection) resource{
	
	switch (resource) {
		case BANKBRICK:
			return [[self.demand objectForKey:@"brick"] integerValue];
			break;
		case BANKLUMBER:
			return [[self.demand objectForKey:@"lumber"] integerValue];
			break;
		case BANKGRAIN:
			return [[self.demand objectForKey:@"grain"] integerValue];
			break;
		case BANKWOOL:
			return [[self.demand objectForKey:@"wool"] integerValue];
			break;
		case BANKORE:
			return [[self.demand objectForKey:@"ore"] integerValue];
			break;
			
		default:
			break;
	}
	
	return 0;
}

-(void) dismissDelayed{
	
	[self removeFromParent];
	
}

- (void) dismissForResult:(BOOL) result{
	SKLabelNode * label = (SKLabelNode*)[self.blockScreen childNodeWithName:@"waitinglabel"];
	
	if(result){
		
		label.text = @"Accepted";
		label.fontColor = [SKColor greenColor];
		[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(dismissDelayed) userInfo:nil repeats:NO];
		
	}else{
		label.text = @"Declined";
		label.fontColor = [SKColor redColor];
		[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(dismissDelayed) userInfo:nil repeats:NO];
	}
}

@end
