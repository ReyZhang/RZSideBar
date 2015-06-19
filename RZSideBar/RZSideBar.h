//
//  RZSideBar.h
//  CDRTranslucentSideBar
//
//  Created by Zhang Rey on 6/18/15.
//  Copyright (c) 2015 nscallop. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, sideBarDirection) {
    SideBarDirectionLeft = 0,
    SideBarDirectionRight,
};


@class RZSideBar;
@protocol RZSideBarDelegate <NSObject>
@optional
- (void)sideBar:(RZSideBar *)sideBar didAppear:(BOOL)animated;
- (void)sideBar:(RZSideBar *)sideBar willAppear:(BOOL)animated;
- (void)sideBar:(RZSideBar *)sideBar didDisappear:(BOOL)animated;
- (void)sideBar:(RZSideBar *)sideBar willDisappear:(BOOL)animated;
@end


@interface RZSideBar : UIView

@property (nonatomic, assign) CGFloat sideBarWidth;
@property (nonatomic, assign) CGFloat contentWidth;
@property (nonatomic, assign) CGFloat animationDuration;
@property (nonatomic, assign) sideBarDirection direction;
@property (readonly) BOOL hasShown;
@property (nonatomic,strong) UILabel *textLabel;


@property (nonatomic) id<RZSideBarDelegate> delegate;

/////实例方法
- (instancetype)init;
-(instancetype)initWithDirection:(sideBarDirection)direction;

////添加内容
- (void)setContentViewInSideBar:(UIView *)contentView;

////添加到父视图
-(void)addInView:(UIView *)superView;

//////显示
- (void)show;
- (void)showAnimated:(BOOL)animated;

/////隐藏
- (void)dismiss;
- (void)dismissAnimated:(BOOL)animated;

////旋转
-(void)layoutWhenRotation;

@end
