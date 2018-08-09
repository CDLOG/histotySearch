//
//  ViewController.m
//  historyDemo
//
//  Created by 陈乐杰 on 2018/8/9.
//  Copyright © 2018年 nst. All rights reserved.
//

#import "ViewController.h"

#import "searchPage.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)loadSearchPage:(id)sender {
    
    searchPage *search = [[searchPage alloc]init];
    [self presentViewController:search animated:YES completion:nil] ;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
