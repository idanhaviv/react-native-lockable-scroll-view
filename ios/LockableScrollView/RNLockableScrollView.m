#import "RNLockableScrollView.h"
#import <React/UIView+React.h>
#import <React/RCTUIManager.h>
#import <React/RCTBridge.h>

@interface RNLockableScrollView()

@property (nonatomic) NSArray *currentSubviews;

@end

@implementation RNLockableScrollView

@dynamic scrollView;

- (void)scrollToOffsetX:(CGFloat)x offsetY:(CGFloat)y animated:(BOOL)animated
{
  UIScrollView *scrollView = [super scrollView];
  [scrollView setContentOffset:CGPointMake(x, y) animated:animated];
}

- (void)insertReactSubview:(UIView *)view atIndex:(NSInteger)atIndex
{
  [super insertReactSubview:view atIndex:atIndex];
  //TODO: check if not called more than once; if so, make sure you register the observer once
  
  UIScrollView *scrollView = [super scrollView];
  UIView *contentView = [scrollView subviews][0];
  [contentView addObserver:self forKeyPath:@"layer.sublayers" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context: nil];
}

- (CGFloat)requiredScrollUpdateForAddedSubview:(UIView *)addedView {
  
    BOOL viewExceedsTopViewPort = addedView.frame.origin.y < [super scrollView].contentOffset.y;
    BOOL viewIsAddedToTopOfNonScrolledList = [super scrollView].subviews.count > 3 && addedView.frame.origin.y == 0; //2 subviews are the scrolling indicators
    if  (viewExceedsTopViewPort || viewIsAddedToTopOfNonScrolledList) {
      return addedView.frame.size.height;
    }
  
  return 0;
}

- (void)handleAddedSubview:(UIView *)subview {
  CGFloat verticalOffset = [self requiredScrollUpdateForAddedSubview:subview];
  if (verticalOffset > 0) {
    [self scrollTo:[super scrollView].contentOffset.x y:[super scrollView].contentOffset.y animated:NO];
  }
}

- (void)handleRemovedSubview:(UIView *)subview {
  if (subview.frame.origin.y < [super scrollView].contentOffset.y - 0.0001) {
    [self scrollTo:[super scrollView].contentOffset.x y:([super scrollView].contentOffset.y - subview.frame.size.height) animated:NO];
  }

}

- (UIView *)extractDiffWithPartialList:(NSArray *)partialList completeList:(NSArray *)completeList {
  for (UIView *view in completeList) {
    if (![partialList containsObject:view]) {
      return view;
    }
  }
  
  return nil;
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
  if (![keyPath  isEqual: @"layer.sublayers"] || ![object isKindOfClass:[UIView class]]) {
    return;
  }
  //TODO: make sure it's called for any number of added elements
  UIView *contentView = (UIView *)object;
  if ([[self currentSubviews] count] == contentView.subviews.count) {
    return;
  }
  
  if ([[self currentSubviews] count] > contentView.subviews.count) {
    UIView *diffSubView = [self extractDiffWithPartialList:contentView.subviews completeList:[self currentSubviews]];
    [self handleRemovedSubview: diffSubView];
  } else if ([[self currentSubviews] count] < contentView.subviews.count) {
    UIView *diffSubView = [self extractDiffWithPartialList:[self currentSubviews] completeList:contentView.subviews];
    [self handleAddedSubview: diffSubView];
  }
  
  [self setCurrentSubviews:contentView.subviews];
}

- (void)scrollTo:(int)x y:(int)y animated:(BOOL)animated {
    NSLog(@"scrollTo %d %d", x, y);
    UIScrollView *scrollView = [super scrollView];
    [scrollView setContentOffset:CGPointMake(x, y) animated:animated];
}

@end
