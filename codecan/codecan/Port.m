//
//  Port.m
//  codecan
//
//  Created by Sylvio Cardoso on 23/10/13.
//  Copyright (c) 2013 Codeca. All rights reserved.
//

#import "Port.h"
#import "HexagonNode.h"

@implementation Port

-(id) initWithType: (PortType) type withResource: (Resource) resource{
	
	self = [super init];
	
	if (self) {
		
		self.type = type;
		self.resource = resource;
		
	}
	
	return self;
	
	
}

@end
