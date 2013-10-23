//
//  HexModel.m
//  codecan
//
//  Created by Felipe Fujioka on 22/10/13.
//  Copyright (c) 2013 Codeca. All rights reserved.
//

#import "HexagonNode.h"

@implementation HexagonNode

-(id)init{
	self = [HexagonNode spriteNodeWithImageNamed:@"tile"];
	if(self){
	
		_vertexes = [[NSMutableArray alloc] init];
		_edges = [[NSMutableArray alloc] init];
		self.zPosition = 1;
		
	}
	return self;
	
}




@end
