import React from 'react';
import { View, FlatList, StyleSheet, Text, AppRegistry, Image, Button } from 'react-native';
import LockScrollView from './LockScrollView';
 import uuid from 'uuid';

const styles = StyleSheet.create({
  container: {
    flex: 1,
    marginTop: 20,
  },
});

class ListViewDemo extends React.Component {
  constructor(props) {
    super(props);
    this._latestImage = 2
    this.state = {
      data: [{id: '0'},{id: '1'},{id: '2'}]
    };
  }

  addBelow() {
    this._latestImage = (this._latestImage + 1) % 3
    this.setState({
      data: this.state.data.concat([{id:`${this._latestImage}`}])
    });
  }

  addOnTop() {
    this._latestImage = (this._latestImage + 1) % 3
    this._data = [{id:`${this._latestImage}`}].concat(this._data)
    this.setState({
      data: [`${this._latestImage}`].concat(this.state.data)
    });
  }
  
  resetState() {
    this._latestImage = 2
    this.setState({
      data: this.state.data.cloneWithRows([{id: '0'},{id: '1'},{id: '2'}]),
    });
  }

  _keyExtractor = (item, index) => {
    console.log("extract index ", item.id)
    return item.id;
  }

  _renderItem = ({item}) => {
    switch (item.id) {
      case '0':
        return <Image
          id={uuid()}
          source={require("./img/1.png")} />
      case '1':
        return <Image
          id={uuid()}
          source={require("./img/2.png")} />
      case '2':
        return <Image
          id={uuid()}
          source={require("./img/3.png")} />
      default:
        return <Image
          source={require("./img/3.png")} />
    }
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
          <Button
            onPress={() => this.resetState()}
            title="Reset State"
          />    
        </View>
        <FlatList
          data={this.state.data}
          keyExtractor={this._keyExtractor}
          renderItem={this._renderItem}
          renderScrollComponent={props => <LockScrollView {...props} />}
          style={styles.container}
        />
      </View>
    );
  }
}

const getImage = (data) => {
  switch (data) {
    case '0':
      return <Image
        id={uuid()}
        source={require("./img/1.png")} />
    case '1':
      return <Image
        id={uuid()}
        source={require("./img/2.png")} />
    case '2':
      return <Image
        id={uuid()}
        source={require("./img/3.png")} />
    default:
      return <Image
        source={require("./img/3.png")} />
  }
}

export default ListViewDemo;


AppRegistry.registerComponent('LockableScrollView', () => ListViewDemo);
