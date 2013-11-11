//
//  Plug.h
//  codecan
//
//  Created by Guilherme Souza on 10/17/13.
//  Copyright (c) 2013 Sitegui. All rights reserved.

#import <Foundation/Foundation.h>

typedef enum {
	MSG_MATCH = -4,
	MSG_MATCH_PROGRESS,
	MSG_MATCH_DONE,
	MSG_PLAYER_DISCONNECTED,
	MSG_TABLEREADY,
	MSG_DICE,
	MSG_ROBBER,
	MSG_DISCARTED,
	MSG_TRADE,
	MSG_TRADE_OK,
	MSG_TRADE_CANCEL,
	MSG_BUILD,
	MSG_EOT,
	MSG_HAND_CHANGED,
	MSG_CARD_BUILD,
	MSG_CARD_USED,
	MSG_WINNER,
	MSG_OFFER,
	MSG_RESPONSE_OFFER
} PlugMsgType;

@class Plug;

@protocol PlugDelegate <NSObject>

// Called whenever the server sends a message
- (void)plug:(Plug*)plug receivedMessage:(PlugMsgType)type data:(id)data;

// Called when the connection is open and ready
- (void)plugHasConnected:(Plug*)plug;

// Called when the connection has closed or could not connect
- (void)plug:(Plug*)plug hasClosedWithError:(BOOL)error;

@end

typedef enum {
	PLUGSTATE_CONNECTING,
	PLUGSTATE_OPEN,
	PLUGSTATE_CLOSED
} PlugState;

@interface Plug : NSObject <NSStreamDelegate>

@property (nonatomic) PlugState readyState;
@property (nonatomic, weak) id<PlugDelegate> delegate;

// Create a new Plug and start connecting
- (id)init;

// Send a given message to the server
// data is anything that can be transformed into JSON
- (void)sendMessage:(PlugMsgType)type data:(id)data;

// Close the given connection and prevent future messages to be processed
- (void)close;

@end
