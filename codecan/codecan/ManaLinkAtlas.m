//
//  ManaLinkAtlas.m
//  codecan
//
//  Created by Jun Fujioka on 10/11/13.
//  Copyright (c) 2013 Codeca. All rights reserved.
//

#import "ManaLinkAtlas.h"

@implementation ManaLinkAtlas

static ManaLinkAtlas * sharedInstance;

-(id)init{
	
	if(self=[super init]){
		self.atlas = [SKTextureAtlas atlasNamed:@"Link"];
		NSMutableArray * frames = [[NSMutableArray alloc] init];
		int numImages = self.atlas.textureNames.count;
		for (int i=1; i <= numImages; i++) {
			NSString *textureName = [NSString stringWithFormat:@"animation_road00%02d", i];
			SKTexture *temp = [self.atlas textureNamed:textureName];
			[frames addObject:temp];
		}
		self.textures = frames;
		
	}
	return self;
}

+ (ManaLinkAtlas*) sharedInstance{
	
	if(sharedInstance==nil){
		sharedInstance = [[self alloc] init];
	}
	
	return sharedInstance;
}


@end
