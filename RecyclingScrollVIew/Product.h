#import <Foundation/Foundation.h>

@interface Product : NSObject
{
  NSInteger ident;
}
@property NSString *name;
- (id)initWithIdent:(NSInteger)identif andName:(NSString *)name;
@end
