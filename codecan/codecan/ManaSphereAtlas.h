//
//  ManaSphereAtlas.h
//  codecan
//
//  Created by Felipe Fujioka on 12/11/13.
//  Copyright (c) 2013 Codeca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface ManaSphereAtlas : NSObject

@property (nonatomic, strong) SKTextureAtlas * atlas;
@property (nonatomic, strong) NSArray * textures;

+ (ManaSphereAtlas*) sharedInstance;

@end
