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
		
		[self.myOffer removeAllChildren];
		
		for(int i = 0; i < 2; i++){
			SKSpriteNode * offerN = [[SKSpriteNode alloc] init];
			offerN.name = [NSString stringWithFormat:@"%d", i];
			offerN.position = CGPointMake(-self.myOffer.size.width/4+i*self.myOffer.size.width/2, 0);
			[self.myOffer addChild:offerN];
		}
			
	}
	return self;
}

-(void) buildInterfaceForResource:(BankSelection) resource andScene:(SKScene*) scene{
	
	self.myScene = (MyScene*)scene;
	self.resource = resource;
	[scene addChild:self];
}

@end
