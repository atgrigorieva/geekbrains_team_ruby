import React, { Component } from 'react';
import { BrowserRouter, Switch, Route } from 'react-router-dom';

import 'bootstrap/dist/css/bootstrap.min.css';
import OperatorMain from '../OperatorMain';
import ParkCarContainer from '../ParkCarContainer';
import OutCarContainer from '../OutCarContainer';
import PayParkingContainer from '../PayParkingContainer';

export default class Operator extends Component {
  render() {
    return (
      <BrowserRouter>
        <Switch>
          <Route path="/operatorpark" component={ParkCarContainer} exact />
          <Route path="/operatorout" component={OutCarContainer} exact />
          <Route path="/operatorpay" component={PayParkingContainer} exact />
          <Route component={OperatorMain} />
        </Switch>
      </BrowserRouter>
    );
  }
}
