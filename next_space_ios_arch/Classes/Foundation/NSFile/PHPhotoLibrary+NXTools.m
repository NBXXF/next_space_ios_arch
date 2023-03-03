//
//  PHPhotoLibrary+CustomPhotoAlbum.m
//  next_space_ios_arch
//
//  Created by XXF on 2022/12/8.
//

#import "PHPhotoLibrary+NXTools.h"
#import "NXPermissionResult.h"
#import <next_space_ios_arch/NSError+NXTools.h>
typedef enum : NSUInteger {
    ImageTpye = 1,
    ImageUrlTpye,
    ImageDataTpye,
    videoType,
} SaveTypes;

@implementation PHPhotoLibrary (NXTools)

+ (NSInteger)noPermissionCode{
    return -403;
}
- (PHAssetCollection *)createNewAlbumCalled:(NSString *)albumName
{
    PHFetchResult<PHAssetCollection *> *collectionResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *collection in collectionResult) {
        if ([collection.localizedTitle isEqualToString:albumName]) {
            NSLog(@"相册存在：%@",albumName);
            return collection;
        }
    }

    __block NSString *collectionId = nil;
    NSError *error;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        collectionId = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:albumName].placeholderForCreatedAssetCollection.localIdentifier;
    } error:&error];
    if (!error) {
        NSLog(@"相册创建成功：%@",albumName);
        return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[collectionId] options:nil].firstObject;
    }else{
        NSLog(@"相册创建失败 error：%@",error);
        return nil;
    }
}

- (void)saveImageWithURL:(NSURL *)url
                 ToAlbum:(NSString *)albumName
              completion:(PHAssetLibraryWriteImageCompletionBlock)completion
                 failure:(PHAssetLibraryAccessFailureBlock)failure
{
    NSData *data=[NSData dataWithContentsOfURL:url];
    if(data){
        //优先用这种方式
        [self saveImageWithData:data ToAlbum:albumName completion:completion failure:failure];
    }else{
        //下面这种方式 会有格式缺陷(bmp就不行）
        [self saveObject:url WithType:ImageUrlTpye ToAlbum:albumName completion:^(id callbackObject) {
            completion((PHAsset *)callbackObject);
        } failure:^(NSError *error) {
            failure(error);
        }];
    }
}

- (RACSignal<PHAsset *> *)writeImageWithURL:(NSURL *)url
                                    toAlbum:(NSString *)albumName{
    return [[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [self saveImageWithURL:url ToAlbum:albumName completion:^(PHAsset *imageAsset) {
            [subscriber sendNext:imageAsset];
            [subscriber sendCompleted];
        } failure:^(NSError *error) {
            [subscriber sendError:error];
        }];
        return [RACDisposable disposableWithBlock:^{
        }];
    }] subscribeOnSubThread:YES];
}




- (void)saveImageWithData:(NSData *)imageData ToAlbum:(NSString *)albumName
               completion:(PHAssetLibraryWriteImageCompletionBlock)completion
                  failure:(PHAssetLibraryAccessFailureBlock)failure
{
    [self saveObject:imageData WithType:ImageDataTpye ToAlbum:albumName completion:^(id callbackObject) {
        completion((PHAsset *)callbackObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (RACSignal<PHAsset *> *)writeImageWithData:(NSData *)imageData
                                     toAlbum:(NSString *)albumName{
    return [[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [self saveImageWithData:imageData ToAlbum:albumName completion:^(PHAsset *imageAsset) {
            [subscriber sendNext:imageAsset];
            [subscriber sendCompleted];
        } failure:^(NSError *error) {
            [subscriber sendError:error];
        }];
        return [RACDisposable disposableWithBlock:^{
        }];
    }] subscribeOnSubThread:YES];
}


- (void)saveVideoWithURL:(NSURL *)url ToAlbum:(NSString *)albumName
              completion:(PHAssetLibraryWriteVideoCompletionBlock)completion
                 failure:(PHAssetLibraryAccessFailureBlock)failure{
    [self saveObject:url WithType:videoType ToAlbum:albumName completion:^(id callbackObject) {
        completion((NSURL *)callbackObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (RACSignal<NSURL *> *)writeVideoWithURL:(NSURL *)url
                                  toAlbum:(NSString *)albumName{
    return [[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [self saveVideoWithURL:url ToAlbum:albumName completion:^(NSURL *videoUrl) {
            [subscriber sendNext:videoUrl];
            [subscriber sendCompleted];
        } failure:^(NSError *error) {
            [subscriber sendError:error];
        }];
        return [RACDisposable disposableWithBlock:^{
        }];
    }] subscribeOnSubThread:YES];
}


- (void)saveObject:(id)object WithType:(SaveTypes)savetype ToAlbum:(NSString *)albumName completion:(void(^)(id callbackObject))completion failure:(void(^)(NSError *error))failure
{
   NXPermissionResult *permissionResult= [self canAccessPhotoAlbum];
    if (!permissionResult.enable) {
        // 提示用户开启允许访问相册的权限
        failure([NSError nx_ErrorWithCode:PHPhotoLibrary.noPermissionCode text:permissionResult.msg]);
    }else{
        __block NSString *assetId = nil;
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            assetId = [self getLocalIdentifierBy:object WithType:savetype];
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            NSLog(@"Finished updating asset. %@", (success ? @"Success." : error));
            if (error) {
                failure(error);
                return;
            }
            PHAssetCollection *collection = [self createNewAlbumCalled:albumName];
            [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:collection];
                PHAsset *asset = [PHAsset fetchAssetsWithLocalIdentifiers:@[assetId] options:nil].firstObject;
                [request addAssets:@[asset]];
            } completionHandler:^(BOOL success, NSError * _Nullable error) {
                NSLog(@"Finished updating asset. %@", (success ? @"Success." : error));
                if (success) {
                    if (savetype == ImageTpye || savetype == ImageUrlTpye || savetype == ImageDataTpye) {
                        completion([PHAsset fetchAssetsWithLocalIdentifiers:@[assetId] options:nil].firstObject);
                    }else{
                        [[PHImageManager defaultManager] requestAVAssetForVideo:[PHAsset fetchAssetsWithLocalIdentifiers:@[assetId] options:nil].firstObject options:nil resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
                            completion([(AVURLAsset *)asset URL]);
                        }];
                    }
                    return;
                }else{
                    failure(error);
                }
            }];
        }];
    }
}


- (NSString *)getLocalIdentifierBy:(id)object WithType:(SaveTypes)saveType
{
    if (saveType == ImageTpye) {
        return [PHAssetCreationRequest creationRequestForAssetFromImage:(UIImage *)object].placeholderForCreatedAsset.localIdentifier;
    }else if (saveType == ImageUrlTpye){
        return [PHAssetCreationRequest creationRequestForAssetFromImageAtFileURL:(NSURL *)object].placeholderForCreatedAsset.localIdentifier;
    }else if (saveType == ImageDataTpye){
        PHAssetCreationRequest *creationRequest = [PHAssetCreationRequest creationRequestForAsset];
        [creationRequest addResourceWithType:PHAssetResourceTypePhoto data:(NSData *)object options:nil];
        return creationRequest.placeholderForCreatedAsset.localIdentifier;
    }else{
        return [PHAssetCreationRequest creationRequestForAssetFromVideoAtFileURL:(NSURL *)object].placeholderForCreatedAsset.localIdentifier;
    }
}

- (id)getCallBackObjectBy:(NSString *)assetId WithType:(SaveTypes)saveType
{
    if (saveType == ImageTpye || saveType == ImageUrlTpye || saveType == ImageDataTpye) {
        return [PHAsset fetchAssetsWithLocalIdentifiers:@[assetId] options:nil].firstObject;
    }else{
        __block NSURL *url = nil;
        [[PHImageManager defaultManager] requestAVAssetForVideo:[PHAsset fetchAssetsWithLocalIdentifiers:@[assetId] options:nil].firstObject options:nil resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
            url = [(AVURLAsset *)asset URL];
        }];
        return url;
    }
}

