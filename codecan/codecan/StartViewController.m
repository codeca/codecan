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
	WAITING_3_4
}waitingFor;

@property (nonatomic, strong) Plug* plug;
@property (weak, nonatomic) IBOutlet UILabel *progressText;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (nonatomic) waitingFor waiting;
@property (nonatomic, strong) NSString* myId;
@property (nonatomic, weak) ViewController * nextView;
@property (nonatomic, strong) NSMutableArray * players;

@end

@implementation StartViewController

-(void) viewDidLoad{
	[super viewDidLoad];
	
	self.plug = [[Plug alloc] init];
	self.plug.delegate = self;
	self.myId = [[NSUUID UUID] UUIDString];
	
}


- (IBAction)startWith4Players:(id)sender {
	NSDictionary *serverData = [NSDictionary dictionaryWithObjects:@[@0, @1, self.name.text, self.myId] forKeys:@[@"want3", @"want4", @"name", @"id"]];
	
	self.waiting = WAITING_4;
	[self.plug sendMessage:MSG_MATCH data:serverData];
	

}


- (IBAction)startWith3Players:(id)sender {
	NSDictionary *serverData = [NSDictionary dictionaryWithObjects:@[@1, @0, self.name.text, self.myId] forKeys:@[@"want3", @"want4", @"name", @"id"]];
	self.waiting = WAITING_3;
	[self.plug sendMessage:MSG_MATCH data:serverData];
	
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
		
		Player * newPlayer = [[Player alloc] init];
		
		self.players = [[NSMutableArray alloc] init];
		
		NSArray * players = data;
		
		for(NSDictionary * player in players){
			newPlayer.name = [player objectForKey:@"name"];
			newPlayer.ID = [player objectForKey:@"id"];
			[self.players addObject:newPlayer];
		}
		[self performSegueWithIdentifier:@"GoToGame" sender:self];
		
	}


}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
	
	if([segue.identifier isEqualToString:@"GoToGame"]){
		ViewController * destination = [segue destinationViewController];
		
		destination.players = self.players;
		destination.myId = self.myId;
		
	}
	
}

- (void)plugHasConnected:(Plug *)plug {
	NSLog(@"connected");


}

- (void)plug:(Plug *)plug hasClosedWithError:(BOOL)error {
	NSLog(@"closed %hhd", error);
	

}

@end
