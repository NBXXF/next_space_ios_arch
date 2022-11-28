//
//  NXKeyValueService.m
//  next_space_ios_arch
//
//  Created by XXF on 2022/11/27.
//

#import "NXKeyValueService.h"
#import <MMKV/MMKV.h>
#import <MMKV/MMKV-umbrella.h>
#import "XXF.h"

@interface NXKeyValueService()
@property(nonatomic,strong) MMKV *client;
@property(nonatomic,strong) RACSubject *subject;
@end
@implementation NXKeyValueService
/**
           * 在key 上面区分user存储,业务不要用这个
           * [注意 这个不能随便改] 会影响业务
           * [注意 这个不能随便改]
           */
static NSString *DIFFERUSER_PATH_SEGEMENT = @"_D_I_F_F_E_R_U_S_E_R_";


+ (NXKeyValueService *)shared{
    static NXKeyValueService *service=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        service = [[self alloc]init];
    });
    return service;
}


- (instancetype)init{
    self=[super init];
    if(self){
        NSString *myGroupID =XXF.getAppGroupName;
        if(!myGroupID || myGroupID.length==0){
            _client= [MMKV defaultMMKV];
        }else{
            _client= [MMKV mmkvWithID:myGroupID mode:MMKVMultiProcess];
        }
        
        self.subject = [RACSubject subject];
    }
    return self;
}

- (RACSignal<NSString *> *)observeChangeWithKey:(NSString *)key differUser:(BOOL)differUser{
    NSString *newKey=[self generateKey:key differUser:differUser];
    return [self.subject filter:^BOOL(id  _Nullable value) {
        return [value isEqualToString:newKey];
    }];
}





- (NSString * _Nonnull)generateKey:(NSString * _Nonnull)key differUser:(BOOL)differUser {
    if(differUser){
        NSString *userId=XXF.getUserId;
        if(!userId){
            userId=@"";
        }
        return [NSString stringWithFormat:@"%@_%@_%@",key,DIFFERUSER_PATH_SEGEMENT,userId];
    }else{
        return key;
    }
}


- (BOOL)isDifferUserForKey:(NSString * _Nonnull)key {
    return [key containsString:DIFFERUSER_PATH_SEGEMENT];
}



- (void)removeObjectForKey:(NSString *_Nonnull)key
                differUser:(BOOL)differUser{
    NSString *newKey=[self generateKey:key differUser:differUser];
    [self.client removeValueForKey:newKey];
    [self.subject sendNext:newKey];
}



- (void)setObject:(nullable id)value
           forKey:(NSString *_Nonnull)key
       differUser:(BOOL)differUser{
    NSString *newKey=[self generateKey:key differUser:differUser];
    [self.client setObject:value forKey:newKey];
    [self.subject sendNext:newKey];
}

- (nullable id)objectForKey:(NSString *_Nonnull)key
               defaultValue:(nullable id)defaultValue
                 differUser:(BOOL)differUser{
    NSString *newKey=[self generateKey:key differUser:differUser];
    return [self.client getObjectOfClass:NSObject.class forKey:newKey];
}




- (void)setString:(nullable NSString *)value
           forKey:(NSString *_Nonnull)key
       differUser:(BOOL)differUser{
    NSString *newKey=[self generateKey:key differUser:differUser];
    [self.client setString:value forKey:newKey];
    [self.subject sendNext:newKey];
}

- (nullable NSString *)stringForKey:(NSString *_Nonnull)key
                       defaultValue:(nullable NSString *)defaultValue
                         differUser:(BOOL)differUser{
    NSString *newKey=[self generateKey:key differUser:differUser];
    return [self.client getStringForKey:newKey defaultValue:defaultValue];
}




- (void)seData:(nullable NSData *)value
        forKey:(NSString *_Nonnull)key
    differUser:(BOOL)differUser{
    NSString *newKey=[self generateKey:key differUser:differUser];
    [self.client setData:value forKey:newKey];
    [self.subject sendNext:newKey];
}

- (nullable NSData *)dataForKey:(NSString *_Nonnull)key
                   defaultValue:(nullable NSData *)defaultValue
                     differUser:(BOOL)differUser{
    NSString *newKey=[self generateKey:key differUser:differUser];
    NSData *result= [self.client getObjectOfClass:NSData.class forKey:newKey];
    if(!result){
        return defaultValue;
    }
    return result;
}





- (void)setInteger:(NSInteger)value
            forKey:(NSString *_Nonnull)key
        differUser:(BOOL)differUser{
    NSString *newKey=[self generateKey:key differUser:differUser];
    [self.client setInt64:value forKey:newKey];
    [self.subject sendNext:newKey];
}

- (NSInteger)integerForKey:(NSString *_Nonnull)key
              defaultValue:(NSInteger)defaultValue
                differUser:(BOOL)differUser{
    NSString *newKey=[self generateKey:key differUser:differUser];
    return [self.client getInt64ForKey:newKey defaultValue:defaultValue];
}





- (void)setFloat:(float)value
          forKey:(NSString *_Nonnull)key
      differUser:(BOOL)differUser{
    NSString *newKey=[self generateKey:key differUser:differUser];
    [self.client setFloat:value forKey:newKey];
    [self.subject sendNext:newKey];
}

- (float)floatForKey:(NSString *_Nonnull)key
        defaultValue:(float)defaultValue
          differUser:(BOOL)differUser{
    NSString *newKey=[self generateKey:key differUser:differUser];
    return [self.client getFloatForKey:newKey defaultValue:defaultValue];
}





- (void)setDouble:(double)value
           forKey:(NSString *_Nonnull)key
       differUser:(BOOL)differUser{
    NSString *newKey=[self generateKey:key differUser:differUser];
    [self.client setDouble:value forKey:newKey];
    [self.subject sendNext:newKey];
}

- (double)doubleForKey:(NSString *_Nonnull)key
          defaultValue:(double)defaultValue
            differUser:(BOOL)differUser{
    NSString *newKey=[self generateKey:key differUser:differUser];
    return [self.client getDoubleForKey:newKey defaultValue:defaultValue];
}





- (void)setBool:(BOOL)value
         forKey:(NSString *_Nonnull)key
     differUser:(BOOL)differUser{
    NSString *newKey=[self generateKey:key differUser:differUser];
    [self.client setBool:value forKey:newKey];
    [self.subject sendNext:newKey];
}

- (BOOL)boolForKey:(NSString *_Nonnull)key
      defaultValue:(BOOL)defaultValue
        differUser:(BOOL)differUser{
    NSString *newKey=[self generateKey:key differUser:differUser];
    return [self.client getBoolForKey:newKey defaultValue:defaultValue];
}






@end
