//
//  CrystalTrader.m
//  codecan
//
//  Created by Felipe Fujioka on 10/12/13.
//  Copyright (c) 2013 Codeca. All rights reserved.
//

#import "CrystalTrader.h"

@implementation CrystalTrader

- (id)init{
	
	self = [super init];
	
	if(self){
	
		[self.myOffer removeAllChildren];
		
		SKSpriteNode * crystalImage = [SKSpriteNode spriteNodeWithImageNamed:@"crystal"];
		crystalImage.name = @"crystaloffer";
		crystalImage.xScale = 0.1;
		crystalImage.yScale = 0.1;
		
		[self.myOffer addChild:crystalImage];
		
		for (SKLabelNode * label in self.options.children) {
			if([label.name isEqualToString:@"lumberquantity"]){
				[label removeFromParent];
			}else if([label.name isEqualToString:@"woolquantity"]){
				[label removeFromParent];
			}else if([label.name isEqualToString:@"grainquantity"]){
				[label removeFromParent];
			}else if([label.name isEqualToString:@"brickquantity"]){
				[label removeFromParent];
			}else if([label.name isEqualToString:@"orequantity"]){
				[label removeFromParent];
			}
		}
	
		self.arrow.position = CGPointMake(self.myDemand.position.x, self.arrow.position.y);
	}
	return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{


	for(UITouch * touch in touches){
	
		CGPoint location = [touch locationInNode:self];
		
		SKNode* clicked = [self nodeAtPoint:location];
		
		if ([clicked.name isEqualToString:@"lumber"]) {
			[self setDemandTo:BANKLUMBER];
		}else if([clicked.name isEqualToString:@"brick"]){
			[self setDemandTo:BANKBRICK];
		}else if([clicked.name isEqualToString:@"grain"]){
			[self setDemandTo:BANKGRAIN];
		}else if([clicked.name isEqualToString:@"wool"]){
			[self setDemandTo:BANKWOOL];
		}else if([clicked.name isEqualToString:@"ore"]){
			[self setDemandTo:BANKORE];
		}else if([clicked.name isEqualToString:@"trade"]){
			self.player.crystal--;
			
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
}


@end
