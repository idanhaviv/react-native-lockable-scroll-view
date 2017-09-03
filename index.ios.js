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

const initialData = () => [{img: '0', key: uuid()},{img: '1', key: uuid()},{img: '2', key: uuid()}]
// const initialData = () => [{img: '0', key: uuid()}]

class ListViewDemo extends React.Component {
  constructor(props) {
    super(props);
    this._latestImage = 2
    this.state = {
      data: initialData()
    };
  }

  addBelow() {
    this._latestImage = (this._latestImage + 1) % 3
    this.setState({
      data: this.state.data.concat([{img:`${this._latestImage}`, key: uuid()}])
    });
  }

  addOnTop() {
    this._latestImage = (this._latestImage + 1) % 3
    this.setState({
      data: [{img: `${this._latestImage}`, key: uuid()}].concat(this.state.data)
    });
  }

  removeBelow() {
    this.setState({
      data: this.state.data.slice(0, this.state.data.length - 1)
    });
  }

  removeOnTop() {
    this.setState({
      data: this.state.data.slice(1, this.state.data.length)
    });
  }
  
  resetState() {
    this._latestImage = 2
    this.setState({
      data: initialData()
    });
  }
  _keyExtractor = (item, index) => {
    console.log("extract index ", item.key)
    return item.key;
  }

  _renderItem = ({item}) => {
    switch (item.img) {
      case '0':
        return <Image
          key={uuid()}
          source={require("./img/1.png")} />
      case '1':
        return <Image
          key={uuid()}
          source={require("./img/2.png")} />
      case '2':
        return <Image
          key={uuid()}
          source={require("./img/3.png")} />
      default:
        return <Image
          key={uuid()}
          source={require("./img/3.png")} />
    }
  }

  render() {
    return (
      <View style={{flex:1}}>
        <View style={{flexDirection:"row", paddingTop:30}}>
          <Button
            onPress={() => this.addBelow()}
            title="+Below"
          />    
          <Button
            onPress={() => this.addOnTop()}
            title="+Top"
          /> 
          <Button
            onPress={() => this.removeBelow()}
            title="-Below"
          />    
          <Button
            onPress={() => this.removeOnTop()}
            title="-Top"
          /> 
          <Button
            onPress={() => this.resetState()}
            title="Reset"
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

export default ListViewDemo;


AppRegistry.registerComponent('LockableScrollView', () => ListViewDemo);
