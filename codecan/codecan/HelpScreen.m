//
//  HelpScreen.m
//  codecan
//
//  Created by Jun Fujioka on 02/11/13.
//  Copyright (c) 2013 Codeca. All rights reserved.
//

#import "HelpScreen.h"

@implementation HelpScreen


-(id)init{
	
	self = [super init];
	
	if(self){
		
		self.zPosition = 20;
		[self setUserInteractionEnabled:YES];
		
		self.fader = [SKSpriteNode spriteNodeWithColor:[SKColor grayColor] size:[[UIScreen mainScreen] bounds].size];
		self.fader.alpha = 0.5;
		self.fader.name = @"fader";
		[self addChild:self.fader];
		
		self.background = [SKSpriteNode spriteNodeWithColor:[SKColor grayColor] size:CGSizeMake(self.fader.size.width*0.85, self.fader.size.height*0.85)];
		[self addChild:self.background];
		
		self.position = CGPointMake(self.fader.size.width/2, self.fader.size.height/2);
		
		self.data = [SKSpriteNode spriteNodeWithImageNamed:@"Help"];
		//self.data.size = self.background.size;
		//[self.background addChild:self.data];
		
		[self.background addChild:self.data];
		
		self.lands = [[NSMutableArray alloc] init];
		
		
		
	}
	
	return self;
	
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	
	for (UITouch *touch in touches) {
        //CGPoint location = [touch locationInNode:self];
        
		//SKNode* clicked = [self nodeAtPoint:location];
		
		//if([clicked.name isEqualToString:@"fader"]){
		[self removeFromParent];
		//}
		
	}
}


@end
