import React, { Component } from 'react';

import { URL_CAR_CHECK } from '../../const';
import CheckCar from '../CheckCar';
import { fetchJsonURL } from '../../utils';

export default class CheckCarContainer extends Component {
  state = {
    isLoading: false,
  };

  static defaultProps = {
    url: URL_CAR_CHECK,
    method: 'PATCH',
  };

  checkCar = carNumber => {
    const { url, method, enter, checkCar } = this.props;

    this.setState(state => {
      return {
        isLoading: true,
      };
    });

    fetchJsonURL(url, method, {
      //entert true - въезд, false - выезд
      enter: enter,
      car_number: { number: carNumber.toUpperCase() },
    })
      .then(data => data.json())
      .then(data => {
        console.log(data);
        this.setState(state => {
          return {
            isLoading: false,
          };
        });
        checkCar(data, carNumber);
      })
      .catch(error => {
        this.setState(state => {
          return {
            isLoading: false,
          };
        });
        checkCar({}, '', error);
      });
  };

  render() {
    const { isLoading } = this.state;

    if (isLoading) return <h3>Данные загружаются...</h3>;

    return <CheckCar handleSubmit={this.checkCar} />;
  }
}
