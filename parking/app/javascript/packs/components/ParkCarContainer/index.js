import React, { Component } from 'react';
import { Link } from 'react-router-dom';

import GetPlace from '../GetPlace';
import CheckCarContainer from '../CheckCarContainer';

export default class ParkCarContainer extends Component {
  state = {
    isCarChecked: false,
    isFound: false,
    isReserved: false,
    carNumber: '',
    driver: '',
    parkingPlace: '',
    credit: 0,
    types: [],
    error: '',
  };

  checkCar = (data, carNumber = '', error = '') => {
    if (data.hasOwnProperty('error') && data['error']) {
      this.setState({
        error: data['message'],
      });
      return;
    }

    const { found = false, reserved = false, car_info = {}, rates = [] } = data;
    const { driver_name = '', parking_place = '', credit = 0 } = car_info;
    this.setState({
      isCarChecked: true,
      isFound: found,
      isReserved: reserved,
      carNumber: carNumber,
      driver: driver_name,
      parkingPlace: parking_place,
      credit: credit,
      types: rates.map(item => item[0]),
      error: error,
    });
  };

  finishParking = (parking_place, error = '') => {
    if (error) {
      this.setState({
        error: error,
      });
    } else {
      window.alert('Забронировано место - ' + parking_place);
      this.props.history.push('/');
    }
  };

  render() {
    const {
      isCarChecked,
      isFound,
      isReserved,
      carNumber,
      driver,
      parkingPlace,
      credit,
      types,
      error,
    } = this.state;

    if (error) {
      return (
        <div>
          <h3>Ошибка!</h3>
        </div>
      );
    }

    if (!isCarChecked) {
      return <CheckCarContainer checkCar={this.checkCar} enter={true} />;
    }

    if (!isReserved) {
      return isFound ? (
        <GetPlace finishParking={this.finishParking} />
      ) : (
        <GetPlace
          car={carNumber}
          driver={driver}
          types={types}
          finishParking={this.finishParking}
        />
      );
    }

    return (
      <div>
        Забронировано место {parkingPlace} <br />
        {credit < 0 ? `Имеется задолженность : ${credit}` : null}
        <Link to="/" className="btn btn-primary">
          На главную
        </Link>
      </div>
    );
  }
}
