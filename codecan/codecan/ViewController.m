//
//  ViewController.m
//  codecan
//
//  Created by Guilherme Souza on 10/16/13.
//  Copyright (c) 2013 Codeca. All rights reserved.
//

#import "ViewController.h"

@interface ViewController()

@property (nonatomic, strong) AVAudioPlayer* mPlayer;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	NSString * backgroundPath = [[NSBundle mainBundle] pathForResource:@"backgroundmusic" ofType:@"mp3"];
	
	NSURL * pathURL = [[NSURL alloc] initFileURLWithPath:backgroundPath];
	
	AVAudioPlayer * newPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL: pathURL error: nil];
	self.mPlayer = newPlayer;
	self.mPlayer.delegate = self;
	self.mPlayer.volume = 0.5;
	[self.mPlayer play];
	
	self.plug.delegate = self;
	self.game = [[Game alloc] initWithPlayers:self.players Id:self.myId];
	
	if(self.game.currentPlayer == self.game.me){
		// mount table to send
		
		NSMutableArray * resources = [[NSMutableArray alloc] init];
		
		NSMutableArray * numbers = [[NSMutableArray alloc] init];
		
		NSMutableArray * portTypes = [[NSMutableArray alloc]init];
		
		NSMutableArray * portResources = [[NSMutableArray alloc]init];
		
		NSDictionary * data;
		
		self.game.table.thief = nil;
		
		for(HexagonNode * hex in self.game.table.hexes){
			[resources addObject: [NSNumber numberWithInt:hex.resource]];
			[numbers addObject:[NSNumber numberWithInt:hex.number]];
			
			if(hex.resource == DESERT && self.game.table.thief == nil){
				self.game.table.thief = hex;
			}
		}
		
		for (VertexNode* vertex in self.game.table.vertexes) {
			
			[portTypes addObject:[NSNumber numberWithInt:vertex.port.type]];
			[portResources addObject:[NSNumber numberWithInt:vertex.port.resource]];
			
		}
		
		data = [NSDictionary dictionaryWithObjects:@[resources, numbers, self.game.table.deck.deck, portTypes, portResources] forKeys:@[@"resources",@"numbers",@"deck", @"portTypes", @"portResources"]];
		
		[self.plug sendMessage:MSG_TABLEREADY data:data];
	}
	
	// Configure the view.
    SKView * skView = (SKView *)self.view;
    //skView.showsFPS = YES;
    //skView.showsNodeCount = YES;
    
    
   
    
    // Present the scene.
	if(self.game.currentPlayer == self.game.me){
		// Create and configure the scene.
		self.scene = [MyScene sceneWithSize:skView.bounds.size andGame:self.game];
		self.scene.plug = self.plug;
		self.scene.plug.delegate = self.scene;
		self.scene.scaleMode = SKSceneScaleModeAspectFill;
		
		[self.scene addObserver:self forKeyPath:@"endGame" options:NSKeyValueObservingOptionNew context:nil];
		[skView presentScene:self.scene];
	}
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
	[self.scene removeObserver:self forKeyPath:@"endGame"];
	[self dismissViewControllerAnimated:YES completion:nil];
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
		
		self.game.table = [[Table alloc] initWithTable:received];
		[self.game.table initializeMinesForPlayers:self.game.players.count];
		self.scene = [MyScene sceneWithSize:self.view.bounds.size andGame:self.game];
		self.scene.plug = self.plug;
		self.scene.plug.delegate = self.scene;
		self.scene.scaleMode = SKSceneScaleModeAspectFill;
		[(SKView*)self.view presentScene:self.scene];
	}
	
	
}



-(void)plugHasConnected:(Plug *)plug{

}

- (void) audioPlayerDidFinishPlaying: (AVAudioPlayer *) player
                        successfully: (BOOL) completed {
    [self.mPlayer play];
}


@end
