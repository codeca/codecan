//
//  VertexNode.h
//  Codecan
//
//  Created by Sylvio Cardoso on 22/10/13.
//  Copyright (c) 2013 BEPiD. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Port.h"

typedef enum {
	
	village = 1,
	city = 2
	
} VertexType;

@interface VertexNode : SKSpriteNode

@property (nonatomic, weak) Player* owner;

@property (nonatomic) VertexType type;

@property (nonatomic,strong) NSMutableArray* edges;

@property (nonatomic, strong) Port* port;

@end
