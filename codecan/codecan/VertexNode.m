//
//  VertexNode.m
//  Codecan
//
//  Created by Sylvio Cardoso on 22/10/13.
//  Copyright (c) 2013 BEPiD. All rights reserved.
//

#import "VertexNode.h"

@implementation VertexNode

-(id)init{
	
	self=[super init];
	
	if(self){
		_edges = [[NSMutableArray alloc] init];
	}
	return self;
}

@end
