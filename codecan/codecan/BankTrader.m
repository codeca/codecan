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
		
		self.myDemand = [SKSpriteNode spriteNodeWithColor:[SKColor whiteColor] size:CGSizeMake(self.back.size.width/3, self.back.size.height/4)];
		self.myDemand.position = CGPointMake(self.back.size.width*2/7, self.back.size.height/6);
		self.myDemand.name = @"mydemand";
		[self addChild:self.myDemand];
		
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
		}
		
	}
	
	
	
}

@end
