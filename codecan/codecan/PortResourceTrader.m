//
//  PortResourceTrader.m
//  codecan
//
//  Created by Felipe Fujioka on 01/11/13.
//  Copyright (c) 2013 Codeca. All rights reserved.
//

#import "PortResourceTrader.h"


@implementation PortResourceTrader

-(id)init{
	self = [super init];
	
	if(self){
		self.side = DEMANDSIDE;
		[self.myOffer removeAllChildren];
		
		for(int i = 0; i < 2; i++){
			SKSpriteNode * offerN = [[SKSpriteNode alloc] init];
			offerN.name = [NSString stringWithFormat:@"%d", i];
			offerN.position = CGPointMake(-self.myOffer.size.width/4+i*self.myOffer.size.width/2, 0);
			[self.myOffer addChild:offerN];
		}
		
		self.arrow.position = CGPointMake(self.myDemand.position.x, self.arrow.position.y);
			
	}
	return self;
}

-(void)setOfferTo:(BankSelection)selection{
	
	NSString * imageName;
	
	switch(selection){
		case BANKBRICK:
			imageName=@"brick";
			break;
		case BANKLUMBER:
			imageName=@"lumber";
			break;
		case BANKORE:
			imageName=@"ore";
			break;
		case BANKGRAIN:
			imageName=@"grain";
			break;
		case BANKWOOL:
			imageName=@"wool";
			break;
			
		default:
			break;
			
	}
	
	SKTexture * texture = [SKTexture textureWithImageNamed:imageName];
	
	for(SKSpriteNode * offer in self.myOffer.children){
		
		offer.texture = texture;
		offer.size = CGSizeMake(texture.size.width*0.1, texture.size.height*0.1);
		
	}
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

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
			
			if(self.side == DEMANDSIDE){
				self.selectionDemand = BANKLUMBER;
			}
			
		}else if([clicked.name isEqualToString:@"ore"]){
			
			
			
			if(self.side == DEMANDSIDE){
				self.selectionDemand = BANKORE;
			}
			
		}else if([clicked.name isEqualToString:@"grain"]){
			
			
			if(self.side == DEMANDSIDE){
				self.selectionDemand = BANKGRAIN;
			}
			
		}else if([clicked.name isEqualToString:@"wool"]){
			
			
			if(self.side == DEMANDSIDE){
				self.selectionDemand = BANKWOOL;
			}
			
		}else if([clicked.name isEqualToString:@"brick"]){
			
			
			if(self.side == DEMANDSIDE){
				self.selectionDemand = BANKBRICK;
			}
		}else if([clicked.name isEqualToString:@"trade"]){
			if(self.resource != 0 && self.selectionDemand != 0){
				
				
					
				if(self.resource == BANKBRICK){
					self.player.brick-=2;
				}else if(self.resource == BANKGRAIN){
					self.player.grain-=2;
				}else if(self.resource == BANKORE){
					self.player.ore-=2;
				}else if(self.resource == BANKWOOL){
					self.player.wool-=2;
				}else if(self.resource == BANKLUMBER){
					self.player.lumber-=2;
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
				
				self.grainQuantity.text = [NSString stringWithFormat:@"%d", self.player.grain];
				self.brickQuantity.text = [NSString stringWithFormat:@"%d", self.player.brick];
				self.oreQuantity.text = [NSString stringWithFormat:@"%d", self.player.ore];
				self.lumberQuantity.text = [NSString stringWithFormat:@"%d", self.player.lumber];
				self.woolQuantity.text = [NSString stringWithFormat:@"%d", self.player.wool];
				
			}
			
		}
		[self setDemandTo:self.selectionDemand];
		if([self.player numberOfResource:self.resource]<2){
			[self removeFromParent];
		}
		
	}

	
}

-(void) buildInterfaceForPlayer: (Player*) player andResource:(BankSelection) resource andScene:(SKScene*) scene{
	
	self.player = player;
	self.myScene = (MyScene*)scene;
	self.resource = resource;
	[scene addChild:self];
	[self setOfferTo:self.resource];
	
	self.grainQuantity.text = [NSString stringWithFormat:@"%d", self.player.grain];
	self.brickQuantity.text = [NSString stringWithFormat:@"%d", self.player.brick];
	self.oreQuantity.text = [NSString stringWithFormat:@"%d", self.player.ore];
	self.lumberQuantity.text = [NSString stringWithFormat:@"%d", self.player.lumber];
	self.woolQuantity.text = [NSString stringWithFormat:@"%d", self.player.wool];
}

@end
