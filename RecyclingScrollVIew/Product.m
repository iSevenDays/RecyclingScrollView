//for test
#import "Product.h"
@implementation Product
@synthesize name;
- (id)initWithIdent:(NSInteger)identif andName:(NSString *)nam
{
  self = [super init];
  if(self)
  {
    ident = identif;
    name = nam;
  }
  return self;
}
@end
