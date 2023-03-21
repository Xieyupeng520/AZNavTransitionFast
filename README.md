模仿系统转场效果（为了控制转场时间）

### 效果预览

push效果对比

<img src="gif/push转场对比.gif" alt="push转场对比" style="zoom:67%;" />

慢动作

<img src="gif/push转场对比_slow.gif" alt="push转场对比_slow" style="zoom:67%;" />

pop效果对比

<img src="gif/pop转场对比.gif" alt="pop转场对比" style="zoom:67%;" />

慢动作

<img src="gif/pop转场对比_slow.gif" alt="pop转场对比_slow" style="zoom:67%;" />

### 使用方式

已经封装好接口在导航控制器分类中，只需要

```objective-c
#import "UINavigationController+AZPushPopTransition.h"
```

然后在push和pop的时候分别调用

```objective-c
[self.navigationController pushViewControllerFast:vc animated:YES];
[self.navigationController popViewControllerFastAnimated:YES];
```

默认速度为0.2s，如果需要修改，可以去`AZPushPopTransition.m`中修改`kTransTime`的值。

