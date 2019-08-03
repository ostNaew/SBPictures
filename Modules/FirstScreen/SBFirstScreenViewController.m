//
//  SBFirstScreenViewController.m
//  SBPictures
//
//  Created by 17495310 on 02/06/2019.
//  Copyright © 2019 17495310. All rights reserved.
//

#import "SBFirstScreenViewController.h"
#import "SBFirstScreenManager.h"
#import "../SecondScreen/SBPictureGridViewController.h"

@interface SBFirstScreenViewController ()

@property (strong, nonatomic) IBOutlet UIView *firstView;
@property (weak, nonatomic) IBOutlet UIButton *pictureButton;
@property (weak, nonatomic) IBOutlet UIButton *operationButton;
@property (strong, nonatomic) SBFirstScreenManager *manager;

@end

@implementation SBFirstScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.manager = [[SBFirstScreenManager alloc] init];
    [self.pictureButton addTarget:self
                           action:@selector(showPictures:) forControlEvents:UIControlEventTouchUpInside];
    [self.operationButton addTarget:self
                           action:@selector(performOperation:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)showPictures:(UIBarButtonItem*)sender {    
    SBPictureGridViewController *secondScreen = [[SBPictureGridViewController alloc] init];
    secondScreen.option = loadOptionDataTask;
    [self.navigationController pushViewController:secondScreen animated:YES];
}

-(void)performOperation:(UIBarButtonItem*)sender {
    SBPictureGridViewController *secondScreen = [[SBPictureGridViewController alloc] init];
    secondScreen.option = loadOptionOperation;
    [self.navigationController pushViewController:secondScreen animated:YES];
}

@end
