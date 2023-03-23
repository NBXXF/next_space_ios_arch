//
//  NXPasteboard.m
//  JLRoutes
//
//  Created by XXF on 2022/11/7.
//

#import "NXPasteboard.h"
#import <next_space_ios_arch/NSObject+NXAssociation.h>

@implementation NXPasteboard
const char *PASTE_DATA_KEY = "NXPasteboard";

+ (instancetype)copyFromPasteboard:(UIPasteboard *)pasteboard{
    NXPasteboard *myPasteboard=[[NXPasteboard alloc] init];
    myPasteboard.changeCount=pasteboard.changeCount;
    myPasteboard.changeCount=pasteboard.changeCount;
//    myPasteboard.pasteboardTypes=pasteboard.pasteboardTypes;
//
//    myPasteboard.numberOfItems=pasteboard.numberOfItems;
//    myPasteboard.items=pasteboard.items;
//    myPasteboard.string=pasteboard.string;
//    myPasteboard.strings=pasteboard.strings;
//
//    myPasteboard.URL=pasteboard.URL;
//    myPasteboard.URLs=pasteboard.URLs;
//
//    myPasteboard.image=pasteboard.image;
//    myPasteboard.images=pasteboard.images;
//
//    myPasteboard.hasStrings=pasteboard.hasStrings;
//    myPasteboard.hasURLs=pasteboard.hasURLs;
//    myPasteboard.hasImages=pasteboard.hasImages;
//    myPasteboard.hasColors=pasteboard.hasColors;
    
    return myPasteboard;
}

+ (BOOL)copyToApplication:(UIPasteboard *)pasteboard{
    NXPasteboard *myPasteboard= [self getFromApplication];
    
    //需要比较版本号是否一致的问题
    if(!myPasteboard || myPasteboard.changeCount!=pasteboard.changeCount){
        NSLog(@"===========>v1:%ld v2:%d",myPasteboard.changeCount,pasteboard.changeCount);
        myPasteboard=[self copyFromPasteboard:pasteboard];
        [UIApplication.sharedApplication nx_setAssociatedObject:myPasteboard forKey:@"NXPasteboard"];
        return YES;
    }
    return NO;
}

+ (instancetype)getFromApplication{
    NXPasteboard *myPasteboard= [UIApplication.sharedApplication nx_getAssociatedObject:@"NXPasteboard"];
    return myPasteboard;
}
@end
