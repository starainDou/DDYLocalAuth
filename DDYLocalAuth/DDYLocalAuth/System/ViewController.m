#import "ViewController.h"
#import "DDYLocalAuthTool.h"

#ifndef DDYTopH
#define DDYTopH (self.navigationController.navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height)
#endif

#ifndef DDYScreenW
#define DDYScreenW [UIScreen mainScreen].bounds.size.width
#endif

#ifndef DDYScreenH
#define DDYScreenH [UIScreen mainScreen].bounds.size.height
#endif

@interface ViewController ()

@property (nonatomic, strong) UIButton *button1;

@property (nonatomic, strong) UIButton *button2;

@end

@implementation ViewController

- (UIButton *)btnY:(CGFloat)y tag:(NSUInteger)tag title:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor lightGrayColor]];
    [button setFrame:CGRectMake(10, DDYTopH + y, DDYScreenW-20, 40)];
    [button setTag:tag];
    [button addTarget:self action:@selector(handleBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    return button;
}

- (UIButton *)button1 {
    if (!_button1) {
        _button1 = [self btnY: 50 tag:100 title:@""];
        _button1.enabled = NO;
    }
    return _button1;
}

- (UIButton *)button2 {
    if (!_button2) {
        _button2 = [self btnY:100 tag:101 title:@""];
    }
    return _button2;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.button1];
    [self.view addSubview:self.button2];
    
    if ([DDYLocalAuthTool checkSupportLocalIDType] == DDYLocalIDTypeNone) {
        self.button2.enabled = NO;
        [self.button1 setTitle:@"该设备不支持TouchID/FaceID" forState:UIControlStateNormal];
        [self.button2 setTitle:@"该设备不支持TouchID/FaceID" forState:UIControlStateNormal];
    } else if ([DDYLocalAuthTool checkSupportLocalIDType] == DDYLocalIDTypeTouchID) {
        [self.button1 setTitle:@"该设备支持TouchID" forState:UIControlStateNormal];
        [self.button2 setTitle:@"点击该按钮验证TouchID" forState:UIControlStateNormal];
    } else if ([DDYLocalAuthTool checkSupportLocalIDType] == DDYLocalIDTypeFaceID) {
        [self.button1 setTitle:@"该设备支持FaceID" forState:UIControlStateNormal];
        [self.button2 setTitle:@"点击该按钮验证FaceID" forState:UIControlStateNormal];
    }
}

- (void)handleBtn:(UIButton *)sender {
    [DDYLocalAuthTool verifyReply:^(DDYLocalAuthState state) {
        NSLog(@"%ld", state);
    }];
}



@end
