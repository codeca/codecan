//
//  PortTrader.m
//  codecan
//
//  Created by Felipe Fujioka on 30/10/13.
//  Copyright (c) 2013 Codeca. All rights reserved.
//

#import "PortTrader.h"

@implementation PortTrader

- (id)init{
	
	self = [super init];
	
	if(self){
		
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
			
			if(self.player.lumber >= 4){
				if(self.side == OFFERSIDE){
					self.selectionOffer = BANKLUMBER;
				}
			}
			if(self.side == DEMANDSIDE){
				self.selectionDemand = BANKLUMBER;
			}
			
		}else if([clicked.name isEqualToString:@"ore"]){
			
			if(self.player.ore >= 4){
				if(self.side == OFFERSIDE){
					self.selectionOffer = BANKORE;
				}
			}
			if(self.side == DEMANDSIDE){
				self.selectionDemand = BANKORE;
			}
			
		}else if([clicked.name isEqualToString:@"grain"]){
			
			if(self.player.grain >= 4){
				if(self.side == OFFERSIDE){
					self.selectionOffer = BANKGRAIN;
				}
			}
			if(self.side == DEMANDSIDE){
				self.selectionDemand = BANKGRAIN;
			}
			
		}else if([clicked.name isEqualToString:@"wool"]){
			
			if(self.player.wool >= 4){
				if(self.side == OFFERSIDE){
					self.selectionOffer = BANKWOOL;
				}
			}
			if(self.side == DEMANDSIDE){
				self.selectionDemand = BANKWOOL;
			}
			
		}else if([clicked.name isEqualToString:@"brick"]){
			
			if(self.player.brick >= 4){
				if(self.side == OFFERSIDE){
					self.selectionOffer = BANKBRICK;
				}
			}
			if(self.side == DEMANDSIDE){
				self.selectionDemand = BANKBRICK;
			}
		}else if([clicked.name isEqualToString:@"trade"]){
			if(self.selectionDemand != 0 && self.selectionOffer != 0){
				if(self.selectionOffer == BANKBRICK){
					self.player.brick-=3;
				}else if(self.selectionOffer == BANKGRAIN){
					self.player.grain-=3;
				}else if(self.selectionOffer == BANKORE){
					self.player.ore-=3;
				}else if(self.selectionOffer == BANKWOOL){
					self.player.wool-=3;
				}else if(self.selectionOffer == BANKLUMBER){
					self.player.lumber-=3;
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
				[self updateView];
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
	
	if(self.selectionOffer == BANKBRICK && self.player.brick < 3){
		[self setOfferTo:BANKBLANK];
	}else if(self.selectionOffer == BANKORE && self.player.ore < 3){
		[self setOfferTo:BANKBLANK];
	}else if(self.selectionOffer == BANKGRAIN && self.player.grain < 3){
		[self setOfferTo:BANKBLANK];
	}else if(self.selectionOffer == BANKWOOL && self.player.wool < 3){
		[self setOfferTo:BANKBLANK];
	}else if(self.selectionOffer == BANKLUMBER && self.player.lumber < 3){
		[self setOfferTo:BANKBLANK];
	}
	
}

-(void)portTraderForPlayer:(Player *)player andScene:(SKScene *)scene{
	
	self.player = player;
	[scene addChild:self];
	[self updateView];
	
}


@end
