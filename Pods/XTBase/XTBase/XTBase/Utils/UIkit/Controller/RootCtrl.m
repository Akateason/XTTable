//
//  RootCtrl.m
//  Teason
//
//  Created by ; on 14-8-21.
//  Copyright (c) 2014年 TEASON. All rights reserved.
//

#import "RootCtrl.h"


@interface RootCtrl ()

@end


@implementation RootCtrl

- (void)prepare {
    // prepare when initial
}

- (void)prepareUI {
    // prepare UI
    
}

#pragma mark--
#pragma mark - Life

- (void)dealloc {
    NSString *title = self.navigationItem.title;
    if (title) {
        NSLog(@"xt_dealloc desc : %@\ntitle : %@\n -----", self.description, title);
    }
    else {
        NSLog(@"xt_dealloc title : %@\n -----", self.description);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil
                           bundle:nibBundleOrNil];
    if (self) {
        [self prepare];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self prepare];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self prepare];
    }
    return self;
}

- (void)loadView {
    [super loadView];

    [self prepareUI];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self myStatTitle];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

#pragma mark--
#pragma mark - prop

- (NSString *)myStatTitle {
    if (!_myStatTitle) _myStatTitle = self.title;
    return _myStatTitle;
}

@end
