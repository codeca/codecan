//
//  StartViewController.m
//  codecan
//
//  Created by Otávio Netto Zani on 28/10/13.
//  Copyright (c) 2013 Codeca. All rights reserved.
//

#import "StartViewController.h"

@interface StartViewController ()


@property (nonatomic, strong) Plug* plug;
@property (weak, nonatomic) IBOutlet UILabel *progressText;
@property (weak, nonatomic) IBOutlet UITextField *name;

@end

@implementation StartViewController

-(void) viewDidLoad{
	[super viewDidLoad];
	
	self.plug = [[Plug alloc] init];
	self.plug.delegate = self;
}


- (IBAction)startWith4Players:(id)sender {
	NSDictionary *serverData = [NSDictionary dictionaryWithObjects:@[@0, @1, self.name.text, [[NSUUID UUID] UUIDString]] forKeys:@[@"want3", @"want4", @"name", @"id"]];
	
	[self.plug sendMessage:MSG_MATCH data:serverData];
	

}


- (IBAction)startWith3Players:(id)sender {
	NSDictionary *serverData = [NSDictionary dictionaryWithObjects:@[@1, @0, self.name.text, [[NSUUID UUID] UUIDString]] forKeys:@[@"want3", @"want4", @"name", @"id"]];
	
	[self.plug sendMessage:MSG_MATCH data:serverData];
	
}

- (void)plug:(Plug *)plug receivedMessage:(PlugMsgType)type data:(id)data {
	NSLog(@"received %d %@", type, data);


}

- (void)plugHasConnected:(Plug *)plug {
	NSLog(@"connected");


}

- (void)plug:(Plug *)plug hasClosedWithError:(BOOL)error {
	NSLog(@"closed %hhd", error);


}

@end
