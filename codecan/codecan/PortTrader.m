
//
//  PortTrader.m
//  codecan
//
//  Created by Felipe Fujioka on 30/10/13.
//  Copyright (c) 2013 Codeca. All rights reserved.
//

#import "PortTrader.h"

@interface PortTrader()

@property (nonatomic) NSInteger index;

@end

@implementation PortTrader

- (id)init{
	
	self = [super init];
	
	if(self){
		
		self.index = 0;
		
		[self.myOffer removeAllChildren];
		
		for(int i = 0; i < 3; i++){
			SKSpriteNode * offerN = [[SKSpriteNode alloc] init];
			offerN.name = [NSString stringWithFormat:@"%d", i];
			switch (i) {
				case 2:
					offerN.position = CGPointMake(0, -self.myOffer.size.height/4);
					break;
					
				default:
					offerN.position = CGPointMake(-self.myOffer.size.width/4+i*self.myOffer.size.width/2, self.myOffer.size.height/4);
					break;
			}
			[self.myOffer addChild:offerN];
		}
		
	}
	return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	
	for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
		SKNode* clicked = [self nodeAtPoint:location];
		
		if([clicked.name isEqualToString:@"myoffer"]){
			
			SKAction * moveToOffer = [SKAction moveTo:CGPointMake(self.myOffer.position.x, self.arrow.position.y) duration:0.2];
			[self.arrow runAction:moveToOffer];
			self.side = OFFERSIDE;
		}else if([clicked.name isEqualToString:@"mydemand"]){
			SKAction * moveToDemand = [SKAction moveTo:CGPointMake(self.myDemand.position.x, self.arrow.position.y) duration:0.2];
			[self.arrow runAction:moveToDemand];
			self.side = DEMANDSIDE;
		}else if([clicked.name isEqualToString:@"options"]){
			
		}else if([clicked.name isEqualToString:@"fader"]){
			[self removeFromParent];
		}else if([clicked.name isEqualToString:@"lumber"]){
			
			if(self.player.lumber > 0){
				if(self.side == OFFERSIDE){
					[self addResourceToOffer:BANKLUMBER];
				}
			}
			if(self.side == DEMANDSIDE){
				self.selectionDemand = BANKLUMBER;
			}
			
		}else if([clicked.name isEqualToString:@"ore"]){
			
			if(self.player.ore > [self totalOfOfferForResource:BANKORE]){
				if(self.side == OFFERSIDE){
					[self addResourceToOffer:BANKORE];
				}
			}
			if(self.side == DEMANDSIDE){
				self.selectionDemand = BANKORE;
			}
			
		}else if([clicked.name isEqualToString:@"grain"]){
			
			if(self.player.grain > [self totalOfOfferForResource:BANKGRAIN]){
				if(self.side == OFFERSIDE){
					[self addResourceToOffer:BANKGRAIN];
				}
			}
			if(self.side == DEMANDSIDE){
				self.selectionDemand = BANKGRAIN;
			}
			
		}else if([clicked.name isEqualToString:@"wool"]){
			
			if(self.player.wool > [self totalOfOfferForResource:BANKWOOL]){
				if(self.side == OFFERSIDE){
					[self addResourceToOffer:BANKWOOL];
				}
			}
			if(self.side == DEMANDSIDE){
				self.selectionDemand = BANKWOOL;
			}
			
		}else if([clicked.name isEqualToString:@"brick"]){
			
			if(self.player.brick > [self totalOfOfferForResource:BANKBRICK]){
				if(self.side == OFFERSIDE){
					[self addResourceToOffer:BANKBRICK];
				}
			}
			if(self.side == DEMANDSIDE){
				self.selectionDemand = BANKBRICK;
			}
		}else if([clicked.name isEqualToString:@"trade"]){
			if(self.offer.count == 3 && self.selectionDemand != 0){
				
				for(NSNumber * res in self.offer){
					
					self.selectionOffer = res.integerValue;
					
					if(self.selectionOffer == BANKBRICK){
						self.player.brick-=1;
					}else if(self.selectionOffer == BANKGRAIN){
						self.player.grain-=1;
					}else if(self.selectionOffer == BANKORE){
						self.player.ore-=1;
					}else if(self.selectionOffer == BANKWOOL){
						self.player.wool-=1;
					}else if(self.selectionOffer == BANKLUMBER){
						self.player.lumber-=1;
					}
				}
				
				for(int i = 0; i < self.offer.count; i++){
					self.offer[i] = [NSNumber numberWithInt:BANKBLANK];
				}
				
				if(self.selectionDemand == BANKBRICK){
					self.player.brick++;
				}else if(self.selectionDemand == BANKGRAIN){
					self.player.grain++;
				}else if(self.selectionDemand == BANKORE){
					self.player.ore++;
				}else if(self.selectionDemand == BANKWOOL){
					self.player.wool++;
				}else if(self.selectionDemand == BANKLUMBER){
					self.player.lumber++;
				}
			}
		}
		[self updateView];
		
	}
}

