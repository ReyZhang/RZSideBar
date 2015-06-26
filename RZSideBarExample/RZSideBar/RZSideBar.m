//
//  RZSideBar.m
//  RZSideBarExample
//
//  Created by Zhang Rey on 6/18/15.
//  Copyright (c) 2015 Zhang Rey. All rights reserved.
//

#import "RZSideBar.h"

@interface RZSideBar ()

@property (nonatomic,strong) UIView *superView;
@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) UIView *barView;
@property (nonatomic,strong) UIView *containerView;
@property (nonatomic,strong) UITapGestureRecognizer *barTapGR;

//@property (nonatomic,assign) CGFloat bar
-(void)commonInit;

@end

@implementation RZSideBar



#pragma mark -- create instance method
/////实例方法
- (instancetype)init {
    if (self = [super init]) {
        [self commonInit];
    }
    return self;
}

-(instancetype)initWithDirection:(sideBarDirection)direction {
    if (self = [super init]) {
        
        [self commonInit];
        _direction  = direction;
    }
    return self;
}


-(void)commonInit {
    _direction = SideBarDirectionRight;
    _hasShown = NO;
    self.sideBarWidth = 30;
    self.contentWidth = 200;
    self.animationDuration = 0.25f;
    self.barViewColor = [UIColor blackColor];
    
    self.backgroundColor = [UIColor clearColor];
    
    [self addSubview:self.barView];
    [self addSubview:self.containerView];
    [self.barView addSubview:self.textLabel];
}


#pragma mark --- public method
////添加内容
- (void)setContentViewInSideBar:(UIView *)contentView {
    
    if (self.contentView != nil) {
        [self.contentView removeFromSuperview];
    }
    
    self.contentView = contentView;
    self.contentView.backgroundColor = [UIColor clearColor];
    [self.containerView addSubview:self.contentView];
    
    
}

////添加到父视图
-(void)addInView:(UIView *)view {
    
    self.superView  = view;
    [self.superView addSubview:self];
    
}

//////显示
- (void)show {
    [self showAnimated:YES];
}
- (void)showAnimated:(BOOL)animated {
    
    if (!_hasShown) {
        
        if ([self.delegate respondsToSelector:@selector(sideBar:willAppear:)]) {
            [self.delegate sideBar:self willAppear:animated];
        }
        _hasShown ^= 1;
        /////处理动画
        [self commonAnimated:animated];
    }
}


/////隐藏
- (void)dismiss {
    [self dismissAnimated:YES];
}

- (void)dismissAnimated:(BOOL)animated {
    
    if (_hasShown) {
        
        if ([self.delegate respondsToSelector:@selector(sideBar:willDisappear:)]) {
            [self.delegate sideBar:self willDisappear:animated];
        }
        
        /////处理动画
        _hasShown ^= 1;
        
        [self commonAnimated:animated];
    }
}


/////旋转
-(void)layoutWhenRotation {
    [self setNeedsLayout];
}


#pragma mark Private method
-(void)toggleSideBar {
    if (self.hasShown) {
        [self dismiss];
    }else {
        [self show];
    }
}



-(void)commonAnimated:(BOOL)animated {
    
    CGFloat moveToX = 0 ;
    if (self.hasShown)
        moveToX = (self.direction == SideBarDirectionRight) ? -self.contentWidth : self.contentWidth;
    else
        moveToX= (self.direction == SideBarDirectionRight) ? self.contentWidth : -self.contentWidth;
    
    /////处理动画
    if (animated) {
        
        [UIView animateWithDuration:self.animationDuration
                         animations:^{
                             CGRect frame = self.frame;
                             frame.origin.x += moveToX;
                             self.frame = frame;
                             
                         } completion:^(BOOL finished) {
                             
                             if (self.hasShown) {
                                 if ([self.delegate respondsToSelector:@selector(sideBar:didAppear:)]) {
                                     [self.delegate sideBar:self didAppear:animated];
                                 }
                             }else {
                                 if ([self.delegate respondsToSelector:@selector(sideBar:didDisappear:)]) {
                                     [self.delegate sideBar:self didDisappear:animated];
                                 }
                             }
                             
                             
                         }];
        
    }else {
        
        
        CGRect frame = self.frame;
        frame.origin.x += moveToX;
        self.frame = frame;
        
        if (self.hasShown) {
            if ([self.delegate respondsToSelector:@selector(sideBar:didAppear:)]) {
                [self.delegate sideBar:self didAppear:animated];
            }
        }else {
            if ([self.delegate respondsToSelector:@selector(sideBar:didDisappear:)]) {
                [self.delegate sideBar:self didDisappear:animated];
            }
        }
        
    }
    
}


