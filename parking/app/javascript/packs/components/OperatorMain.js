import React, { Component } from 'react';
import { NavLink } from 'react-router-dom';

export default class OperatorMain extends Component {
  render() {
    return (
      <div>
        <NavLink to="/operatorpark">
          <button type="button" className="btn btn-primary btn-lg btn-block mb-4">
            Въезд
          </button>
        </NavLink>
        <NavLink to="/operatorout">
          <button type="button" className="btn btn-primary btn-lg btn-block mb-4">
            Выезд
          </button>
        </NavLink>
        <NavLink to="/operatorpay">
          <button type="button" className="btn btn-primary btn-lg btn-block mb-4">
            Оплата
          </button>
        </NavLink>
      </div>
    );
  }
}
