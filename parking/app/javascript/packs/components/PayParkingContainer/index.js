import React, { Component } from 'react';
import CheckCarContainer from '../CheckCarContainer';
import { URL_PAY_PARKING } from '../../const';
import PayForm from '../PayForm';

export default class PayParkingContainer extends Component {
  state = {
    isFound: false,
  };

  checkCar = (data, carNumber, error) => {
    if (error) {
      window.alert(error);
      return;
    }
    console.log(data);
    this.setState({
      isFound: true,
    });
  };

  render() {
    return (
      <div>
        <h1>Pay Parking</h1>
        {!this.state.isFound ? (
          <CheckCarContainer
            url={URL_PAY_PARKING}
            method="POST"
            enter={false}
            checkCar={this.checkCar}
          />
        ) : (
          <PayForm
            car="AAA777"
            driver="Michael Jackson"
            rate="year"
            debet={1000}
          />
        )}
      </div>
    );
  }
}
