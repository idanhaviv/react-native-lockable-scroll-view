// import React, { Component } from 'react';
// import {
//   ListView,
//   Text,
//   TouchableHighlight,
//   View,
//   StyleSheet,
//   ScrollView,
//   AppRegistry
// } from 'react-native';

import React from 'react';
import { View, ListView, StyleSheet, Text, AppRegistry, Image, Button } from 'react-native';

const styles = StyleSheet.create({
  container: {
    flex: 1,
    marginTop: 20,
  },
});

class ListViewDemo extends React.Component {
  constructor(props) {
    super(props);
    this._data = ['1', '2', '3'];
    const ds = new ListView.DataSource({rowHasChanged: (r1, r2) => r1 !== r2});
    this.state = {
      dataSource: ds.cloneWithRows(['1', '2', '3']),
    };
  }

  addBelow() {
    this._data = this._data.concat(['4'])
    this.setState({
      dataSource: this.state.dataSource.cloneWithRows(this._data),
    });
  }

  addOnTop() {
    this._data = this._data.concat(['4'])
    this.setState({
      dataSource: this.state.dataSource.cloneWithRows(this._data),
    });
  }

  render() {
    return (
      <View style={{flex:1}}>
        <View style={{flexDirection:"row", paddingTop:30}}>
          <Button
            onPress={() => this.addBelow()}
            title="Add Below"
          />    
          <Button
            onPress={() => this.addOnTop()}
            title="Add On Top"
          />    
        </View>
         <ListView
          style={styles.container}
          dataSource={this.state.dataSource}
          renderRow={(data) => getImage(data)
          }
        />
       
      </View>
    );
  }
}

const getImage = (data) => {
  switch (data) {
    case '1':
      return <Image
        source={require("./img/1.png")} />
    case '2':
      return <Image
        source={require("./img/2.png")} />
    default:
      return <Image
        source={require("./img/3.png")} />
  }
}

export default ListViewDemo;


AppRegistry.registerComponent('LockableScrollView', () => ListViewDemo);
