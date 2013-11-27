//
//  ToastText.m
//  codecan
//
//  Created by Felipe Fujioka on 26/11/13.
//  Copyright (c) 2013 Codeca. All rights reserved.
//

#import "ToastText.h"



@implementation ToastText

- (id)init{

	self = [super init];
	
	if(self){
		
		self.fader = [SKSpriteNode spriteNodeWithColor:[SKColor grayColor] size:[[UIScreen mainScreen] bounds].size];
		self.fader.alpha = 0.5;
		self.fader.name = @"fader";
		[self addChild:self.fader];
		
		self.position = CGPointMake([[UIScreen mainScreen] bounds].size.width/2, [[UIScreen mainScreen] bounds].size.height/2);
		self.zPosition = 20;
		
		self.busy = NO;
		
		self.back = [SKSpriteNode spriteNodeWithColor:[SKColor grayColor] size:CGSizeMake(10,10)];
		self.back.alpha = 0.8;
		
		self.sentences = [[NSMutableArray alloc] init];
		
		[self addChild:self.back];
	}
	
	return self;
	
}

- (ToastText *) toastWithSentences:(NSArray *) sentences duration:(NSInteger) duration andSound:(NSInteger)sound{

	[self.back removeAllChildren];
	
	self.back.size = CGSizeMake([[UIScreen mainScreen] bounds].size.width, 40*sentences.count+20);
	SKSpriteNode * frame = self.back.copy;
	frame.alpha = 1;
	frame.color = [SKColor clearColor];

	self.duration = duration;
	
	for(NSString * sentence in sentences){
		NSLog(@"create sentence");
		NSInteger index = [sentences indexOfObject:sentence];
		
		SKLabelNode * showUp = [SKLabelNode labelNodeWithFontNamed:@"ChalkDuster"];
		showUp.fontSize = 35;
		showUp.fontColor = [SKColor colorWithRed:256 green:256 blue:0 alpha:1];
		showUp.text = sentence;
		showUp.position = CGPointMake(0, self.back.size.height/2 - (index+1)*40);
		[frame addChild:showUp];
	}
	
	[self.back addChild:frame];
	
	return self;

}

-(void) dismiss{
	NSLog(@"Dismiss");
	if(self.parent){
		[self removeFromParent];
		self.busy = NO;
	}
}

-(void) show:(SKScene*)scene{
	NSLog(@"toast shown");
	[scene addChild:self];
	self.busy = YES;
	
	switch (self.duration) {
		case SHORT_DURATION:
			NSLog(@"short duration toast");
			[NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(dismiss) userInfo:nil repeats:NO];
			break;
		case LONG_DURATION:
			[NSTimer scheduledTimerWithTimeInterval:20 target:self selector:@selector(dismiss) userInfo:nil repeats:NO];
			break;
		case PERMANENT:
			break;
			
		default:
			break;
	}
	
}



@end
