#import "RNLockableScrollView.h"
#import <React/UIView+React.h>
//@interface RNLockableScrollView : RCTScrollView
//
////@property (nonatomic, readonly) UIScrollView *scrollView;
////@dynamic scrollView;
//- (instancetype)initWithEventDispatcher:(RCTEventDispatcher *)eventDispatcher NS_DESIGNATED_INITIALIZER;
//- (void)scrollTo:(int)x y:(int)y animated:(BOOL)animated;
//
//@end

@implementation RNLockableScrollView

@dynamic scrollView;

- (void)insertReactSubview:(UIView *)view atIndex:(NSInteger)atIndex
{
  [super insertReactSubview:view atIndex:atIndex];
  UIScrollView *scrollView = [super scrollView];
  UIView *contentView = [scrollView subviews][0];
  [contentView addObserver:self forKeyPath:@"layer.sublayers" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context: nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    NSLog(@"observeValueForKeyPath %@ with change %@", keyPath, change);
    if ([keyPath  isEqual: @"subviews"]) {
      NSArray *oldSubviews = [change objectForKey:@(NSKeyValueObservingOptionOld)];
      NSLog(@"oldSubviews %@", oldSubviews);
      
      NSArray *newSubviews = [change objectForKey:@(NSKeyValueObservingOptionNew)];
      NSLog(@"oldSubviews %@", newSubviews);
    }
}

- (void)scrollTo:(int)x y:(int)y animated:(BOOL)animated {
    NSLog(@"scrollTo %d %d", x, y);
    UIScrollView *scrollView = [super scrollView];
    [scrollView setContentOffset:CGPointMake(x, y) animated:animated];
}

- (void)didAddSubview:(UIView *)subview {
  NSLog(@"scrollTo %@", subview);
}

//    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//        if keyPath == "contentSize" {
//            let old = change![.oldKey]
//            print("old value \(old!)")
//
//            let new = change![.newKey]
//            print("new value \(new!)")
//            print("1contentOffset \(scrollView.contentOffset) contentSize \(scrollView.contentSize)")
//            if old as! CGSize != new as! CGSize {
//                scrollToLastPosition()
//            }
//        }
//
////        if keyPath == "contentOffset" {
////            lastScrollPosition = scrollView.contentOffset.y
////        }
//    }

@end
