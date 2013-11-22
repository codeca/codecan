//
//  ShowOfferScreen.m
//  codecan
//
//  Created by Felipe Fujioka on 07/11/13.
//  Copyright (c) 2013 Codeca. All rights reserved.
//

#import "ShowOfferScreen.h"
#import "BankTrader.h"
#import "MyScene.h"



@interface ShowOfferScreen()

@property (nonatomic, strong) NSArray * resources;

@end


@implementation ShowOfferScreen

-(id)init{
	self = [super init];
	
	if(self){
	
		self.userInteractionEnabled = YES;
		
		self.zPosition = 10;
		
		
		self.fader = [SKSpriteNode spriteNodeWithColor:[SKColor grayColor] size:[[UIScreen mainScreen] bounds].size];
		self.fader.alpha = 0.5;
		self.fader.name = @"fader";
		[self addChild:self.fader];
		
		self.back = [SKSpriteNode spriteNodeWithImageNamed:@"bg_bank"];
		[self addChild:self.back];
		
		self.theOffer = [SKSpriteNode spriteNodeWithColor:[SKColor whiteColor] size:CGSizeMake(self.back.size.width*0.8, self.back.size.height/4)];
		self.theOffer.position = CGPointMake(0, self.back.size.height/4);
		self.theOffer.name = @"offer";
		[self addChild:self.theOffer];
		
		
		self.theDemand = [SKSpriteNode spriteNodeWithColor:[SKColor whiteColor] size:CGSizeMake(self.back.size.width*0.8, self.back.size.height/4)];
		self.theDemand.position = CGPointMake(0, -self.back.size.height/4);
		self.theDemand.name = @"demand";
		[self addChild:self.theDemand];
		
		self.lumberImage = [SKSpriteNode spriteNodeWithImageNamed:@"lumber"];
		self.lumberImage.xScale = 0.1;
		self.lumberImage.yScale = 0.1;
		self.lumberImage.name = @"lumber";
		self.lumberImage.position = CGPointMake(-self.theOffer.size.width*2/6, 0);
		[self.theOffer addChild:self.lumberImage];
		
		self.oreImage = [SKSpriteNode spriteNodeWithImageNamed:@"ore"];
		self.oreImage.xScale = 0.1;
		self.oreImage.yScale = 0.1;
		self.oreImage.name = @"ore";
		self.oreImage.position = CGPointMake(-self.theOffer.size.width/6, 0);
		[self.theOffer addChild:self.oreImage];
		
		self.brickImage = [SKSpriteNode spriteNodeWithImageNamed:@"brick"];
		self.brickImage.xScale = 0.1;
		self.brickImage.yScale = 0.1;
		self.brickImage.name = @"brick";
		self.brickImage.position = CGPointMake(0, 0);
		[self.theOffer addChild:self.brickImage];
		
		self.grainImage = [SKSpriteNode spriteNodeWithImageNamed:@"grain"];
		self.grainImage.xScale = 0.1;
		self.grainImage.yScale = 0.1;
		self.grainImage.name = @"grain";
		self.grainImage.position = CGPointMake(self.theOffer.size.width/6, 0);
		[self.theOffer addChild:self.grainImage];
		
		self.woolImage = [SKSpriteNode spriteNodeWithImageNamed:@"wool"];
		self.woolImage.xScale = 0.1;
		self.woolImage.yScale = 0.1;
		self.woolImage.name = @"wool";
		self.woolImage.position = CGPointMake(self.theOffer.size.width*2/6, 0);
		[self.theOffer addChild:self.woolImage];
		
		self.woolQuantity = [SKLabelNode labelNodeWithFontNamed:@"ChalkDuster"];
		self.woolQuantity.name = @"woolquantity";
		self.woolQuantity.fontColor = [SKColor blackColor];
		self.woolQuantity.position = CGPointMake(self.theOffer.size.width*2/6, -40);
		[self.theOffer addChild:self.woolQuantity];
		
		self.brickQuantity = [SKLabelNode labelNodeWithFontNamed:@"ChalkDuster"];
		self.brickQuantity.name = @"brickquantity";
		self.brickQuantity.fontColor = [SKColor blackColor];
		self.brickQuantity.position = CGPointMake(0, -40);
		[self.theOffer addChild:self.brickQuantity];
		
		self.lumberQuantity = [SKLabelNode labelNodeWithFontNamed:@"ChalkDuster"];
		self.lumberQuantity.name = @"lumberquantity";
		self.lumberQuantity.fontColor = [SKColor blackColor];
		self.lumberQuantity.position = CGPointMake(-self.theOffer.size.width*2/6, -40);
		[self.theOffer addChild:self.lumberQuantity];
		
		self.oreQuantity = [SKLabelNode labelNodeWithFontNamed:@"ChalkDuster"];
		self.oreQuantity.name = @"orequantity";
		self.oreQuantity.fontColor = [SKColor blackColor];
		self.oreQuantity.position = CGPointMake(-self.theOffer.size.width/6, -40);
		[self.theOffer addChild:self.oreQuantity];
		
		self.grainQuantity = [SKLabelNode labelNodeWithFontNamed:@"ChalkDuster"];
		self.grainQuantity.name = @"grainquantity";
		self.grainQuantity.fontColor = [SKColor blackColor];
		self.grainQuantity.position = CGPointMake(self.theOffer.size.width/6, -40);
		[self.theOffer addChild:self.grainQuantity];
		
		self.acceptButton = [SKLabelNode labelNodeWithFontNamed:@"ChalkDuster"];
		self.acceptButton.name = @"accept";
		self.acceptButton.fontSize = 30;
		self.acceptButton.fontColor = [SKColor greenColor];
		self.acceptButton.text = @"Accept";
		self.acceptButton.position = CGPointMake(-self.back.size.width/4, -10);
		[self addChild:self.acceptButton];
		
		self.declineButton = [SKLabelNode labelNodeWithFontNamed:@"ChalkDuster"];
		self.declineButton.name = @"decline";
		self.declineButton.fontSize = 30;
		self.declineButton.fontColor = [SKColor redColor];
		self.declineButton.text = @"Decline";
		self.declineButton.position = CGPointMake(self.back.size.width/4, -10);
		[self addChild:self.declineButton];
		
		SKLabelNode * offerLabel = [SKLabelNode labelNodeWithFontNamed:@"ChalkDuster"];
		offerLabel.name = @"offerlabel";
		offerLabel.fontSize = 30;
		offerLabel.fontColor = [SKColor blackColor];
		offerLabel.text = @"Offer";
		offerLabel.position = CGPointMake(0, self.theOffer.position.y+self.theOffer.size.height/2);
		[self addChild:offerLabel];
		
		SKLabelNode * demandLabel = [SKLabelNode labelNodeWithFontNamed:@"ChalkDuster"];
		demandLabel.name = @"demandlabel";
		demandLabel.fontSize = 30;
		demandLabel.fontColor = [SKColor blackColor];
		demandLabel.text = @"Demand";
		demandLabel.position = CGPointMake(0, self.theDemand.position.y+self.theDemand.size.height/2);
		[self addChild:demandLabel];
		
		for(SKSpriteNode * resources in self.theOffer.children){
			if(resources.class != SKSpriteNode.class)
				continue;
			SKSpriteNode * demandCopy = resources.copy;
			demandCopy.name = [NSString stringWithFormat:@"%@%@", demandCopy.name,@"demand"];
			[self.theDemand addChild:demandCopy];
		}
		
		for(SKLabelNode * quantity in self.theOffer.children){
			if(quantity.class != SKLabelNode.class)
				continue;
			SKLabelNode * demandCopy = quantity.copy;
			demandCopy.name = [NSString stringWithFormat:@"%@%@", demandCopy.name,@"demand"];
			[self.theDemand addChild:demandCopy];
		}
		
		self.resources = @[@"brick", @"wool", @"ore", @"grain", @"lumber"];
		
	}
	return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

	for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
		SKNode* clicked = [self nodeAtPoint:location];
		
		if([clicked.name isEqualToString:@"accept"]){
			
			NSDictionary * answer = [NSDictionary dictionaryWithObjects:@[@(YES), @([self.myScene.game.players indexOfObject:self.player])] forKeys:@[@"answer", @"player"]];
			
			[self.myScene.plug sendMessage:MSG_RESPONSE_OFFER data:answer];
			[self removeFromParent];
			
		}else if([clicked.name isEqualToString:@"decline"]){
			NSDictionary * answer = [NSDictionary dictionaryWithObjects:@[@(NO)] forKeys:@[@"answer"]];
			
			[self.myScene.plug sendMessage:MSG_RESPONSE_OFFER data:answer];
			[self removeFromParent];
		}
		
	}

	
}



