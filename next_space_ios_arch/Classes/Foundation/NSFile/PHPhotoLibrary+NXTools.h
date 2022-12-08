//
//  PHPhotoLibrary+CustomPhotoAlbum.h
//  next_space_ios_arch
//
//  Created by XXF on 2022/12/8.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

typedef void(^PHAssetLibraryWriteImageCompletionBlock)(PHAsset *imageAsset);

typedef void(^PHAssetLibraryWriteVideoCompletionBlock)(NSURL *videoUrl);

typedef void(^PHAssetLibraryAccessFailureBlock)(NSError *error);

@interface PHPhotoLibrary (NXTools)

@property(nonatomic,assign,class,readonly) NSInteger noPermissionCode;

// 创建一个相册
- (PHAssetCollection *)createNewAlbumCalled:(NSString *)albumName;

/**
 *  通过一个图片的本地url保存该图片到某一个相册里
 *
 *  @param url 图片
 *  @param albumName 相册名
 *  @param completion 完成
 *  @param failure 失败
 */
- (void)saveImageWithURL:(NSURL *)url ToAlbum:(NSString *)albumName completion:(PHAssetLibraryWriteImageCompletionBlock)completion failure:(PHAssetLibraryAccessFailureBlock)failure;


/**
 *  保存一个imageData对象到某一个相册里
 *
 *  @param imageData 图片
 *  @param albumName 相册名
 *  @param completion 完成
 *  @param failure 失败
 */
- (void)saveImageWithData:(NSData *)imageData ToAlbum:(NSString *)albumName completion:(PHAssetLibraryWriteImageCompletionBlock)completion failure:(PHAssetLibraryAccessFailureBlock)failure;


/**
 *  通过一个视频的本地url保存该视频到某一个相册里
 *
 *  @param videoUrl 视频路径
 *  @param albumName 相册名
 *  @param completion 完成
 *  @param failure 失败
 */
- (void)saveVideoWithURL:(NSURL *)url ToAlbum:(NSString *)albumName completion:(PHAssetLibraryWriteVideoCompletionBlock)completion failure:(PHAssetLibraryAccessFailureBlock)failure;


/**
 *  获取photos app创建的相册里所有图片
 *
 *  @param albumName 相册名
 *  @param completion 完成
 */
- (void)loadImagesFromAlbum:(NSString *)albumName completion:(void (^)(NSMutableArray *images, NSError *error))completion;


@end
