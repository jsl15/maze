//
//  MazeScene.m
//  Maze
//
//  Created by Jessica Liang on 7/22/13.
//  Copyright (c) 2013 Jessica Liang. All rights reserved.
//

#import "MazeScene.h"

@interface MazeScene()

{
    BOOL _isMoving;
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
        _isMoving = false;
        self.physicsWorld.contactDelegate = self;
        self.physicsWorld.gravity = CGPointMake(0, 0);
        
    }
}
- (void)didBeginContact:(SKPhysicsContact *)contact
{
    
}
- (void)createContents
{
    self.backgroundColor = [SKColor whiteColor];
    self.scaleMode = SKSceneScaleModeAspectFill;
    SKSpriteNode *maze = [self createMaze];
    maze.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    [self addChild:maze];
    
    self.dot = [self createDot];
    self.dot.position = CGPointMake(CGRectGetMidX(self.frame), 5);//CGRectGetMidX(self.frame)
    self.dot.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.dot.size];
    self.dot.physicsBody.usesPreciseCollisionDetection = YES;
    [self addChild:self.dot];
}
- (SKSpriteNode *)createMaze
{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    SKSpriteNode *maze = [[SKSpriteNode alloc]initWithColor:[SKColor blackColor] size:CGSizeMake(screenSize.width *.1, self.frame.size.height)];
    maze.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect: CGRectMake(0, 0, screenSize.width *.1, screenSize.height)];
    maze.physicsBody.usesPreciseCollisionDetection = YES;
    return maze;
    
}
- (void)moveDot: (CGPoint) point
{
    self.dot.position = point;
}
- (BOOL)isNearDot: (CGPoint) point
{
    CGFloat xDist = point.x - self.dot.position.x;
    CGFloat yDist = point.y - self.dot.position.y;
    CGFloat distance = sqrt((xDist * xDist) + (yDist * yDist));
    if (distance <= 10) {
        return  true;
    }
    return false;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInNode:self];
    if ([self isNearDot: touchPoint]) {
        _isMoving = true;
        [self moveDot: touchPoint];
    }
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event

{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInNode: self];
    if (_isMoving) {
        [self moveDot:touchPoint];
    }
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_isMoving) {
        _isMoving = false;
    }
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
}
- (SKSpriteNode *)createDot
{
    SKSpriteNode *dot = [[SKSpriteNode alloc] initWithColor:[SKColor greenColor] size:CGSizeMake(10, 10)];
    return dot;
}
@end
