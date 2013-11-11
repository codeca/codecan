//
//  HelpScreen.h
//  codecan
//
//  Created by Jun Fujioka on 02/11/13.
//  Copyright (c) 2013 Codeca. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface HelpScreen : SKNode

@property (nonatomic, strong) SKSpriteNode * fader;
@property (nonatomic, strong) SKSpriteNode * background;
@property (nonatomic, strong) SKSpriteNode * data;

@property (nonatomic,strong) SKLabelNode * title;
@property (nonatomic, strong) SKLabelNode * landsLabel;
@property (nonatomic, strong) SKLabelNode * buildingsLabel;

@property (nonatomic, strong) NSMutableArray * lands;
@property (nonatomic, strong) NSMutableArray * buildings;

@end
