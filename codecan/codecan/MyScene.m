//
//  MyScene.m
//  codecan
//
//  Created by Guilherme Souza on 10/16/13.
//  Copyright (c) 2013 Codeca. All rights reserved.
//



#import "MyScene.h"

@implementation MyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
		self.table = [[Table alloc] init];
		self.map = [[SKSpriteNode alloc] init];
		self. map.position = CGPointMake(self.size.width/2, self.size.height/2+44);
		[self buildMap];
		
        [self addChild:self.map];
		
		
		
    }

	
    return self;
}

- (void) buildMap{

	for(HexagonNode * hex in self.table.hexes){
		[self.map addChild:hex];
	}
	
	for(VertexNode * vertex in self.table.vertexes){
		[self.map addChild:vertex];
	}
	
	for(EdgeNode * edge in self.table.edges){
		[self.map addChild:edge];
	}

}

//alterei aqui duas vezes

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
        
        sprite.position = location;
        
        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
        
        [sprite runAction:[SKAction repeatActionForever:action]];
        
        [self addChild:sprite];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
