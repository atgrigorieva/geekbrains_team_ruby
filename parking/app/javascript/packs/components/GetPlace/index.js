import React, { Component } from 'react';
import PropTypes from 'prop-types';

import './style.css';
import { fetchJsonURL } from '../../utils';
import { URL_GET_PLACE, URL_CAR_CREATE } from '../../const';

export default class GetPlace extends Component {
  static propTypes = {
    car: PropTypes.string,
    driver: PropTypes.string,
    types: PropTypes.array,
  };
  constructor(props) {
    super(props);

    const { car, driver } = this.props;

    this.state = car
      ? {
          car,
          driver,
          activeType: '',
          place: '',
        }
      : {
          activeType: '',
          place: '',
        };
  }

  handleChange = event => {
    this.setState({
      [event.target.name]: event.target.value,
    });
  };

  getPlace = event => {
    event.preventDefault();
    fetchJsonURL(URL_GET_PLACE, 'POST', {})
      .then(data => data.json())
      .then(data =>
        this.setState({
          place: data.free_place,
        })
      );
  };

  handleSubmit = event => {
    event.preventDefault();

    const { car, driver, activeType, place } = this.state;
    fetchJsonURL(URL_CAR_CREATE, 'POST', {
      car_setting: {
        number: car,
        region: car,
        driver_name: driver,
      },
      reservation: {
        rate: activeType,
        parking_place: place,
      },
    })
      .then(data => data.json())
      .then(data => {
        console.log(data);
        this.props.finishParking(place);
      })
      .catch(error => this.props.finishParking(place, error));
  };

  render() {
    const { car, driver, activeType, place } = this.state;
    return (
      <form className="form-signin">
        <h1 className="h3 mb-3 font-weight-normal">Парковка автомобиля</h1>
        <label className="sr-only">Номер машины</label>
        <input
          disabled={this.props.car}
          type="text"
          name="car"
          className="form-control"
          placeholder="Номер машины"
          value={car}
          onChange={this.handleChange}
        />
        <label className="sr-only">ФИО водителя</label>
        <input
          disabled={this.props.driver}
          type="text"
          name="driver"
          className="form-control"
          placeholder="ФИО водителя"
          value={driver}
          onChange={this.handleChange}
        />
        <label className="mr-sm-2 sr-only" htmlFor="inlineFormCustomSelect">
          Тип парковки
        </label>
        <select
          className="custom-select mr-sm-2"
          id="inlineFormCustomSelect"
          name="activeType"
          value={activeType}
          onChange={this.handleChange}
        >
          {this.props.types.map(type => {
            return (
              <option key={type} value={type}>
                {type}
              </option>
            );
          })}
        </select>
        <button
          className="btn btn-lg btn-primary btn-block"
          type="submit"
          onClick={this.getPlace}
          disabled={place}
        >
          {place ? `Место ${place}` : 'Получить место'}
        </button>
        <button
          className="btn btn-lg btn-primary btn-block"
          type="submit"
          onClick={this.handleSubmit}
        >
          Припарковать
        </button>
      </form>
    );
  }
}
