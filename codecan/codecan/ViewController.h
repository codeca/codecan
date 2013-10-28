//
//  ViewController.h
//  codecan
//

//  Copyright (c) 2013 Codeca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "Game.h"
#import "Plug.h"

@interface ViewController : UIViewController <PlugDelegate>

@property (nonatomic, strong) Game * game;
@property (nonatomic, strong) Plug * plug;
@property (nonatomic, strong) NSArray * players;
@property (nonatomic, strong) NSString * myId;

@end
