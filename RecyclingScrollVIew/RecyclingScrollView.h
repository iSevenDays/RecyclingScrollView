#import <UIKit/UIKit.h>
#import "Product.h"
#import "TopScrollView.h"
@protocol RecyclingScrollViewDelegate;
@class TopScrollView;
@interface RecyclingScrollView : UIView<UIScrollViewDelegate>
{
}
@property NSUInteger prevIndex;
@property NSUInteger currIndex;
@property NSUInteger nextIndex;
@property (weak, nonatomic) IBOutlet TopScrollView *topScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *bottomScrollView;
@property (weak, nonatomic) IBOutlet UIView *mainViewOfScroller;

@property (weak, nonatomic) id<RecyclingScrollViewDelegate> delegate;

- (void)reload;
@end

@protocol RecyclingScrollViewDelegate <NSObject>

@required
- (UIView *)recyclingScrollView:(RecyclingScrollView *)controller viewAtIndex:(NSUInteger)index;
- (NSString *)recyclingScrollView:(RecyclingScrollView *)controller nameForViewAtIndex:(NSUInteger)index;

///return number of views
/// @return NSUInteger count
- (NSUInteger)numberOfViewsInRecyclingScrollView:(RecyclingScrollView *)controller;

@optional
- (void)recyclingScrollView:(RecyclingScrollView *)controller viewChangedToIndex:(NSInteger)index;
- (NSUInteger)initialViewIndexForRecyclingScrollView:(RecyclingScrollView *)controller;
@end