RZSideBar
==========
在左/右边显示个浮动的按钮，点击按钮可像抽屉似的的拉开或关闭。见效果图：

[![](https://raw.github.com/ReyZhang/RZSideBar/master/Screens/1.gif)](https://raw.github.com/ReyZhang/RZSideBar/master/Screens/1.gif)
[![](https://raw.github.com/ReyZhang/RZSideBar/master/Screens/2.gif)](https://raw.github.com/ReyZhang/RZSideBar/master/Screens/2.gif)
How to use
==========
显示在左边

``` objective-c
/////实例方法，指定Direction为在左侧悬浮
self.sideBar = [[RZSideBar alloc] initWithDirection:SideBarDirectionLeft];
/////显示文本
self.sideBar.textLabel.text = @"点击显示结果面板->";
self.sideBar.textLabel.font= [UIFont systemFontOfSize:15];
//    self.sideBar.barViewColor = [UIColor redColor];  /////可设置bar的背景色
    
/////set content view
UITableView *tableView = [[UITableView alloc] init];
tableView.delegate = self;
tableView.dataSource = self;
tableView.backgroundColor = [UIColor clearColor];
[tableView registerNib:[UINib nibWithNibName:@"ListCell" bundle:nil] forCellReuseIdentifier:@"ListCell"];

/////设置内容视图
[self.sideBar setContentViewInSideBar:tableView];
/////实现代理
self.sideBar.delegate = self;
/////添加到当前视图中
[self.sideBar addInView:self.view];
```
效果见图2

显示在右边，只需要在上面代码实例化时指定Direction 为 SideBarDirectionRight就可以了
``` objective-c
/////实例方法，指定Direction为在右侧悬浮
self.sideBar = [[RZSideBar alloc] initWithDirection:SideBarDirectionRight];
```
代理方法
``` objective-c
- (void)sideBar:(RZSideBar *)sideBar didAppear:(BOOL)animated;
- (void)sideBar:(RZSideBar *)sideBar willAppear:(BOOL)animated;
- (void)sideBar:(RZSideBar *)sideBar didDisappear:(BOOL)animated;
- (void)sideBar:(RZSideBar *)sideBar willDisappear:(BOOL)animated;
```

Requirements
============
RZSideBar requires either iOS 5.0 and above.

License
============
RZSideBar is available under the MIT License. See the LICENSE file for more info.

ARC
============
RZLoopView uses ARC.

Contact
============
[Rey Zhang](http://github.com/ReyZhang) 

