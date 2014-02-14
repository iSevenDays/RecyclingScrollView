#import "RecyclingScrollView.h"
#import "Data.h"
@interface RecyclingScrollView ()
{
@private
  NSMutableArray *arrayOfViews;
  UIView *leftView, *centerView, *rightView;
  BOOL isInitialized;
  NSUInteger numberOfViews;
}
@end

@implementation RecyclingScrollView
@synthesize delegate, topScrollView, bottomScrollView;
@synthesize prevIndex, currIndex, nextIndex;
@synthesize mainViewOfScroller;

- (void)initialize
{
  NSAssert(self.delegate != nil, @"delegate not set");
  numberOfViews = [self.delegate numberOfViewsInRecyclingScrollView:self];
  
  bottomScrollView.delegate = self;
  mainViewOfScroller.backgroundColor = [UIColor grayColor];
  [bottomScrollView scrollRectToVisible:CGRectMake(320, 0, 320, bottomScrollView.frame.size.height) animated:NO];
  
  leftView    = [[UIView alloc] init];
  centerView  = [[UIView alloc] init];
  rightView   = [[UIView alloc] init];
  
  leftView.translatesAutoresizingMaskIntoConstraints = NO;
  centerView.translatesAutoresizingMaskIntoConstraints = NO;
  rightView.translatesAutoresizingMaskIntoConstraints = NO;
  mainViewOfScroller.translatesAutoresizingMaskIntoConstraints = NO;

  [mainViewOfScroller addSubview:leftView];
  [mainViewOfScroller addSubview:centerView];
  [mainViewOfScroller addSubview:rightView];
  
  currIndex = 0;
  prevIndex = numberOfViews - 1;
  nextIndex = 1;
  
  [self reloadTopLabels];
  [self setupConstraints];
}

- (void)reload
{
  if(!isInitialized)
    [self initialize];
  [centerView.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    [obj removeFromSuperview];
  }];
  [leftView.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    [obj removeFromSuperview];
  }];
  [rightView.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    [obj removeFromSuperview];
  }];
  
  if(numberOfViews > 0)
    [centerView addSubview:[self.delegate recyclingScrollView:self viewAtIndex:0]];
  if(numberOfViews > 1)
    [rightView addSubview:[self.delegate recyclingScrollView:self viewAtIndex:1]];
  if(numberOfViews > 2)
    [leftView addSubview:[self.delegate recyclingScrollView:self viewAtIndex:2]];
  
}
- (void)reloadTopLabels
{
  NSUInteger prevPrevIndex = 0, nextNextIndex = 0;
  
  if(prevIndex == 0)
    prevPrevIndex = numberOfViews - 1;
  else
    prevPrevIndex = prevIndex - 1;
  
  if(nextIndex == numberOfViews - 1)
    nextNextIndex = 0;
  else
    nextNextIndex = nextIndex + 1;
  
  if(prevPrevIndex < numberOfViews)
    topScrollView.lblLeftLeft.text  = [delegate recyclingScrollView:self nameForViewAtIndex:prevPrevIndex];
  else
    topScrollView.lblLeftLeft.text = @"";
  
  topScrollView.lblLeft.text      = [delegate recyclingScrollView:self nameForViewAtIndex:prevIndex];
  topScrollView.lblCenter.text    = [delegate recyclingScrollView:self nameForViewAtIndex:currIndex];
  topScrollView.lblRight.text     = [delegate recyclingScrollView:self nameForViewAtIndex:nextIndex];
  
  if(nextNextIndex < [delegate numberOfViewsInRecyclingScrollView:self])
    topScrollView.lblRightRight.text = [delegate recyclingScrollView:self nameForViewAtIndex:nextNextIndex];
  else
    topScrollView.lblRightRight.text = @"";
}

- (void)setupConstraints
{
  NSDictionary *views = NSDictionaryOfVariableBindings(mainViewOfScroller, bottomScrollView, topScrollView, leftView,centerView, rightView);
  //320 * 3 = 960, we reserve a memory for 3 view controllers
  
  [mainViewOfScroller addConstraints:[NSLayoutConstraint
                                      constraintsWithVisualFormat:@"H:|[leftView][centerView(==leftView)][rightView(==centerView)]|"
                                       options:0
                                      metrics:0
                                      views:views]];
  [mainViewOfScroller addConstraints:[NSLayoutConstraint
                                      constraintsWithVisualFormat:@"V:|[leftView]|"
                                      options:0
                                      metrics:0
                                      views:views]];
  [mainViewOfScroller addConstraints:[NSLayoutConstraint
                                      constraintsWithVisualFormat:@"V:|[centerView]|"
                                      options:0
                                      metrics:0
                                      views:views]];
  [mainViewOfScroller addConstraints:[NSLayoutConstraint
                                      constraintsWithVisualFormat:@"V:|[rightView]|"
                                      options:0
                                      metrics:0
                                      views:views]];
}
#pragma mark TableView methods
- (void)setDefaultScrollViewsPosition
{
  [bottomScrollView scrollRectToVisible:CGRectMake(320, 0, 320, 0) animated:NO];
  [topScrollView scrollRectToVisible:CGRectMake(120, 0, 320, topScrollView.frame.size.height) animated:YES];
}
- (void)swipeToLeft
{
  if(currIndex == 0)
    currIndex = numberOfViews - 1;
  else
    currIndex--;
  
  if(currIndex == numberOfViews - 1)
    nextIndex = 0;
  else
    nextIndex = currIndex + 1;
  
  if(currIndex == 0)
    prevIndex = numberOfViews - 1;
  else
    prevIndex = currIndex - 1;
  [self reloadTopLabels];
  [self setDefaultScrollViewsPosition];
}
- (void)swipeToRight
{
  if(currIndex == numberOfViews -1)
    currIndex = 0;
  else
    currIndex++;
  
  if(currIndex == numberOfViews - 1)
    nextIndex = 0;
  else
    nextIndex = currIndex + 1;
  
  if(currIndex == 0)
    prevIndex = numberOfViews - 1;
  else
    prevIndex = currIndex - 1;
  
  [self reloadTopLabels];
  [self setDefaultScrollViewsPosition];
}
#pragma mark Scroll Events
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
  if(scrollView == bottomScrollView)
  {
    //moving right
    if(bottomScrollView.contentOffset.x > bottomScrollView.frame.size.width)
      [self swipeToRight];
    
    //moving left
    if(bottomScrollView.contentOffset.x < bottomScrollView.frame.size.width)
      [self swipeToLeft];
  }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
  CGPoint offset = CGPointMake(bottomScrollView.contentOffset.x, 0);
  
  CGFloat defaultxOffsetOfBottomScrollView = 320;
  CGFloat defaultxOffsetOfTopScrollView = 120;
  offset.x /= defaultxOffsetOfBottomScrollView/defaultxOffsetOfTopScrollView;//== about 2.66
  topScrollView.contentOffset = offset;
  NSLog(@"off: %f", offset.x);
}
#pragma mark Other
-(void)didMoveToSuperview
{
  [super didMoveToSuperview];
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    topScrollView.contentSize = CGSizeMake(120 + 320 + 120, topScrollView.frame.size.height);
    [topScrollView scrollRectToVisible:CGRectMake(120, 0, 320, 40) animated:NO];
  });
}


@end
