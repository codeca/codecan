//
//  ManaCrystalAtlas.m
//  codecan
//
//  Created by Jun Fujioka on 09/11/13.
//  Copyright (c) 2013 Codeca. All rights reserved.
//

#import "ManaCrystalAtlas.h"

@interface ManaCrystalAtlas()

@end

@implementation ManaCrystalAtlas

static ManaCrystalAtlas * sharedInstance;

-(id)init{
	
	if(self=[super init]){
		self.atlas = [SKTextureAtlas atlasNamed:@"Crystal"];
		NSMutableArray * frames = [[NSMutableArray alloc] init];
		int numImages = self.atlas.textureNames.count;
		for (int i=1; i <= numImages; i++) {
			NSString *textureName = [NSString stringWithFormat:@"animation_village00%02d", i];
			SKTexture *temp = [self.atlas textureNamed:textureName];
			[frames addObject:temp];
		}
		self.textures = frames;
		
	}
	return self;
}

+ (ManaCrystalAtlas*) sharedInstance{
	
	if(sharedInstance==nil){
		sharedInstance = [[self alloc] init];
	}
	
	return sharedInstance;
}

@end
