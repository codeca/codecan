//
//  ToastText.h
//  codecan
//
//  Created by Felipe Fujioka on 26/11/13.
//  Copyright (c) 2013 Codeca. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef enum{
	
	SHORT_DURATION = 1,
	LONG_DURATION,
	PERMANENT
	
} TimeDuration;

typedef enum{
	
	HORN = 1,
	WARNING,
	LAUGHTER
	
} ToastSound;

@interface ToastText : SKNode

@property (nonatomic, strong) NSMutableArray * sentences;
@property (nonatomic, strong) SKSpriteNode * fader;
@property (nonatomic, strong) SKSpriteNode * back;

@property (nonatomic) NSInteger duration;

@property (nonatomic) BOOL busy;

- (ToastText *) toastWithSentences:(NSArray *) sentences duration:(NSInteger) duration andSound:(NSInteger)sound;
-(void) show:(SKScene*)scene;

@end
