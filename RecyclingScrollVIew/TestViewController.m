#import "TestViewController.h"
#import "Dict.h"

@implementation TestViewController
{
  Dict *items;
}
- (void)viewDidLoad
{
  [self initialize];
  self.recyclingScrollView.delegate = self;
  [self.recyclingScrollView reload];
}
- (void)initialize
{
  items = [[Dict alloc] init];
  
  UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
  UIViewController *vc1 = [sb instantiateViewControllerWithIdentifier:@"vc1"];
  UIViewController *vc2 = [sb instantiateViewControllerWithIdentifier:@"vc2"];
  UIViewController *vc3 = [sb instantiateViewControllerWithIdentifier:@"vc3"];
  
  [items addView:vc1.view withName:@"view1"];
  [items addView:vc2.view withName:@"view2"];
  [items addView:vc3.view withName:@"view3"];
}
- (NSUInteger)numberOfViewsInRecyclingScrollView:(RecyclingScrollView *)controller
{
  NSAssert(items != nil && items.views != nil, @"items and items.views can't be nil");
  NSLog(@"items views count: %d", items.views.count);
  return items.views.count;
}
- (NSString *)recyclingScrollView:(RecyclingScrollView *)controller nameForViewAtIndex:(NSUInteger)index
{
  NSAssert(items != nil && items.strings != nil, @"items and items.strings can't be nil");
  return [items.strings objectAtIndex:index];
}
- (UIView *)recyclingScrollView:(RecyclingScrollView *)controller viewAtIndex:(NSUInteger)index
{
  return [items.views objectAtIndex:index];
}

@end
