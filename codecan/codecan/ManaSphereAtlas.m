//
//  ManaSphereAtlas.m
//  codecan
//
//  Created by Felipe Fujioka on 12/11/13.
//  Copyright (c) 2013 Codeca. All rights reserved.
//

#import "ManaSphereAtlas.h"

@implementation ManaSphereAtlas

static ManaSphereAtlas * sharedInstance;

-(id)init{
	
	if(self=[super init]){
		self.atlas = [SKTextureAtlas atlasNamed:@"Sphere"];
		NSMutableArray * frames = [[NSMutableArray alloc] init];
		int numImages = self.atlas.textureNames.count;
		for (int i=1; i <= numImages; i++) {
			NSString *textureName = [NSString stringWithFormat:@"animation_city00%02d", i];
			SKTexture *temp = [self.atlas textureNamed:textureName];
			[frames addObject:temp];
		}
		self.textures = frames;
		
	}
	return self;
}

+ (ManaSphereAtlas*) sharedInstance{
	
	if(sharedInstance==nil){
		sharedInstance = [[self alloc] init];
	}
	
	return sharedInstance;
}


@end
