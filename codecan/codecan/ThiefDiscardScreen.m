//
//  ThiefDiscardScreen.m
//  codecan
//
//  Created by Otávio Netto Zani on 30/10/13.
//  Copyright (c) 2013 Codeca. All rights reserved.
//

#import "ThiefDiscardScreen.h"
#import "MyScene.h"

@interface ThiefDiscardScreen()

@property (nonatomic, weak) MyScene * myScene;
@property (nonatomic) BOOL canFinish;

-(void) canClose;

@end

@implementation ThiefDiscardScreen

-(id) init{
	
	if(self = [super init]){
		self.canFinish = NO;
		self.userInteractionEnabled = YES;
		
		self.zPosition = 10;
		
		self.fader = [SKSpriteNode spriteNodeWithColor:[SKColor grayColor] size:[[UIScreen mainScreen] bounds].size];
		self.fader.alpha = 0.5;
		self.fader.name = @"fader";
		[self addChild:self.fader];
		
		SKLabelNode * title = [SKLabelNode labelNodeWithFontNamed:@"ChalkDuster"];
		title.text = @"PERDEU PLAYBOY!";
		title.fontSize = 50;
		title.fontColor = [SKColor blackColor];
		title.position = CGPointMake(0, 300);
		[self addChild:title];
		
		self.background = [SKSpriteNode spriteNodeWithColor:[SKColor grayColor] size:CGSizeMake(550, 500)];
		[self addChild:self.background];
		
		
		self.selections = [SKSpriteNode spriteNodeWithColor:[SKColor whiteColor] size:CGSizeMake(self.background.size.width*4/5, self.background.size.height/4)];
		self.selections.position = CGPointMake(0, self.background.size.height/6);
		self.selections.name = @"selections";
		[self addChild:self.selections];
		
		self.options = [SKSpriteNode spriteNodeWithColor:[SKColor whiteColor] size:CGSizeMake(self.background.size.width*4/5, self.background.size.height/4)];
		self.options.position = CGPointMake(0, -self.background.size.height/6);
		self.options.name = @"options";
		[self addChild:self.options];
		
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
		self.woolQuantity.fontColor = [SKColor blackColor];
		self.woolQuantity.position = CGPointMake(self.options.size.width*2/6, -40);
		[self.options addChild:self.woolQuantity];
		
		self.brickQuantity = [SKLabelNode labelNodeWithFontNamed:@"ChalkDuster"];
		self.brickQuantity.name = @"woolquantity";
		self.brickQuantity.fontColor = [SKColor blackColor];
		self.brickQuantity.position = CGPointMake(0, -40);
		[self.options addChild:self.brickQuantity];
		
		self.lumberQuantity = [SKLabelNode labelNodeWithFontNamed:@"ChalkDuster"];
		self.lumberQuantity.name = @"woolquantity";
		self.lumberQuantity.fontColor = [SKColor blackColor];
		self.lumberQuantity.position = CGPointMake(-self.options.size.width*2/6, -40);
		[self.options addChild:self.lumberQuantity];
		
		self.oreQuantity = [SKLabelNode labelNodeWithFontNamed:@"ChalkDuster"];
		self.oreQuantity.name = @"woolquantity";
		self.oreQuantity.fontColor = [SKColor blackColor];
		self.oreQuantity.position = CGPointMake(-self.options.size.width/6, -40);
		[self.options addChild:self.oreQuantity];
		
		self.grainQuantity = [SKLabelNode labelNodeWithFontNamed:@"ChalkDuster"];
		self.grainQuantity.name = @"woolquantity";
		self.grainQuantity.fontColor = [SKColor blackColor];
		self.grainQuantity.position = CGPointMake(self.options.size.width/6, -40);
		[self.options addChild:self.grainQuantity];
		
	}
	
	return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	
	for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
		SKNode* clicked = [self nodeAtPoint:location];
		if(self.discardList.count < self.discard){
			if([clicked.name isEqualToString:@"lumber"]){
				
				if(self.player.lumber >= 1){
					[self.discardList addObject:[NSNumber numberWithInt:DISLUMBER]];
					self.player.lumber--;
				}
				
			}else if([clicked.name isEqualToString:@"ore"]){
				
				if(self.player.ore >= 1){
					[self.discardList addObject:[NSNumber numberWithInt:DISORE]];
					self.player.ore--;
				}
				
			}else if([clicked.name isEqualToString:@"grain"]){
				
				if(self.player.grain >= 1){
					[self.discardList addObject:[NSNumber numberWithInt:DISGRAIN]];
					self.player.grain--;
				}
				
			}else if([clicked.name isEqualToString:@"wool"]){
				
				if(self.player.wool >= 1){
					[self.discardList addObject:[NSNumber numberWithInt:DISWOOL]];
					self.player.wool--;
				}
				
			}else if([clicked.name isEqualToString:@"brick"]){
				
				if(self.player.brick >= 1){
					[self.discardList addObject:[NSNumber numberWithInt:DISBRICK]];
					self.player.brick--;
				}
			}
		}
		
		if(self.discardList.count == self.discard){
			[NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(canClose) userInfo:nil repeats:NO];
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
	
	
	DiscardSelection selection = [self.discardList.lastObject integerValue];;
	NSInteger index = self.discardList.count-1;
	if(index>=0){
		SKSpriteNode* child = self.selections.children[index];
		
		if(child.texture == nil){
		
			switch (selection) {
				case DISBRICK:
					child.texture = [SKTexture textureWithImageNamed:@"brick"];
					break;
				case DISLUMBER:
					child.texture = [SKTexture textureWithImageNamed:@"lumber"];
					break;
				case DISORE:
					child.texture = [SKTexture textureWithImageNamed:@"ore"];
					break;
				case DISGRAIN:
					child.texture = [SKTexture textureWithImageNamed:@"grain"];
					break;
				case DISWOOL:
					child.texture = [SKTexture textureWithImageNamed:@"wool"];
					break;
					
				default:
					break;
			}
			child.size = child.texture.size;
			child.yScale = 0.1;
			child.xScale = 0.1;
		}
	}
		
	
}

-(void) canClose{
	self.myScene.playersDiscardedForThief++;
	[self.myScene broadcastResourcesChangeForPlayer:self.player add:self.player.mountPlayerHand remove:@[@"all"]];
	[self removeFromParent];
}

-(void) discardScreenForPlayer:(Player*) player andScene:(MyScene*) scene{
	
	self.canFinish = NO;
	
	self.discard = [self discardCountForPlayer:player];
	
	self.discardList = [[NSMutableArray alloc] init];
	
	[self.selections removeAllChildren];
	
	for(int i = 0; i < self.discard; i++){
		SKSpriteNode * offerN = [SKSpriteNode spriteNodeWithColor:[SKColor greenColor] size:CGSizeMake(50, 50)];
		offerN.position = CGPointMake((i+1)*self.selections.size.width/(self.discard+1)-self.selections.size.width/2, 0);
		[self.selections addChild:offerN];
	}
	
	self.player = player;
	self.myScene = scene;
	[self updateView];
	
	[self.myScene addChild:self];
	
	
}


-(NSInteger) discardCountForPlayer: (Player*) player{
	return (player.wool+player.brick+player.lumber+player.ore+player.grain)/2;
}

@end
