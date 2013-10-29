//
//  BankTrader.m
//  codecan
//
//  Created by Jun Fujioka on 27/10/13.
//  Copyright (c) 2013 Codeca. All rights reserved.
//

#import "BankTrader.h"

@implementation BankTrader



- (id)init{

	self = [super init];
	
	if(self){
		
		self.userInteractionEnabled = YES;
		
		self.zPosition = 10;
		
		self.fader = [SKSpriteNode spriteNodeWithColor:[SKColor grayColor] size:[[UIScreen mainScreen] bounds].size];
		self.fader.alpha = 0.5;
		self.fader.name = @"fader";
		[self addChild:self.fader];
		
		self.back = [SKSpriteNode spriteNodeWithColor:[SKColor grayColor] size:CGSizeMake(550, 500)];
		[self addChild:self.back];
		
		self.myOffer = [SKSpriteNode spriteNodeWithColor:[SKColor whiteColor] size:CGSizeMake(self.back.size.width/3, self.back.size.height/4)];
		self.myOffer.position = CGPointMake(-self.back.size.width*2/7, self.back.size.height/6);
		self.myOffer.name = @"myoffer";
		[self addChild:self.myOffer];
		
		for(int i = 0; i < 2; i++){
			for(int j = 0; j < 2; j++){
				SKSpriteNode * offerN = [[SKSpriteNode alloc] init];
				offerN.position = CGPointMake(i*self.myOffer.size.width-self.myOffer.size.width/2, j*self.myOffer.size.height-self.myOffer.size.height/2);
				[self.myOffer addChild:offerN];
			}
		}
		
		self.myDemand = [SKSpriteNode spriteNodeWithColor:[SKColor whiteColor] size:CGSizeMake(self.back.size.width/3, self.back.size.height/4)];
		self.myDemand.position = CGPointMake(self.back.size.width*2/7, self.back.size.height/6);
		self.myDemand.name = @"mydemand";
		[self addChild:self.myDemand];
		
		SKSpriteNode * offerN = [[SKSpriteNode alloc] init];
		[self.myDemand addChild:offerN];
		
		self.options = [SKSpriteNode spriteNodeWithColor:[SKColor whiteColor] size:CGSizeMake(self.back.size.width*4/5, self.back.size.height/4)];
		self.options.position = CGPointMake(0, -self.back.size.height/6);
		self.options.name = @"options";
		[self addChild:self.options];
		
		self.arrow = [SKSpriteNode spriteNodeWithImageNamed:@"arrow"];
		self.arrow.xScale = 0.02;
		self.arrow.yScale = 0.02;
		self.arrow.position = CGPointMake(self.myOffer.position.x, self.myDemand.position.y+self.myDemand.size.height/2+self.arrow.size.height/2);
		[self addChild:self.arrow];
		
		self.lumberImage = [SKSpriteNode spriteNodeWithImageNamed:@"lumber"];
		self.lumberImage.xScale = 0.1;
		self.lumberImage.yScale = 0.1;
		self.lumberImage.name = @"lumber";
		self.lumberImage.position = CGPointMake(-self.options.size.width*2/6, 0);
		[self.options addChild:self.lumberImage];
		
		self.oreImage = [SKSpriteNode spriteNodeWithImageNamed:@"ore"];
		self.oreImage.xScale = 0.1;
		self.oreImage.yScale = 0.1;
		self.oreImage.name = @"ore";
		self.oreImage.position = CGPointMake(-self.options.size.width/6, 0);
		[self.options addChild:self.oreImage];
		
		self.brickImage = [SKSpriteNode spriteNodeWithImageNamed:@"brick"];
		self.brickImage.xScale = 0.1;
		self.brickImage.yScale = 0.1;
		self.brickImage.name = @"brick";
		self.brickImage.position = CGPointMake(0, 0);
		[self.options addChild:self.brickImage];
		
		self.grainImage = [SKSpriteNode spriteNodeWithImageNamed:@"grain"];
		self.grainImage.xScale = 0.1;
		self.grainImage.yScale = 0.1;
		self.grainImage.name = @"grain";
		self.grainImage.position = CGPointMake(self.options.size.width/6, 0);
		[self.options addChild:self.grainImage];
		
		self.woolImage = [SKSpriteNode spriteNodeWithImageNamed:@"wool"];
		self.woolImage.xScale = 0.1;
		self.woolImage.yScale = 0.1;
		self.woolImage.name = @"wool";
		self.woolImage.position = CGPointMake(self.options.size.width*2/6, 0);
		[self.options addChild:self.woolImage];
		
		self.woolQuantity = [SKLabelNode labelNodeWithFontNamed:@"ChalkDuster"];
		self.woolQuantity.name = @"woolquantity";
		self.woolQuantity.color = [SKColor blackColor];
		self.woolQuantity.position = CGPointMake(self.options.size.width*2/6, -20);
		[self.options addChild:self.woolQuantity];
		
		self.brickQuantity = [SKLabelNode labelNodeWithFontNamed:@"ChalkDuster"];
		self.brickQuantity.name = @"woolquantity";
		self.brickQuantity.color = [SKColor blackColor];
		self.brickQuantity.position = CGPointMake(0, -20);
		[self.options addChild:self.brickQuantity];
		
		self.lumberQuantity = [SKLabelNode labelNodeWithFontNamed:@"ChalkDuster"];
		self.lumberQuantity.name = @"woolquantity";
		self.lumberQuantity.color = [SKColor blackColor];
		self.lumberQuantity.position = CGPointMake(-self.options.size.width*2/6, -20);
		[self.options addChild:self.lumberQuantity];
		
		self.oreQuantity = [SKLabelNode labelNodeWithFontNamed:@"ChalkDuster"];
		self.oreQuantity.name = @"woolquantity";
		self.oreQuantity.color = [SKColor blackColor];
		self.oreQuantity.position = CGPointMake(-self.options.size.width/6, -20);
		[self.options addChild:self.oreQuantity];
		
		self.grainQuantity = [SKLabelNode labelNodeWithFontNamed:@"ChalkDuster"];
		self.grainQuantity.name = @"woolquantity";
		self.grainImage.color = [SKColor blackColor];
		self.grainQuantity.position = CGPointMake(self.options.size.width/6, -20);
		[self.options addChild:self.grainQuantity];
		
		self.tradeButton = [SKLabelNode labelNodeWithFontNamed:@"ChalkDuster"];
		self.tradeButton.name = @"trade";
		self.tradeButton.fontSize = 30;
		self.tradeButton.color = [SKColor blackColor];
		self.tradeButton.text = @"Trade";
		self.tradeButton.position = CGPointMake(0, -40);
		[self addChild:self.tradeButton];
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
					self.player.brick-=4;
				}else if(self.selectionOffer == BANKGRAIN){
					self.player.grain-=4;
				}else if(self.selectionOffer == BANKORE){
					self.player.ore-=4;
				}else if(self.selectionOffer == BANKWOOL){
					self.player.wool-=4;
				}else if(self.selectionOffer == BANKLUMBER){
					self.player.lumber-=4;
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
		
		
	}
}

