//
//  VertexNode.h
//  Codecan
//
//  Created by Sylvio Cardoso on 22/10/13.
//  Copyright (c) 2013 BEPiD. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

enum vertexType {
	
	village = 1,
	city = 2
	
};

@interface VertexNode : SKSpriteNode

//@property (nonatomic, strong) Player* owner;

@property (nonatomic) enum vertexType type;

@property (nonatomic, strong) NSArray* hexagons;

@property (nonatomic,strong) NSArray* edges;

//@property (nonatomic, strong) Port* port;

@end
