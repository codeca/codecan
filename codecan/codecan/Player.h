//
//  Player.h
//  codecan
//
//  Created by Felipe Fujioka on 23/10/13.
//  Copyright (c) 2013 Codeca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface Player : NSObject

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) SKColor* color;

@property (nonatomic)NSInteger wool;
@property (nonatomic)NSInteger brick;
@property (nonatomic)NSInteger ore;
@property (nonatomic)NSInteger grain;
@property (nonatomic)NSInteger lumber;

@property(nonatomic) NSInteger points;

@property(nonatomic, strong) NSMutableArray* cards;


@end
