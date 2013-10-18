//
//  Plug.h
//  codecan
//
//  Created by Guilherme Souza on 10/17/13.
//  Copyright (c) 2013 Sitegui. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Plug;

@protocol PlugDelegate <NSObject>

- (void)plug:(Plug*)plug receivedMessage:(NSString*)name data:(id)data;
- (void)plugHasConnected:(Plug*)plug;
- (void)plug:(Plug*)plug hasClosedWithError:(BOOL)error;

@end

typedef enum {
	PLUGSTATE_CONNECTING,
	PLUGSTATE_OPEN,
	PLUGSTATE_CLOSED
} PlugState;

@interface Plug : NSObject <NSStreamDelegate>

@property (nonatomic) PlugState readyState;
@property (nonatomic) id<PlugDelegate> delegate;

// Create a new Plug and start connecting
- (id)init;

// Send the given named message to the server
// data is anything that can be transformed into JSON
- (void)sendMessage:(NSString*)name data:(id)data;

// Close the given connection and prevent future messages to be processed
- (void)close;

@end