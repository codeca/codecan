//
//  ViewController.h
//  codecan
//

//  Copyright (c) 2013 Codeca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import <AVFoundation/AVFoundation.h>
#import "Game.h"
#import "Plug.h"
#import "MyScene.h"


@interface ViewController : UIViewController <PlugDelegate, AVAudioPlayerDelegate>

@property (nonatomic, strong) Game * game;
@property (nonatomic, strong) Plug * plug;
@property (nonatomic, strong) NSArray * players;
@property (nonatomic, strong) NSString * myId;
@property (nonatomic, strong) MyScene * scene;
@property (nonatomic) NSInteger tableReceived;

@end
