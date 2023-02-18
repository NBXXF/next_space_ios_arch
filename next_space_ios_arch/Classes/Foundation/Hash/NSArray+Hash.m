
#import "HashUtils.h"
#import "NSArray+Hash.h"

@implementation NSArray (Hash)
///哈希的比较
- (NSUInteger)hash{
    
    NSUInteger hashCode = 1;
    for (int i = 0 ; i < self.count ; i++) {
        NSObject * obj = self[i];
        hashCode = KHashCodeConst * hashCode + [obj hash];
    }

    return hashCode;
}
@end
