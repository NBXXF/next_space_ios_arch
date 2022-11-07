//
//  NXPasteboard.h
//  UIPasteboard的富文本 避免每次访问权限问题
//  Created by XXF on 2022/11/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NXPasteboard : NSObject
/**
 粘贴板唯一版本号
 */
@property(assign,nonatomic) NSInteger changeCount;
@property(nonatomic, copy) NSArray<NSString *> * pasteboardTypes;

@property(assign,nonatomic) NSInteger numberOfItems;
@property(nonatomic,copy) NSArray<NSDictionary<NSString *, id> *> *items;
@property(nullable,nonatomic,copy) NSString *string;
@property(nullable,nonatomic,copy) NSArray<NSString *> *strings;

@property(nullable,nonatomic,copy) NSURL *URL;
@property(nullable,nonatomic,copy) NSArray<NSURL *> *URLs;

@property(nullable,nonatomic,copy) UIImage *image;
@property(nullable,nonatomic,copy) NSArray<UIImage *> *images;

@property(nullable,nonatomic,copy) UIColor *color;
@property(nullable,nonatomic,copy) NSArray<UIColor *> *colors;

@property (nonatomic, assign) BOOL hasStrings;
@property (nonatomic, assign) BOOL hasURLs;
@property (nonatomic, assign) BOOL hasImages;
@property (nonatomic, assign) BOOL hasColors;

/**
 从系统剪切板拷贝到此类中来
 */
+(instancetype)copyFromPasteboard:(UIPasteboard *)pasteboard;


/**
 拷贝到application
 版本一致不会复制
 */
+(BOOL)copyToApplication:(UIPasteboard *)pasteboard;

/**
 从application 获取
 不会有权限问题,前提是先调用了copyToApplication
 */
+(instancetype)getFromApplication;

@end

NS_ASSUME_NONNULL_END
