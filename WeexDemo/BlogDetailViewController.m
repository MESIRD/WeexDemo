//
//  BlogDetailViewController.m
//  WeexDemo
//
//  Created by mesird on 07/01/2017.
//  Copyright © 2017 mesird. All rights reserved.
//

#import "BlogDetailViewController.h"

#import <WeexSDK/WXSDKInstance.h>

@interface BlogDetailViewController ()

@property (nonatomic, strong) WXSDKInstance *instance;
@property (nonatomic, strong) UIView *weexView;

@end

@implementation BlogDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    self.view.frame = CGRectMake(0, 64.0f, screenSize.width, screenSize.height - 64.0f);
    
    _instance = [[WXSDKInstance alloc] init];
    _instance.viewController = self;
    _instance.frame = self.view.frame;
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"detail" withExtension:@"js"];
    [_instance renderWithURL:url options:@{@"bundleUrl":[url absoluteString]} data:nil];
    
    __weak typeof(self) weakSelf = self;
    _instance.onCreate = ^(UIView *view) {
        [weakSelf.weexView removeFromSuperview];
        weakSelf.weexView = view;
        [weakSelf.view addSubview:weakSelf.weexView];
    };
    
    _instance.onFailed = ^(NSError *error) {
        //处理失败回调的逻辑。
        NSLog(@"Weex On Failed : %@", error.localizedDescription);
    };
    
    _instance.renderFinish = ^ (UIView *view) {
        //处理页面渲染完成的逻辑。
        NSLog(@"Weex Render Finished");
    };
}

- (void)dealloc {
    [_instance destroyInstance];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
