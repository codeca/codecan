//
//  ViewController.m
//  codecan
//
//  Created by Guilherme Souza on 10/16/13.
//  Copyright (c) 2013 Codeca. All rights reserved.
//

#import "ViewController.h"
#import "MyScene.h"

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	//self.plug = [[Plug alloc] init];

	self.game = [[Game alloc] initWithNumberOfPLayers:1];
	self.game.phase = INITIALIZATIONCITY;
	// Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    // Create and configure the scene.
    SKScene * scene = [MyScene sceneWithSize:skView.bounds.size andGame:self.game];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

-(void)plug:(Plug *)plug hasClosedWithError:(BOOL)error{

}

-(void)plug:(Plug *)plug receivedMessage:(PlugMsgType)type data:(id)data{

	// treat match message to start scene
	
	
}

-(void)plugHasConnected:(Plug *)plug{

}

@end
