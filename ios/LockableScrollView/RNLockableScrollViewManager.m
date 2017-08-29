// #import <Foundation/Foundation.h>
// #import <React/RCTViewManager.h>
//#import <React/RCTScrollContentViewManager.h>
#import "RNLockableScrollViewManager.h"
#import "RNLockableScrollView.h"
#import <React/RCTUIManager.h>
#import <React/RCTBridge.h>
//#import <React/RCTBridge.h>
//#import "RCTScrollView.h"
//#import "RCTShadowView.h"
//#import "RCTUIManager.h"
// #import <UIKit/UIKit.h>


// @interface RCTLockableScrollViewManager : RCTViewManager
// @end

@implementation RNLockableScrollViewManager

RCT_EXPORT_MODULE()
//RCT_EXPORT_METHOD(scrollTo:(int)x y:(int)y animated:(BOOL)animated)
// RCT_EXPORT_VIEW_PROPERTY(enabled, BOOL)

- (UIView *)view
{
  return [[RNLockableScrollView alloc] initWithEventDispatcher:self.bridge.eventDispatcher];
}

@end