#pragma mark --GETTER
-(UILabel *)textLabel {
    if (_textLabel == nil) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.backgroundColor = [UIColor clearColor];
        _textLabel.numberOfLines=0;
        _textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _textLabel.textColor = [UIColor whiteColor];
        
    }
    return _textLabel;
}

-(UIView *)barView {
    if (_barView == nil) {
        _barView = [UIView new];
        _barView.backgroundColor = [UIColor blackColor];
    }
    return _barView;
}

-(UIView *)containerView {
    if (_containerView == nil) {
        
        _containerView = UIView.new;
        _containerView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.9f];
        _containerView.layer.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7f].CGColor;
        _containerView.layer.shadowOffset = CGSizeMake(-2, 1);
        _containerView.layer.shadowOpacity = 0.5f;
        _containerView.layer.shadowRadius = 3;
    }
    return _containerView;
}


#pragma mark  --SETTER
-(void)setBarViewColor:(UIColor *)barViewColor {
    
    self.barView.backgroundColor = barViewColor;
    
    _barViewColor = barViewColor;
}

#pragma mark -- UIView lifeCircle
-(void)layoutSubviews {
    [super layoutSubviews];
    
    
    CGRect bounds = [[UIScreen mainScreen] bounds];
    bounds.size.height = self.superView.frame.size.height;
    
    NSString *text= self.textLabel.text;
    NSDictionary *attr = [NSDictionary dictionaryWithObjectsAndKeys:self.textLabel.font,NSFontAttributeName, nil];
    NSMutableAttributedString *atStr = [[NSMutableAttributedString alloc] initWithString:text attributes:attr];
    
    
    CGRect labelRect = [atStr boundingRectWithSize:CGSizeMake(20, bounds.size.height) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin context:nil];
    
    CGFloat barX = (self.direction == SideBarDirectionRight) ? 0.0f : self.contentWidth;
    /////计算barView的位置
    self.barView.frame = CGRectMake(barX,
                                    (bounds.size.height-labelRect.size.height-10)/2,
                                    self.sideBarWidth,
                                    labelRect.size.height+10); /////增加高度是uilabel的高度+10
    
    
    /////计算containerview的位置
    CGFloat containerX = (self.direction == SideBarDirectionRight) ?  self.sideBarWidth : 0.0f;
    self.containerView.frame = CGRectMake(containerX, 0, self.contentWidth, bounds.size.height);
    
    
    /////计算label的位置
    self.textLabel.frame = CGRectMake((self.sideBarWidth-labelRect.size.width)/2,
                                      (self.barView.frame.size.height-labelRect.size.height)/2,
                                      labelRect.size.width,
                                      labelRect.size.height);
    
    /////计算contentView的位置
    if (self.contentView != nil) {
        //        CGFloat contentX =(self.direction == SideBarDirectionRight) ? 20 : 0;
        self.contentView.frame = CGRectMake(0,
                                            0,
                                            self.contentWidth,
                                            bounds.size.height);
    }
    
    /////计算控件在父视图中的位置
    CGFloat selfX = (self.direction == SideBarDirectionRight) ? bounds.size.width - self.sideBarWidth :  -self.contentWidth;
    self.frame = CGRectMake(selfX,
                            0,
                            self.sideBarWidth+self.contentWidth,  //////由sidebarWidth + contentWidth 计算得到。
                            bounds.size.height);
    
}

#pragma mark --Touch Event
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint point  = [[touches anyObject] locationInView:self];
    
    if (CGRectContainsPoint(self.barView.frame, point)) {
        [self toggleSideBar];
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint point  = [[touches anyObject] locationInView:self];
    
    if (CGRectContainsPoint(self.barView.frame, point)) {
        
        
        
        
        
    }
}

@end
