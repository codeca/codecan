//
//  EdgeNode.m
//  Codecan
//
//  Created by Sylvio Cardoso on 22/10/13.
//  Copyright (c) 2013 BEPiD. All rights reserved.
//

#import "EdgeNode.h"

@implementation EdgeNode

-(id)init{

	self = [EdgeNode spriteNodeWithImageNamed:@"edge"];
	
	if(self){
		_vertexes = [[NSMutableArray alloc] init];
		self.zPosition = 2;
	}
	return self;
}


-(void)receiveOwner:(Player *)player{
	
	BOOL valid = NO;
	
	for(VertexNode * vertex in self.vertexes){
		if(vertex.owner == player){
			valid = YES;
			break;
		}else{
			for(EdgeNode * edge in vertex.edges){
				if(edge.owner==player){
					valid=YES;
					break;
				}
			}
		}
	}
	
	if(valid){
		self.owner = player;
		//self.color = self.owner.color;
		//self.colorBlendFactor= 1.0;
		
		SKSpriteNode * manaLink = [SKSpriteNode spriteNodeWithTexture:[ManaLinkAtlas sharedInstance].textures[0]];
		manaLink.name = @"link";
		manaLink.color = self.owner.color;
		manaLink.colorBlendFactor = 1.0;
		manaLink.yScale = 0.78;
		manaLink.position = CGPointMake(-5, -15);
		
		
		
		[self addChild:manaLink];
		
		[manaLink runAction:[SKAction repeatActionForever:
							[SKAction animateWithTextures:[ManaLinkAtlas sharedInstance].textures
											 timePerFrame:0.05f
												   resize:NO
												  restore:YES]] withKey:@"link"];
		
		[self runAction:[SKAction playSoundFileNamed:@"buildingsound.mp3" waitForCompletion:YES]];
		self.owner.roads++;
	}
}

-(void)breakRoad{
	SKSpriteNode* link = (SKSpriteNode*)[self childNodeWithName:@"link"];
	
	
	if(link){
		self.owner.roads--;
		self.owner = nil;
		[link removeAllActions];
		[link setTexture:nil];
		[link removeFromParent];
	}
}
@end
