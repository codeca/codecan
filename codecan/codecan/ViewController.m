//
//  ViewController.m
//  codecan
//
//  Created by Guilherme Souza on 10/16/13.
//  Copyright (c) 2013 Codeca. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.plug.delegate = self;
	self.game = [[Game alloc] initWithPlayers:self.players Id:self.myId];
	
	if(self.game.currentPlayer == self.game.me){
		// mount table to send
		
		NSMutableArray * resources = [[NSMutableArray alloc] init];
		
		NSMutableArray * numbers = [[NSMutableArray alloc] init];
		
		NSDictionary * data;
		
		for(HexagonNode * hex in self.game.table.hexes){
			[resources addObject: [NSNumber numberWithInt:hex.resource]];
			[numbers addObject:[NSNumber numberWithInt:hex.number]];
		}
		
		data = [NSDictionary dictionaryWithObjects:@[resources, numbers, self.game.table.deck.deck] forKeys:@[@"resources",@"numbers",@"deck"]];
		
		[self.plug sendMessage:MSG_TABLEREADY data:data];
	}
	
	// Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    
   
    
    // Present the scene.
	if(self.game.currentPlayer == self.game.me){
		// Create and configure the scene.
		self.scene = [MyScene sceneWithSize:skView.bounds.size andGame:self.game];
		self.scene.plug = self.plug;
		self.scene.plug.delegate = self.scene;
		self.scene.scaleMode = SKSceneScaleModeAspectFill;
		[skView presentScene:self.scene];
	}
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

	if(type == MSG_TABLEREADY){
		
		NSDictionary * received = data;
		
		self.game.table = [[Table alloc] initWithTable:data];
		self.game.table.deck.deck = [received objectForKey:@"deck"];
		self.scene = [MyScene sceneWithSize:self.view.bounds.size andGame:self.game];
		self.scene.plug = self.plug;
		self.scene.plug.delegate = self.scene;
		self.scene.scaleMode = SKSceneScaleModeAspectFill;
		[(SKView*)self.view presentScene:self.scene];
	}
	
	
}



-(void)plugHasConnected:(Plug *)plug{

}

@end
