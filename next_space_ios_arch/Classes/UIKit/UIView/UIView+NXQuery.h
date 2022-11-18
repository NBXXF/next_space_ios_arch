//
//  UIView+ForViewController.h
//  JLRoutes
//
//  Created by XXF on 2022/10/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView(NXQuery)

/**
 找到最近的viewcontroller,不能在new 等没有显示出来的生命周期去访问
 */
- (UIViewController * __nullable)findViewController;

/**
  向上查找对应的view
 */
- (UIView * __nullable)findSuperViewWithClass:(Class)superClazz;

/**
  向上查找对应的view
 */
- (UIView * __nullable)findSuperViewWithBlock:(BOOL (^)(UIView *superView))block;

/**
 按展示原点x,y顺序排序的subviews
 */
-(NSArray<UIView *> *)findSortedSubviews;




/**
 找到view弟弟 从左
 */
- (UIView * __nullable)findYoungerBrotherView;

/**
 找到哥哥View
 */
- (UIView * __nullable)findOlderBrotherView;

/**
 查询满足条件的第一个子view
 */
-(UIView * __nullable)findFirstChildViewWithBlock:(BOOL (^)(UIView *childView))block deepQuery:(BOOL)deepQuery;


/**
 查询满足条件的最后一个子view
 */
-(UIView * __nullable)findLastChildViewWithBlock:(BOOL (^)(UIView *childView))block deepQuery:(BOOL)deepQuery;

/**
 查询满足条件的所有子view
 */
-(NSArray<UIView *> * __nullable)findChildViewWithBlock:(BOOL (^)(UIView *childView))block deepQuery:(BOOL)deepQuery;


//是否是输入组件
-(BOOL)isTextInputView;

/**
 查找当前子集第一个有焦点的组件
 */
- (UIView <UIKeyInput> * __nullable)findFirstFocusedTextInput;

/**
 查找当前自己第一个能获取焦点的组件
 */
- (UIView <UIKeyInput> * __nullable)findFirstTextInput;


@end

NS_ASSUME_NONNULL_END
