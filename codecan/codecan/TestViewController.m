//
//  TestViewController.m
//  codecan
//
//  Created by Guilherme Souza on 10/18/13.
//  Copyright (c) 2013 Codeca. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@property (nonatomic) Plug* plug;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.plug = [[Plug alloc] init];
	self.plug.delegate = self;
}

- (IBAction)sayHiButton:(id)sender {
	[self.plug sendMessage:1 data:@"Hi, from iOS"];
}
- (IBAction)closeButton:(id)sender {
	[self.plug close];
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
