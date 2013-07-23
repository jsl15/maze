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
       // self.physicsWorld.contactDelegate = self;
       self.anchorPoint = CGPointMake(0, 0);
        self.physicsWorld.gravity = CGPointMake(1, 0);
        
    }
}

- (void)createContents
{
    self.backgroundColor = [SKColor whiteColor];
    self.scaleMode = SKSceneScaleModeAspectFill;
    SKSpriteNode *maze = [self createMaze];
    maze.position = CGPointMake(CGRectGetMidX(self.frame), 300);
    [self addChild:maze];
    
    self.dot = [self createDot];
    self.dot.position = CGPointMake(100, 100);
    self.dot.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.dot.size];
    self.dot.physicsBody.usesPreciseCollisionDetection = YES;
    //self.dot.anchorPoint = CGPointMake(0.5, 0.5);
    [self addChild:self.dot];
    
}
- (SKSpriteNode *)createMaze
{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    SKSpriteNode *maze = [[SKSpriteNode alloc]initWithColor:[SKColor blackColor] size:CGSizeMake(screenSize.width *.1, self.frame.size.height)];
    maze.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGRectMake(0, 0, screenSize.width *.1, screenSize.height).size];
    maze.physicsBody.dynamic = NO;
    maze.anchorPoint = CGPointMake(0.5, 0.5);
    return maze;
    
}
- (void)moveDotTo: (CGPoint) point
{
    self.dot.position = point;
}
- (BOOL)isNearDot: (CGPoint) point
{
    CGFloat distance = [MazeScene distanceBetween:point and:self.dot.position];
    if (distance <= 10) {
        return  true;
    }
    return false;
}
+ (CGFloat)distanceBetween: (CGPoint) p1 and:(CGPoint)p2
{
    CGFloat xDist = p1.x - p2.x;
    CGFloat yDist = p1.y - p2.y;
    CGFloat distance = sqrt((xDist * xDist) + (yDist * yDist));
    return distance;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInNode:self];
    CGFloat distance = [MazeScene distanceBetween:touchPoint and:self.dot.position];
    CGFloat xDist = touchPoint.x - self.dot.position.x;
    CGFloat angleFromDot = acosf(xDist/distance);

    if (self.dot.position.y > touchPoint.y) {
        self.physicsWorld.gravity = CGPointMake(cosf(angleFromDot), -1.0*
                                                sinf(angleFromDot));
    } else {
        self.physicsWorld.gravity = CGPointMake(cosf(angleFromDot), sinf(angleFromDot));
    }

}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event

{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInNode:self];
    CGFloat distance = [MazeScene distanceBetween:touchPoint and:self.dot.position];
    CGFloat xDist = touchPoint.x - self.dot.position.x;
    CGFloat angleFromDot = acosf(xDist/distance);
    [self.dot.physicsBody applyForce: CGPointMake(2.0*cosf(angleFromDot), 2.0*sinf(angleFromDot))];
    if (self.dot.position.y > touchPoint.y) {
    self.physicsWorld.gravity = CGPointMake(cosf(angleFromDot), -1.0*sinf(angleFromDot));
    } else {
        self.physicsWorld.gravity = CGPointMake(cosf(angleFromDot), sinf(angleFromDot));
    }
    
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.physicsWorld.gravity = CGPointMake(0, 0);
    self.dot.physicsBody.velocity = CGPointMake(0, 0);

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