-(void) updateView{
	
	self.grainQuantity.text = [NSString stringWithFormat:@"%d", self.player.grain];
	self.brickQuantity.text = [NSString stringWithFormat:@"%d", self.player.brick];
	self.oreQuantity.text = [NSString stringWithFormat:@"%d", self.player.ore];
	self.lumberQuantity.text = [NSString stringWithFormat:@"%d", self.player.lumber];
	self.woolQuantity.text = [NSString stringWithFormat:@"%d", self.player.wool];
	
	for(int i = 0; i < self.offer.count;i++){
		NSInteger resource = [self.offer[i] integerValue];
		
		SKSpriteNode * currentResource = self.myOffer.children[i];
		
		switch (resource) {
			case BANKBRICK:
				currentResource.texture = [SKTexture textureWithImageNamed:@"brick"];
				break;
			case BANKGRAIN:
				currentResource.texture = [SKTexture textureWithImageNamed:@"grain"];
				break;
			case BANKLUMBER:
				currentResource.texture = [SKTexture textureWithImageNamed:@"lumber"];
				break;
			case BANKORE:
				currentResource.texture = [SKTexture textureWithImageNamed:@"ore"];
				break;
			case BANKWOOL:
				currentResource.texture = [SKTexture textureWithImageNamed:@"wool"];
				break;
			default:
				currentResource.texture = nil;
				break;
		}
		currentResource.size = CGSizeMake(currentResource.texture.size.width*0.1, currentResource.texture.size.height*0.1);
				
	}
	
	if(self.selectionDemand == BANKBRICK){
		[self setDemandTo:BANKBRICK];
	}else if(self.selectionDemand == BANKORE){
		[self setDemandTo:BANKORE];
	}else if(self.selectionDemand == BANKGRAIN){
		[self setDemandTo:BANKGRAIN];
	}else if(self.selectionDemand == BANKWOOL){
		[self setDemandTo:BANKWOOL];
	}else if(self.selectionDemand == BANKLUMBER){
		[self setDemandTo:BANKLUMBER];
	}else {
		[self setDemandTo:BANKBLANK];
	}

	
	
	
}

-(void)addResourceToOffer:(BankSelection)resource{

	if(!self.offer){
		self.offer = [[NSMutableArray alloc] init];
	}
	
	
	if(self.offer.count<3){
		[self.offer addObject:[NSNumber numberWithInt:resource]];
	}else{
		if(self.index==2){
			self.index = 0;
		}else{
			self.index++;
		}
		[self.offer replaceObjectAtIndex:self.index withObject:[NSNumber numberWithInt:resource]];
	}

}

-(void)portTraderForPlayer:(Player *)player andScene:(SKScene *)scene{
	
	self.player = player;
	[scene addChild:self];
	self.selectionOffer = BANKBLANK;
	self.selectionDemand = BANKBLANK;
	[self updateView];
	
}

-(NSInteger) totalOfOfferForResource:(BankSelection) resource{

	NSInteger count = 0;
	
	for(int i = 0; i < self.offer.count; i++){
		if([self.offer[i] integerValue] == resource){
			count++;
		}
	}
	return count;
	
}


@end