-(void) showOfferScreenForData:(NSDictionary*) data andScene:(MyScene *)scene andPlayer:(Player*) player{

	self.myScene = scene;
	self.player = player;
	
	NSDictionary * offer = [data objectForKey:@"offer"];
	NSDictionary * demand = [data objectForKey:@"demand"];
	
	NSInteger offerq = 0;
	NSInteger demandq = 0;
	
	for(int i = 1; i <=5; i++){
		if(i == BANKBRICK){
			offerq = [[offer objectForKey:@"brick"] integerValue];
			demandq = [[demand objectForKey:@"brick"] integerValue];
			self.brickQuantity.text = [NSString stringWithFormat:@"%d", offerq];
			SKLabelNode * demandLabel = (SKLabelNode*)[self.theDemand childNodeWithName:@"brickquantitydemand"];
			demandLabel.text = [NSString stringWithFormat:@"%d", demandq];
		}else if(i == BANKLUMBER){
			offerq = [[offer objectForKey:@"lumber"] integerValue];
			demandq = [[demand objectForKey:@"lumber"] integerValue];
			self.lumberQuantity.text = [NSString stringWithFormat:@"%d", offerq];
			SKLabelNode * demandLabel = (SKLabelNode*)[self.theDemand childNodeWithName:@"lumberquantitydemand"];
			demandLabel.text = [NSString stringWithFormat:@"%d", demandq];
		}else if(i == BANKWOOL){
			offerq = [[offer objectForKey:@"wool"] integerValue];
			demandq = [[demand objectForKey:@"wool"] integerValue];
			self.woolQuantity.text = [NSString stringWithFormat:@"%d", offerq];
			SKLabelNode * demandLabel = (SKLabelNode*)[self.theDemand childNodeWithName:@"woolquantitydemand"];
			demandLabel.text = [NSString stringWithFormat:@"%d", demandq];
		}else if(i == BANKGRAIN){
			offerq = [[offer objectForKey:@"grain"] integerValue];
			demandq = [[demand objectForKey:@"grain"] integerValue];
			self.grainQuantity.text = [NSString stringWithFormat:@"%d", offerq];
			SKLabelNode * demandLabel = (SKLabelNode*)[self.theDemand childNodeWithName:@"grainquantitydemand"];
			demandLabel.text = [NSString stringWithFormat:@"%d", demandq];
		}else if(i == BANKORE){
			offerq = [[offer objectForKey:@"ore"] integerValue];
			demandq = [[demand objectForKey:@"ore"] integerValue];
			self.oreQuantity.text = [NSString stringWithFormat:@"%d", offerq];
			SKLabelNode * demandLabel = (SKLabelNode*)[self.theDemand childNodeWithName:@"orequantitydemand"];
			demandLabel.text = [NSString stringWithFormat:@"%d", demandq];
		}
	}
	
	[self.myScene addChild:self];

}



@end
