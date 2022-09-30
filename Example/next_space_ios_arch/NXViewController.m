//
//  NXViewController.m
//  next_space_ios_arch
//
//  Created by Wenjinfu on 09/29/2022.
//  Copyright (c) 2022 Wenjinfu. All rights reserved.
//

#import "NXViewController.h"
#import <next_space_ios_arch/next_space_ios_arch-umbrella.h>

@interface NXViewController ()

@end

@implementation NXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [NXRouter openURL:@"test"];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
