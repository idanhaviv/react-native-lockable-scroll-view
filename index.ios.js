import React from 'react';
import { View, ListView, StyleSheet, Text, AppRegistry, Image, Button } from 'react-native';
import LockScrollView from './LockScrollView';
 
const styles = StyleSheet.create({
  container: {
    flex: 1,
    marginTop: 20,
  },
});

class ListViewDemo extends React.Component {
  constructor(props) {
    super(props);
    this._data = ['0', '1', '2']
    this._latestImage = 2
    const ds = new ListView.DataSource({rowHasChanged: (r1, r2) => r1 !== r2});
    this.state = {
      dataSource: ds.cloneWithRows(this._data),
    };
  }

  addBelow() {
    this._latestImage = (this._latestImage + 1) % 3
    this._data = this._data.concat([`${this._latestImage}`])
    
    this.setState({
      dataSource: this.state.dataSource.cloneWithRows(this._data),
    });
  }

  addOnTop() {
    this._latestImage = (this._latestImage + 1) % 3
    this._data = [`${this._latestImage}`].concat(this._data)
    this.scrollView.lockBottomScrollOffset()
    this.setState({
      dataSource: this.state.dataSource.cloneWithRows(this._data),
    });
  }
  
  resetState() {
    this._data = ['0', '1', '2']
    this._latestImage = 2
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
          <Button
            onPress={() => this.resetState()}
            title="Reset State"
          />    
        </View>
         <ListView
         renderScrollComponent={props => <LockScrollView 
            ref={scrollView => {
              this.scrollView = scrollView
              }}
            {...props} />}
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
    case '0':
      return <Image
        source={require("./img/1.png")} />
    case '1':
      return <Image
        source={require("./img/2.png")} />
    case '2':
      return <Image
        source={require("./img/3.png")} />
    default:
      return <Image
        source={require("./img/3.png")} />
  }
}

export default ListViewDemo;


AppRegistry.registerComponent('LockableScrollView', () => ListViewDemo);
