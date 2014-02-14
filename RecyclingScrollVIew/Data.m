#import "Data.h"
#import "Product.h"
@implementation Data
{
  NSInteger ident;
}
@synthesize products, name;
- (id)initWithIdent:(NSInteger)iden andName:(NSString *)nam
{
  self = [super init];
  if(self)
  {
    ident = iden;
    name = nam;
    products = [[NSMutableArray alloc] init];
  }
  return self;
}
- (NSMutableArray *)generateArray
{
  NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:100];
  int howManyProducts = 1;
  for(int i = 0; i < 100 ; i++)
  {
    Data *element = [[Data alloc] initWithIdent:i andName:[NSString stringWithFormat:@"Set %d", i+1]];
    for(int z = 0; z < 100; z++)
    {
      Product *prod = [[Product alloc] initWithIdent:howManyProducts andName:[NSString stringWithFormat:@"Group %d", howManyProducts]];
      [[element products] addObject:prod];
      howManyProducts++;
    }
    [arr addObject:element];
  }
  return arr;
}
@end
