//
//  ManaCrystalAtlas.h
//  codecan
//
//  Created by Jun Fujioka on 09/11/13.
//  Copyright (c) 2013 Codeca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface ManaCrystalAtlas : NSObject

@property (nonatomic, strong) SKTextureAtlas * atlas;
@property (nonatomic, strong) NSArray * textures;

+ (ManaCrystalAtlas*) sharedInstance;

@end