-(void) updateView{
	
	self.grainQuantity.text = [NSString stringWithFormat:@"%d", self.player.grain];
	self.brickQuantity.text = [NSString stringWithFormat:@"%d", self.player.brick];
	self.oreQuantity.text = [NSString stringWithFormat:@"%d", self.player.ore];
	self.lumberQuantity.text = [NSString stringWithFormat:@"%d", self.player.lumber];
	self.woolQuantity.text = [NSString stringWithFormat:@"%d", self.player.wool];
	
	if(self.selectionOffer == BANKBRICK && self.player.brick < 4){
		[self setOfferTo:BANKBRICK];
	}else if(self.selectionOffer == BANKORE && self.player.ore < 4){
		[self setOfferTo:BANKORE];
	}else if(self.selectionOffer == BANKGRAIN && self.player.grain < 4){
		[self setOfferTo:BANKGRAIN];
	}else if(self.selectionOffer == BANKWOOL && self.player.wool < 4){
		[self setOfferTo:BANKWOOL];
	}else if(self.selectionOffer == BANKLUMBER && self.player.lumber < 4){
		[self setOfferTo:BANKLUMBER];
	}

}

-(void) setOfferTo:(BankSelection) selection{
	for(SKSpriteNode * child in self.myOffer.children){
		if(selection == BANKBRICK){
			child.texture = [SKTexture textureWithImageNamed:@"brick"];
			child.size = child.texture.size;
			child.xScale = 0.1;
			child.yScale = 0.1;
		}else if(selection == BANKORE){
			child.texture = [SKTexture textureWithImageNamed:@"ore"];
			child.size = child.texture.size;
			child.xScale = 0.1;
			child.yScale = 0.1;
		}else if(selection == BANKWOOL){
			child.texture = [SKTexture textureWithImageNamed:@"wool"];
			child.size = child.texture.size;
			child.xScale = 0.1;
			child.yScale = 0.1;
		}else if(selection == BANKGRAIN){
			child.texture = [SKTexture textureWithImageNamed:@"grain"];
			child.size = child.texture.size;
			child.xScale = 0.1;
			child.yScale = 0.1;
		}else if(selection == BANKLUMBER){
			child.texture = [SKTexture textureWithImageNamed:@"lumber"];
			child.size = child.texture.size;
			child.xScale = 0.1;
			child.yScale = 0.1;
		}
	}
}

-(void)bankTraderForPlayer:(Player *)player andScene:(SKScene *)scene{

	self.player = player;
	[scene addChild:self];
	
}



@end
