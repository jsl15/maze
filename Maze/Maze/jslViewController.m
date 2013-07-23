//
//  jslViewController.m
//  Maze
//
//  Created by Jessica Liang on 7/22/13.
//  Copyright (c) 2013 Jessica Liang. All rights reserved.
//

#import "jslViewController.h"
#import <SpriteKit/SpriteKit.h>
#import "MazeScene.h"
@interface jslViewController ()
@end

@implementation jslViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    SKView *gameView = (SKView *)self.view;
    
    gameView.showsDrawCount= YES;
    
    gameView.showsNodeCount = YES;
    
    gameView.showsFPS = YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated
{
    MazeScene* maze = [[MazeScene alloc]initWithSize:CGSizeMake(640, 1136)];
    SKView *gameView = (SKView *)self.view;
    [gameView presentScene:maze];
}
@end
