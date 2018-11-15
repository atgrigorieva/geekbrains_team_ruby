import React, { Component } from 'react';
import PropTypes from 'prop-types';

import { fetchJsonURL } from '../../utils';
import { URL_PAY_RESERVED } from '../../const';

export default class PayForm extends Component {
  static propTypes = {
    car: PropTypes.string,
    driver: PropTypes.string,
    rate: PropTypes.string,
    debet: PropTypes.number,
  };

  state = {
    paid: 0,
    isCashe: true,
  };

  handleChange = event => {
    this.setState({
      [event.target.name]: event.target.value,
    });
  };

  handleSubmit = event => {
    event.preventDefault();
    const { paid, isCashe } = this.state;
    fetchJsonURL(URL_PAY_RESERVED, 'PATCH', {
      car_number: {
        number: this.props.car,
        paid: paid,
        payment_type: +isCashe,
      },
    })
      .then(data => data.json())
      .then(data => {
        console.log(data);
        window.alert('Оплата принята');
        this.props.history.push('/');
      })
      .catch(error => window.alert(error));
  };

  render() {
    const { car, driver, rate, debet } = this.props;
    const { paid, isCashe } = this.state;
    return (
      <form className="form-signin">
        <h1 className="h3 mb-3 font-weight-normal">Оплата парковки</h1>
        <label>Номер машины</label>
        <input
          disabled={true}
          type="text"
          name="car"
          className="form-control"
          value={car}
        />
        <label>ФИО водителя</label>
        <input
          disabled={true}
          type="text"
          name="driver"
          className="form-control"
          value={driver}
        />
        <label>Тип парковки</label>
        <input
          disabled={true}
          type="text"
          className="form-control"
          name="rate"
          value={rate}
        />
        <label>Сумма к оплате</label>
        <input
          disabled={true}
          type="text"
          className="form-control"
          name="debet"
          value={debet}
        />
        <label>ОПЛАЧЕНО</label>
        <input
          type="number"
          className="form-control"
          name="paid"
          value={paid}
          onChange={this.handleChange}
        />
        <label className="mr-sm-2 " htmlFor="inlineFormCustomSelect">
          Тип оплаты
        </label>
        <select
          className="custom-select mr-sm-2"
          id="inlineFormCustomSelect"
          name="isCashe"
          value={isCashe}
          onChange={this.handleChange}
        >
          <option value={true}>Наличные</option>
          <option value={false}>Безнал</option>
        </select>
        <button
          className="btn btn-lg btn-primary btn-block"
          type="submit"
          onClick={this.handleSubmit}
        >
          Записать
        </button>
      </form>
    );
  }
}
