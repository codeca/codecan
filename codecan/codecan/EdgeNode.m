//
//  EdgeNode.m
//  Codecan
//
//  Created by Sylvio Cardoso on 22/10/13.
//  Copyright (c) 2013 BEPiD. All rights reserved.
//

#import "EdgeNode.h"

@implementation EdgeNode

-(id)init{

	self = [EdgeNode spriteNodeWithImageNamed:@"edge"];
	
	if(self){
		_vertexes = [[NSMutableArray alloc] init];
		self.zPosition = 2;
	}
	return self;
}

@end
