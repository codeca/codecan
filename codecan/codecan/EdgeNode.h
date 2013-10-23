//
//  EdgeNode.h
//  Codecan
//
//  Created by Sylvio Cardoso on 22/10/13.
//  Copyright (c) 2013 BEPiD. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>


@interface EdgeNode : SKSpriteNode

@property(nonatomic,weak) NSMutableArray* vertexes;

<<<<<<< HEAD
@property(nonatomic,strong) NSArray* vertexes;

//@property(nonatomic, strong) Player* owner;
=======
@property(nonatomic, weak) Player* owner;
>>>>>>> e156045a996fb242f026b548ab07c620b87cf235

@end
