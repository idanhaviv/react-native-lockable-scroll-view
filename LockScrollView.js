import React from 'react';
import PropTypes from 'prop-types';
import ReactNative, { findNodeHandle, requireNativeComponent, View, UIManager, ScrollView, Platform } from 'react-native';
import ScrollResponder from 'react-native/Libraries/Components/ScrollResponder';

class LockedScrollView extends React.Component {
  mixins: [ScrollResponder.Mixin]
  // getInitialState() {
  //   return this.scrollResponderMixinGetInitialState();
  // }
  setNativeProps(props) {
    this._scrollViewRef && this._scrollViewRef.setNativeProps(props);
  }
  getScrollResponder() {
    return this;
  }
  getScrollableNode() {
    return ReactNative.findNodeHandle(this._scrollViewRef);
  }
  scrollTo({ x, y, animated }) {
    if (Platform.OS === 'ios'){
      UIManager.dispatchViewManagerCommand(
        this.getScrollableNode(),
        UIManager.RCTLockableScrollView.Commands.scrollTo,
        [x || 0, y || 0, animated !== false],
      );
    } else {
      UIManager.dispatchViewManagerCommand(
        this.getScrollableNode(),
        UIManager.RCTScrollView.Commands.scrollTo,
        [x || 0, y || 0, animated !== false],
      );
    }
  }
  _scrollViewRef = null
  _setScrollViewRef(ref) {
    this._scrollViewRef = ref;
  }
  render() {
    return (
      <RCTLockedScrollView
        {...this.props}
        ref={this._setScrollViewRef}
        enabled={this.props.enabled}
        onScrollBeginDrag={this.scrollResponderHandleScrollBeginDrag}
        onScrollEndDrag={this.scrollResponderHandleScrollEndDrag}
        onScroll={this.scrollResponderHandleScroll}
        onMomentumScrollBegin={this.scrollResponderHandleMomentumScrollBegin}
        onMomentumScrollEnd={this.scrollResponderHandleMomentumScrollEnd}
        onStartShouldSetResponder={this.scrollResponderHandleStartShouldSetResponderCapture}
        onScrollShouldSetResponder={this.scrollResponderHandleScrollShouldSetResponder}
        onResponderGrant={this.scrollResponderHandleResponderGrant}
        onResponderTerminationRequest={this.scrollResponderHandleTerminationRequest}
        onResponderTerminate={this.scrollResponderHandleTerminate}
        onResponderRelease={this.scrollResponderHandleResponderRelease}
        onResponderReject={this.scrollResponderHandleResponderReject}
      >
        <View collapsable={false}>
          {this.props.children}
        </View>
      </RCTLockedScrollView>
    );
  }
}

LockedScrollView.propTypes = {
    ...ScrollView.propTypes,
    enabled: PropTypes.bool
}

var RCTLockedScrollView = requireNativeComponent('RCTLockableScrollView', LockedScrollView)

export default LockedScrollView;
