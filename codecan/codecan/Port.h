//
//  Port.h
//  codecan
//
//  Created by Sylvio Cardoso on 23/10/13.
//  Copyright (c) 2013 Codeca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HexagonNode.h"

@interface Port : NSObject



typedef enum  {
	
	
		STANDARD = 0,
		RESOURCE = 1
	
		} PortType;


@property (nonatomic) PortType type;

@property (nonatomic) Resource resource;

@end
