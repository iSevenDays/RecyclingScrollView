#import "MainViewController.h"
#import "Data.h"
@interface MainViewController ()
{
  NSMutableArray *array;
  
  UITableView *tableForFirstPage;
  UITableView *tableForSecondPage;
  UITableView *tableForThirdPage;
}
@end

@implementation MainViewController
@synthesize delegate, topScrollView, bottomScrollView;
@synthesize prevIndex, currIndex, nextIndex;
@synthesize mainViewOfScroller;
- (void)initialize
{
  bottomScrollView.delegate = self;
  array = [[Data alloc] generateArray];
  tableForFirstPage = [[UITableView alloc] init];
  tableForSecondPage = [[UITableView alloc] init];
  tableForThirdPage = [[UITableView alloc] init];
  
  mainViewOfScroller.translatesAutoresizingMaskIntoConstraints = NO;
  tableForFirstPage.translatesAutoresizingMaskIntoConstraints = NO;
  tableForSecondPage.translatesAutoresizingMaskIntoConstraints = NO;
  tableForThirdPage.translatesAutoresizingMaskIntoConstraints = NO;
  
  tableForFirstPage.dataSource = self;
  tableForSecondPage.dataSource = self;
  tableForThirdPage.dataSource = self;
  
  mainViewOfScroller.backgroundColor = [UIColor grayColor];
  [mainViewOfScroller addSubview:tableForFirstPage];
  [mainViewOfScroller addSubview:tableForSecondPage];
  [mainViewOfScroller addSubview:tableForThirdPage];
  
  [bottomScrollView scrollRectToVisible:CGRectMake(320, 0, 320, bottomScrollView.frame.size.height) animated:NO];
  
  currIndex = 0;
  prevIndex = array.count - 1;
  nextIndex = 1;
  [self reloadTopLabels];
  [self setupConstraints];
}

- (void)reloadTables
{
  [tableForFirstPage reloadData];
  [tableForSecondPage reloadData];
  [tableForThirdPage reloadData];
  
  [tableForSecondPage scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
}
- (void)reloadTopLabels
{
  NSUInteger prevPrevIndex = 0, nextNextIndex;
  Data *prevPrev, *prev, *current, *next, *nextNext;
  
  if(prevIndex == 0)
    prevPrevIndex = array.count - 1;
  else
    prevPrevIndex = prevIndex - 1;
  
  if(nextIndex == array.count - 1)
    nextNextIndex = 0;
  else
    nextNextIndex = nextIndex + 1;
  
  prevPrev  = [array objectAtIndex:prevPrevIndex];
  prev      = [array objectAtIndex:prevIndex];
  current   = [array objectAtIndex:currIndex];
  next      = [array objectAtIndex:nextIndex];
  nextNext  = [array objectAtIndex:nextNextIndex];
  
  topScrollView.lblLeftLeft.text  = prevPrev.name;
  topScrollView.lblLeft.text      = prev.name;
  topScrollView.lblCenter.text    = current.name;
  topScrollView.lblRight.text     = next.name;
  topScrollView.lblRightRight.text= nextNext.name;
}

- (void)setupConstraints
{
  NSDictionary *views = NSDictionaryOfVariableBindings(tableForFirstPage, tableForSecondPage, tableForThirdPage, mainViewOfScroller, bottomScrollView, topScrollView);
  //320 * 3 = 960, we reserve a memory for 3 tables
  [mainViewOfScroller addConstraints:[NSLayoutConstraint
                                      constraintsWithVisualFormat:@"H:|[tableForFirstPage][tableForSecondPage(==tableForFirstPage)][tableForThirdPage(==tableForSecondPage)]|"
                                      options:0
                                      metrics:0
                                      views:views]];
  [mainViewOfScroller addConstraints:[NSLayoutConstraint
                                      constraintsWithVisualFormat:@"V:|[tableForFirstPage]|"
                                      options:0
                                      metrics:0
                                      views:views]];
  [mainViewOfScroller addConstraints:[NSLayoutConstraint
                                      constraintsWithVisualFormat:@"V:|[tableForSecondPage]|"
                                      options:0
                                      metrics:0
                                      views:views]];
  [mainViewOfScroller addConstraints:[NSLayoutConstraint
                                      constraintsWithVisualFormat:@"V:|[tableForThirdPage]|"
                                      options:0
                                      metrics:0
                                      views:views]];
}
#pragma mark TableView methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
  Data *item;
  if(tableView == tableForFirstPage)
    item = [array objectAtIndex:prevIndex];
  else if(tableView == tableForSecondPage)
    item = [array objectAtIndex:currIndex];
  else if(tableView == tableForThirdPage)
    item = [array objectAtIndex:nextIndex];
  
  Product *prod = [item.products objectAtIndex:indexPath.row];
  cell.textLabel.text = prod.name;
  
  return cell;
}
- (void)setDefaultScrollViewsPosition
{
  [bottomScrollView scrollRectToVisible:CGRectMake(320, 0, tableForSecondPage.frame.size.width, tableForSecondPage.frame.size.height) animated:NO];
  [topScrollView scrollRectToVisible:CGRectMake(120, 0, 320, topScrollView.frame.size.height) animated:YES];
}
- (void)swipeToLeft
{
  if(currIndex == 0)
    currIndex = array.count - 1;
  else
    currIndex--;
  
  if(currIndex == array.count - 1)
    nextIndex = 0;
  else
    nextIndex = currIndex + 1;
  
  if(currIndex == 0)
    prevIndex = array.count - 1;
  else
    prevIndex = currIndex - 1;
  [self reloadTopLabels];
  [self reloadTables];
  [self setDefaultScrollViewsPosition];
}
- (void)swipeToRight
{
  if(currIndex == array.count -1)
    currIndex = 0;
  else
    currIndex++;
  
  if(currIndex == array.count - 1)
    nextIndex = 0;
  else
    nextIndex = currIndex + 1;
  
  if(currIndex == 0)
    prevIndex = array.count - 1;
  else
    prevIndex = currIndex - 1;
  
  [self reloadTopLabels];
  [self reloadTables];
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
  offset.x /= defaultxOffsetOfBottomScrollView/defaultxOffsetOfTopScrollView;//about 2.66
  topScrollView.contentOffset = offset;
}
#pragma mark Other
- (void)viewDidLoad
{
  [self initialize];
  [super viewDidLoad];
}
-(void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    topScrollView.contentSize = CGSizeMake(120 + 320 + 120, topScrollView.frame.size.height);
    [topScrollView scrollRectToVisible:CGRectMake(120, 0, 320, 40) animated:NO];
  });
}
- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

@end
