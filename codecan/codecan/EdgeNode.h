//
//  EdgeNode.h
//  Codecan
//
//  Created by Sylvio Cardoso on 22/10/13.
//  Copyright (c) 2013 BEPiD. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

/**  */

@interface EdgeNode : SKSpriteNode

/**  */

@property(nonatomic,weak) NSMutableArray* vertexes;

@property(nonatomic, weak) Player* owner;

@end