- (void)loadImagesFromAlbum:(NSString *)albumName completion:(void (^)(NSMutableArray *images, NSError *error))completion
{
    NXPermissionResult *permissionResult= [self canAccessPhotoAlbum];
     if (!permissionResult.enable) {
         // 提示用户开启允许访问相册的权限
         completion([NSMutableArray array],[NSError nx_ErrorWithCode:PHPhotoLibrary.noPermissionCode text:permissionResult.msg]);
     }else{
        PHFetchResult<PHAssetCollection *> *collectionResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
        PHFetchOptions *fetchOptions = [PHFetchOptions new];
        fetchOptions.predicate = [NSPredicate predicateWithFormat:@"mediaType == %ld", PHAssetMediaTypeImage];
        fetchOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
        [collectionResult enumerateObjectsUsingBlock:^(PHAssetCollection * collection, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([collection.localizedTitle isEqualToString:albumName]) {
                PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:collection options:fetchOptions];
                __block NSMutableArray *imagesArr = [[NSMutableArray alloc] init];
                [fetchResult enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    PHAsset *asset = (PHAsset *)obj;
                    PHImageRequestOptions *option = [[PHImageRequestOptions alloc]init];
                    option.networkAccessAllowed = YES;
                    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeAspectFit options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                        BOOL downloadFinined = (![[info objectForKey:PHImageCancelledKey] boolValue] && ![info objectForKey:PHImageErrorKey]);
                        if (downloadFinined && result) {
                            [imagesArr addObject:result];
                            if (imagesArr.count == fetchResult.count) {
                                completion(imagesArr,nil);
                            }
                        }
                    }];
                }];
                *stop = YES;
                return;
            }
        }];
    }
}


//  判断授权状态
- (NXPermissionResult *)canAccessPhotoAlbum
{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusNotDetermined) {
        // User has not yet made a choice with regards to this application
        NSLog(@"用户还没有关于这个应用程序做出了选择");
        //return YES;
        return [[NXPermissionResult alloc] initWithEnable:YES andMsg:@"ok"];
    }else if (status == PHAuthorizationStatusRestricted){
        // This application is not authorized to access photo data.
        // The user cannot change this application’s status, possibly due to active restrictions
        //   such as parental controls being in place.
        NSLog(@"家长控制,不允许访问");
//        return NO;
        return [[NXPermissionResult alloc] initWithEnable:NO andMsg:@"家长控制,不允许访问"];
    }else if (status == PHAuthorizationStatusDenied){
        // User has explicitly denied this application access to photos data.
        NSLog(@"用户拒绝当前应用访问相册,我们需要提醒用户打开访问开关");
       // return NO;
        return [[NXPermissionResult alloc] initWithEnable:NO andMsg:@"用户拒绝当前应用访问相册"];
    }else if (status == PHAuthorizationStatusAuthorized){
        // User has authorized this application to access photos data.
        NSLog(@"用户允许当前应用访问相册");
        //return YES;
        return [[NXPermissionResult alloc] initWithEnable:YES andMsg:@"ok"];
    }else{
       // return NO;
        return [[NXPermissionResult alloc] initWithEnable:NO andMsg:@"无权限"];
    }
}

@end
