//
//  PodAsset.h
//  PodAsset
//
//
//

/**
 // Swift
 import PodAsset

 let bundle = PodAsset.bundle(forPod: "SomePod")
 let img = UIImage(named: "SomeDamnImage", in:bundle, compatibleWith:nil)
 // Objective-C
 @import PodAsset;

 NSBundle* bundle = [PodAsset bundleForPod:@"SomePod"];
 UIImage* img = [UIImage imageNamed:@"SomeDamnImage" inBundle:bundle compatibleWithTraitCollection:nil];
 Get the damn data:

 // Swift
 let data = PodAsset.data(forFilename: "SomeData.dat", pod: "SomePod")
 // Objective-C
 NSData* data = [PodAsset dataForFilename:@"SomeData.dat" pod:@"SomePod"];
 Get the damn json:

 // Swift
 let jsonString = PodAsset.string(forFilename: "SomeDamn.json", pod: "SomePod")
 // Objective-C
 NSString* jsonString = [PodAsset stringForFilename:@"SomeDamn.json" pod:@"SomePod"];
 */
#import <Foundation/Foundation.h>

@interface PodAsset : NSObject
+ (nullable NSURL*)urlForFilename:(nonnull NSString*)filename
                              pod:(nonnull NSString*)podName;

+ (nullable NSString*)pathForFilename:(nonnull NSString*)filename
                                  pod:(nonnull NSString*)podName;

+ (nullable NSData*)dataForFilename:(nonnull NSString*)filename
                                pod:(nonnull NSString*)podName;

+ (nullable NSString*)stringForFilename:(nonnull NSString*)filename
                                    pod:(nonnull NSString*)podName;

// returns the resource bundle path for the specified pod  
+ (nullable NSString*)bundlePathForPod:(nonnull NSString*)podName;

// return the resource bundle
+ (nullable NSBundle*)bundleForPod:(nonnull NSString*)podName;

// returns all assets in the bundle that contains the specified pod 
+ (nullable NSArray*)assetsInPod:(nonnull NSString*)podName;
@end
