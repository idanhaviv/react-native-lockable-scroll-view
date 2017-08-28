// #import <Foundation/Foundation.h>
// #import <React/RCTViewManager.h>
#import <React/RCTScrollContentViewManager.h>
#import "RNLockableScrollViewManager.h"
#import "RNLockedScrollView.h"
// #import <UIKit/UIKit.h>
#import "RCTBridge.h"
// @interface RCTLockableScrollViewManager : RCTViewManager
// @end

@implementation RNLockableScrollViewManager

RCT_EXPORT_MODULE()
// RCT_EXPORT_VIEW_PROPERTY(enabled, BOOL)

// - (UIView *)view
// {
//   return [[RNLockedScrollView alloc] init];
// }

- (UIView *)view
{
  return [[RNLockedScrollView alloc] initWithEventDispatcher:self.bridge.eventDispatcher];
}

RCT_EXPORT_METHOD(scrollTo:(int)x y:(int)y animated:(BOOL)animated)

@end
