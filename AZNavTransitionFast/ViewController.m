//
//  ViewController.m
//  testNavTransitionFast
//
//  Created by cocozzhang on 2023/3/9.
//

#import "ViewController.h"
#import "PushPopTransition.h"
#import "VCGlobalDataManager.h"

#define LOG_MORE 0

#define kTransitionTimeMin 0.1
#define kTransitionTimeMax 1

@interface ViewController () <UINavigationControllerDelegate, UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UISegmentedControl *transitionControl;
@property (weak, nonatomic) IBOutlet UILabel *showTimeLabel;
@property (weak, nonatomic) IBOutlet UISlider *transitionTimeControl;
@property (weak, nonatomic) IBOutlet UILabel *transitionTimeLabel;
@property (weak, nonatomic) IBOutlet UISwitch *slowAnimationControl;

@end

@implementation ViewController

static double time_didAppear = 0;
static double time_willDisappear = 0;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
#if LOG_MORE
    NSLog(@"viewDidLoad - %p", self);
#endif
    
    [self initTransitionTimeControl];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
#if LOG_MORE
    NSLog(@"viewWillAppear - %p", self);
#endif
    
    [self updateTransitionControl];
    [self updateTransitionTimeControl];
    [self updateSlowAnimationControl];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
    time_didAppear = CFAbsoluteTimeGetCurrent();
    NSLog(@"viewDidAppear - show cost time:%f", time_didAppear - time_willDisappear);
    
    [self updateShowTimeLabel];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    time_willDisappear = CFAbsoluteTimeGetCurrent();
#if LOG_MORE
    NSLog(@"viewWillDisappear - %p", self);
#endif
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
#if LOG_MORE
    NSLog(@"viewDidDisappear - %p", self);
#endif
}
#pragma mark -
- (void)initTransitionTimeControl {
    self.transitionTimeControl.minimumValue = kTransitionTimeMin;
    self.transitionTimeControl.maximumValue = kTransitionTimeMax;
}

- (void)updateShowTimeLabel {
    if (time_willDisappear <= 0) {
        self.showTimeLabel.text = nil;
    } else {
        self.showTimeLabel.text = [NSString stringWithFormat:@"本次转场耗时：%.3fs",time_didAppear - time_willDisappear];
    }
}

- (void)updateTransitionControl {
    if (VCGlobalDataManager.instance.useSystemTransition) {
        self.transitionControl.selectedSegmentIndex = 0;
    } else {
        self.transitionControl.selectedSegmentIndex = 1;
    }
    
    self.navigationController.delegate = VCGlobalDataManager.instance.useSystemTransition ? nil : self;
}

- (void)updateTransitionTimeControl {
    self.transitionTimeControl.value = VCGlobalDataManager.instance.transTime;
    self.transitionTimeLabel.text = [NSString stringWithFormat:@"设定转场时间：%.2fs", self.transitionTimeControl.value];
    
    BOOL useSystemTransition = VCGlobalDataManager.instance.useSystemTransition;
    self.transitionTimeControl.hidden = useSystemTransition;
    self.transitionTimeLabel.hidden = useSystemTransition;
}

- (void)updateSlowAnimationControl {
    self.slowAnimationControl.on = VCGlobalDataManager.instance.slowAnimations;
}

#pragma mark - action

- (IBAction)onTransitionSelected:(UISegmentedControl*)sender {
    BOOL useSystemTransition = (sender.selectedSegmentIndex == 0);//系统转场
    self.navigationController.delegate = useSystemTransition ? nil : self;
    
    self.transitionTimeControl.hidden = useSystemTransition;
    self.transitionTimeLabel.hidden = useSystemTransition;
    
    VCGlobalDataManager.instance.useSystemTransition = useSystemTransition;
}

- (IBAction)onTransitionTimeChanged:(UISlider*)sender {
    NSLog(@"onTransitionTimeChanged - %f", sender.value);
    
    //保留2位小数
    float value = [NSString stringWithFormat:@"%.2f", sender.value].floatValue;
    
    self.transitionTimeLabel.text = [NSString stringWithFormat:@"设定转场时间：%.2fs", value];
    VCGlobalDataManager.instance.transTime = value;
}
- (IBAction)onSlowAnimSwitched:(UISwitch*)sender {
    VCGlobalDataManager.instance.slowAnimations = sender.on;
    if (sender.on) {
        [[[[[UIApplication sharedApplication] windows] objectAtIndex:0] layer] setSpeed:.1f];
    } else {
        [[[[[UIApplication sharedApplication] windows] objectAtIndex:0] layer] setSpeed:1];
    }
}

#pragma mark - UINavigationControllerDelegate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC{
    NSAssert(operation != UINavigationControllerOperationNone, @"unknown operation");
    PushPopTransition *transition = [[PushPopTransition alloc] init];
    transition.operation = operation;
    transition.transTime = [VCGlobalDataManager instance].transTime;
    return transition;
}
@end
