#import "RNLockedScrollView.h"
#import "RCScrollView.h"

@implementation RNLockedScrollView

- (instancetype)initWithEventDispatcher:(RCTEventDispatcher *)eventDispatcher 
{
    if (self = [super initWithEventDispatcher:eventDispatcher]) {
        UIScrollView *scrollView = [super scrollView];
        //        scrollView.addObserver(self, forKeyPath: "contentSize", options: [.new, .old], context: nil)

        [scrollView addObserver:self forKeyPath:"subviews" options:[NSKeyValueObservingOptionOld, NSKeyValueObservingOptionNew] context: nil];
    }

    return nil;
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    
    if (keyPath == "subviews") {
        [UIView] *oldSubviews = change[NSKeyValueObservingOptionOld];
        NSLog("oldSubviews %@", oldSubviews);

        [UIView] *newSubviews = change[NSKeyValueObservingOptionNew];
        NSLog("newSubviews %@", newSubviews);
    }
}

- (void)scrollTo:(int)x y:(int)y animated:(BOOL)animated {
    NSLog("scrollTo %@ %@", x, y);
    UIScrollView *scrollView = [super scrollView];
    [sc setContentOffset:CGPointMake(x, y) animated:animated];
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
