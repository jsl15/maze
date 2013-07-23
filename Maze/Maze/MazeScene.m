//
//  MazeScene.m
//  Maze
//
//  Created by Jessica Liang on 7/22/13.
//  Copyright (c) 2013 Jessica Liang. All rights reserved.
//

#import "MazeScene.h"
#import <Math.h>
@interface MazeScene()

{
    BOOL _isMoving;
    UITouch *_lastTouch;
}
@property BOOL contentCreated;
@property SKSpriteNode *dot;
@end
@implementation MazeScene

- (void)didMoveToView: (SKView *)view
{
    if (!self.contentCreated){
        [self createContents];
        self.contentCreated = YES;

        _isMoving = NO;
        _lastTouch = nil;
       // self.physicsWorld.contactDelegate = self;
        self.physicsWorld.gravity = CGPointMake(0, 0);
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];

        
    }
}

- (void)createContents
{
    
    self.backgroundColor = [SKColor whiteColor];
    self.scaleMode = SKSceneScaleModeAspectFill;
    [self createMaze];
    

    self.dot = [self createDot];
    self.dot.position = CGPointMake(20, 20);
    self.dot.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.dot.size];
    self.dot.physicsBody.usesPreciseCollisionDetection = YES;
    [self addChild:self.dot];

    
}
- (void)createMaze
{
    SKSpriteNode *maze = [[SKSpriteNode alloc]initWithColor:[SKColor orangeColor] size:CGSizeMake(100, 200)];
    maze.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:maze.size];
    maze.physicsBody.dynamic = NO;
    maze.position = CGPointMake(100, 30);
    [self addChild:maze];
    
    SKSpriteNode *wall = [[SKSpriteNode alloc]initWithColor:[SKColor orangeColor] size:CGSizeMake(100, 400)];
    wall.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:wall.size];
    wall.physicsBody.dynamic = NO;
    wall.position = CGPointMake(200, 250);
    [self addChild:wall];
    
    SKSpriteNode *wall2 = [[SKSpriteNode alloc]initWithColor:[SKColor orangeColor] size:CGSizeMake(50, 300)];
    wall2.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:wall2.size];
    wall2.physicsBody.dynamic = NO;
    wall2.position = CGPointMake(50, self.frame.size.height - 150);
    [self addChild:wall2];
    
    SKSpriteNode *wall3 = [[SKSpriteNode alloc] initWithColor:[SKColor orangeColor] size:CGSizeMake(100, 600)];
    wall3.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:wall3.size];
    wall3.physicsBody.dynamic = NO;
    wall3.position = CGPointMake(200, self.frame.size.height - 350 );

    [self addChild:wall3];
    
    SKSpriteNode *wall4 = [[SKSpriteNode alloc] initWithColor:[SKColor orangeColor] size:CGSizeMake(100, 800)];
    wall4.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:wall4.size];
    wall4.physicsBody.dynamic = NO;
    wall4.position = CGPointMake(350, 400);
    
    [self addChild:wall4];
    
    
    SKSpriteNode *wall5 = [[SKSpriteNode alloc] initWithColor:[SKColor orangeColor] size:CGSizeMake(25, 800)];
    wall5.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:wall5.size];
    wall5.physicsBody.dynamic = NO;
    wall5.position = CGPointMake(495, self.frame.size.height - 300);
    
    [self addChild:wall5];
    
    SKSpriteNode *wall6 = [[SKSpriteNode alloc] initWithColor:[SKColor orangeColor] size:CGSizeMake(25, 500)];
    wall6.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:wall6.size];
    wall6.physicsBody.dynamic = NO;
    wall6.position = CGPointMake(500,300);
    
    [self addChild:wall6];
    
    SKSpriteNode *wall7 = [[SKSpriteNode alloc] initWithColor:[SKColor orangeColor] size:CGSizeMake(25, 800)];
    wall7.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:wall7.size];
    wall7.physicsBody.dynamic = NO;
    wall7.position = CGPointMake(500, self.frame.size.height - 300);
    
    [self addChild:wall7];
    
    SKSpriteNode *wall8 = [[SKSpriteNode alloc] initWithColor:[SKColor orangeColor] size:CGSizeMake(25, 800)];
    wall8.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:wall8.size];
    wall8.physicsBody.dynamic = NO;
    wall8.position = CGPointMake(500, self.frame.size.height - 300);
    
    [self addChild:wall8];
    
    SKSpriteNode *wall9 = [[SKSpriteNode alloc] initWithColor:[SKColor orangeColor] size:CGSizeMake(80
                                                                                                    , 25)];
    wall9.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:wall9.size];
    wall9.physicsBody.dynamic = NO;
    wall9.position = CGPointMake(470, 200);
    
    [self addChild:wall9];
    
    SKSpriteNode *wall10 = [[SKSpriteNode alloc] initWithColor:[SKColor orangeColor] size:CGSizeMake(25, 320)];
    wall10.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:wall10.size];
    wall10.physicsBody.dynamic = NO;
    wall10.position = CGPointMake(450, 200);
    
    [self addChild:wall10];
    
    SKSpriteNode *wall11 = [[SKSpriteNode alloc] initWithColor:[SKColor orangeColor] size:CGSizeMake(80, 50)];
    wall11.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:wall11.size];
    wall11.physicsBody.dynamic = NO;
    wall11.position = CGPointMake(280, 600);
    
    [self addChild:wall11];
    
}
- (CGPoint)getDirection: (CGPoint)point
{
    CGFloat xDirection = point.x - self.dot.position.x;
    CGFloat yDirection = point.y - self.dot.position.y;
    
    return CGPointMake(xDirection, yDirection);
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInNode:self];
    
    [self.dot.physicsBody applyForce: [self getDirection:touchPoint]];

}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesBegan:touches withEvent:event];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesBegan:touches withEvent:event];
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesBegan:touches withEvent:event];
}

- (void)update:(NSTimeInterval)currentTime
{
    CGPoint velocity = self.dot.physicsBody.velocity;
    velocity.x *= .9;
    velocity.y *= .9;
    
    self.dot.physicsBody.velocity = velocity;
}

- (SKSpriteNode *)createDot
{
    SKSpriteNode *dot = [[SKSpriteNode alloc] initWithColor:[SKColor greenColor] size:CGSizeMake(20, 20)];
    return dot;
}
@end
