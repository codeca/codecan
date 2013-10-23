//
//  ThiefNode.h
//  codecan
//
//  Created by Sylvio Cardoso on 23/10/13.
//  Copyright (c) 2013 Codeca. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "HexagonNode.h"

@interface ThiefNode : SKSpriteNode

@property(nonatomic, strong) HexagonNode* position;

@end