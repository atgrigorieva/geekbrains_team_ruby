import React, { Component } from 'react';

import CheckCarContainer from '../CheckCarContainer';
import NegativeBalans from '../NegativeBalans';

export default class OutCarContainer extends Component {
  state = {
    isCarChecked: false,
    isPayed: false,
    carNumber: '',
    driver: '',
    parkingPlace: '',
    credit: 0,
    error: '',
  };

  reload = () => {
    this.setState({
      isCarChecked: false,
      isPayed: false,
      carNumber: '',
      driver: '',
      parkingPlace: '',
      credit: 0,
      error: '',
    });
  };

  componentDidUpdate() {
    if (this.state.error) {
      window.alert(this.state.error);
      this.reload();
    }
  }

  checkCar = (data = {}, carNumber = '', error = '') => {
    const { isPayed = false, car_info = {} } = data;
    if (data.hasOwnProperty('found') && !data['found']) {
      this.setState({
        error: data['message'],
      });
      return;
    }
    if (data.hasOwnProperty('error') && data['error']) {
      this.setState({
        error: data['message'],
      });
      return;
    }
    const { number = '', driver = '', debt = 0 } = car_info;
    this.setState({
      isCarChecked: true,
      isPayed: isPayed,
      carNumber: number,
      driver: driver,
      credit: debt,
      error: error,
    });
  };

  render() {
    const {
      isCarChecked,
      isPayed,
      carNumber,
      driver,
      credit,
      error,
    } = this.state;

    if (!isCarChecked) {
      return <CheckCarContainer checkCar={this.checkCar} enter={false} />;
    }

    if (!isPayed) {
      return <NegativeBalans car={carNumber} driver={driver} credit={credit} />;
    }

    window.alert('Выезд разрешен!');
    this.props.history.push('/');
  }
}
