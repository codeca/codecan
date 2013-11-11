//
//  ManaLinkAtlas.h
//  codecan
//
//  Created by Jun Fujioka on 10/11/13.
//  Copyright (c) 2013 Codeca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface ManaLinkAtlas : NSObject

@property (nonatomic, strong) SKTextureAtlas * atlas;
@property (nonatomic, strong) NSArray * textures;

+ (ManaLinkAtlas*) sharedInstance;

@end
