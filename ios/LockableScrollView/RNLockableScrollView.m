#import "RNLockableScrollView.h"
#import "RCScrollView.h"

@implementation RNLockableScrollView

@dynamic scrollView;

- (instancetype)initWithEventDispatcher:(RCTEventDispatcher *)eventDispatcher 
{
    if (self = [super initWithEventDispatcher:eventDispatcher]) {
        UIScrollView *scrollView = [super scrollView];
        //        scrollView.addObserver(self, forKeyPath: "contentSize", options: [.new, .old], context: nil)

        [scrollView addObserver:self forKeyPath:@"subviews" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context: nil];
        return self;
    }

    return nil;
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    
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
