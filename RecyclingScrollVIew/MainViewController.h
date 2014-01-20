#import <UIKit/UIKit.h>
#import "Product.h"
#import "TopScrollView.h"
@protocol MainViewControllerDelegate;
@class TopScrollView;
@interface MainViewController : UIViewController<UIScrollViewDelegate, UITableViewDataSource>
{
}
@property NSUInteger prevIndex;
@property NSUInteger currIndex;
@property NSUInteger nextIndex;
@property (weak, nonatomic) IBOutlet TopScrollView *topScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *bottomScrollView;
@property (weak, nonatomic) IBOutlet UIView *mainViewOfScroller;

@property (weak, nonatomic) id<MainViewControllerDelegate> delegate;

@end

@protocol MainViewControllerDelegate <NSObject>

- (void)MainViewController:(MainViewController* )controller itemsArray:(NSMutableArray *)array;
- (void)MainViewController:(MainViewController* )controller itemChanged:(NSInteger)index;
@end