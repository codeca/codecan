//
//  StartViewController.m
//  codecan
//
//  Created by Otávio Netto Zani on 28/10/13.
//  Copyright (c) 2013 Codeca. All rights reserved.
//

#import "StartViewController.h"
#import "ViewController.h"
#import "Player.h"

@interface StartViewController ()

typedef enum {
	WAITING_3 = 0,
	WAITING_4,
	WAITING_3_4,
	WAITING_DEBUG
}waitingFor;

@property (nonatomic, strong) Plug* plug;
@property (weak, nonatomic) IBOutlet UILabel *progressText;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (nonatomic) waitingFor waiting;
@property (nonatomic, strong) NSString* myId;
@property (nonatomic, weak) ViewController * nextView;
@property (nonatomic, strong) NSMutableArray * players;

@property (nonatomic, strong) AVAudioPlayer * mPlayer;
@property (nonatomic, strong) NSDictionary	* serverData;
@property (nonatomic) BOOL tutorialMode;
@property (weak, nonatomic) IBOutlet UISwitch *tutorialSwitch;

@end

@implementation StartViewController

- (IBAction)tutorialSwitchChanged:(id)sender {
	
}

-(void) viewDidLoad{
	[super viewDidLoad];
	
	NSString * backgroundPath = [[NSBundle mainBundle] pathForResource:@"opening" ofType:@"mp3"];
	
	NSURL * pathURL = [[NSURL alloc] initFileURLWithPath:backgroundPath];
	
	AVAudioPlayer * newPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL: pathURL error: nil];
	self.mPlayer = newPlayer;
	self.mPlayer.delegate = self;
	self.mPlayer.volume = 1.0;
	[self.mPlayer play];
	
	
	self.name.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"name"];
	
	
}
- (IBAction)debug2Players:(id)sender {
	
	[self resetPlug];
	
	self.serverData = [NSDictionary dictionaryWithObjects:@[@1, @0, self.name.text, self.myId] forKeys:@[@"want2", @"want1", @"name", @"id"]];
	
	self.progressText.text = @"Connecting";
	
	self.waiting = WAITING_3;
	
}

- (IBAction)debug1Player:(id)sender {
	
	[self resetPlug];
	
	self.serverData = [NSDictionary dictionaryWithObjects:@[@0, @0, @1, self.name.text, self.myId] forKeys:@[@"want3", @"want4",@"want1", @"name", @"id"]];
	
	self.waiting = WAITING_DEBUG;
	
	if(self.plug.readyState == PLUGSTATE_CLOSED){
		Player * me = [[Player alloc] init];
		me.name = self.name.text;
		me.ID = @"1234";
		self.myId = me.ID;
		self.players = [[NSMutableArray alloc] init];
		[self.players addObject:me];
		[self performSegueWithIdentifier:@"GoToGame" sender:self];
	}
	
}

- (IBAction)startWith4Players:(id)sender {
	
	[self resetPlug];
	
	self.serverData = [NSDictionary dictionaryWithObjects:@[@0, @1, self.name.text, self.myId] forKeys:@[@"want3", @"want4", @"name", @"id"]];
	
	self.progressText.text = @"Connecting";
	
	self.waiting = WAITING_4;
	

}


- (IBAction)startWith3Players:(id)sender {
	
	[self resetPlug];
	
	self.serverData = [NSDictionary dictionaryWithObjects:@[@1, @0, self.name.text, self.myId] forKeys:@[@"want3", @"want4", @"name", @"id"]];
	
	self.progressText.text = @"Connecting";
	
	self.waiting = WAITING_3;
	
}

- (void)plug:(Plug *)plug receivedMessage:(PlugMsgType)type data:(id)data {
	NSLog(@"received %d %@", type, data);
	
	
	if(type == MSG_MATCH_PROGRESS){
		NSInteger waiting3 = [[data objectForKey:@"waitingFor3"] integerValue];
		NSInteger waiting4 =[[data objectForKey:@"waitingFor4"] integerValue];
		
		if(self.waiting == WAITING_3)
			self.progressText.text = [NSString stringWithFormat:@"Waiting for %i more players", 3-waiting3];
		else
			self.progressText.text = [NSString stringWithFormat:@"Waiting for %i more players", 4-waiting4];
	}
	
	else if(type == MSG_MATCH_DONE){
		
		Player * newPlayer;
		
		self.players = [[NSMutableArray alloc] init];
		
		NSArray * players = data;
		
		for(NSDictionary * player in players){
			newPlayer = [[Player alloc] init];
			newPlayer.name = [player objectForKey:@"name"];
			newPlayer.ID = [player objectForKey:@"id"];
			[self.players addObject:newPlayer];
		}
		[self performSegueWithIdentifier:@"GoToGame" sender:self];
		
	}


}

-(void)viewWillDisappear:(BOOL)animated{
	[[NSUserDefaults standardUserDefaults] setObject:self.name.text forKey:@"name"];
	[[NSUserDefaults standardUserDefaults] synchronize];
	[self.mPlayer stop];
	self.mPlayer = nil;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
	
	if([segue.identifier isEqualToString:@"GoToGame"]){
		ViewController * destination = [segue destinationViewController];
		
		destination.players = self.players;
		destination.myId = self.myId;
		destination.plug = self.plug;
		
	}
	
}

- (void)plugHasConnected:(Plug *)plug {
	NSLog(@"connected");
	
	self.progressText.text = @"Connected";
	
	
	[self.plug sendMessage:MSG_MATCH data:self.serverData];


}

- (void)plug:(Plug *)plug hasClosedWithError:(BOOL)error {
	NSLog(@"closed %hhd", error);
	

}

- (void) audioPlayerDidFinishPlaying: (AVAudioPlayer *) player
                        successfully: (BOOL) completed {
    [self.mPlayer play];
}


-(void) resetPlug{
	//sobrescreve o plug anterior e reinicia a conexão
	self.plug = [[Plug alloc] init];
	self.plug.delegate = self;
	self.myId = [[NSUUID UUID] UUIDString];
}

@end
