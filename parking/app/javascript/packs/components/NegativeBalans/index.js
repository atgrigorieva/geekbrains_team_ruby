import React from 'react';
import { Link } from 'react-router-dom';

export default class NegativeBalans extends React.Component {
  render() {
    const { car, driver, credit } = this.props;
    return (
      <div className="card">
        <div className="card-body">
          <h5 className="card-title">
            <span className="badge badge-danger">
              Внимание! Для выезда необходимо погасить задолженность
            </span>
          </h5>
          <p className="card-text">Автомобиль, номер: {car}</p>
          <p className="card-text">Водитель: {driver}</p>
          <p className="card-text">Баланс: {credit}</p>
          <Link to="/operatorpay" className="btn btn-danger">
            Оплатить
          </Link>
        </div>
      </div>
    );
  }
}
