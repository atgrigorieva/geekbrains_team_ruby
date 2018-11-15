import React, { Component } from 'react';
import { NavLink } from 'react-router-dom';
// import styles from './css.css';

export default class OperatorMain extends Component {
  render() {
    return (

      <React.Fragment>
      
      <div className="row row_div">

          <div id="div_road" className="col-6">
           <div>
              <img src={require('../../../../public/images/operator.png')} />
            </div>
           <div>
             <img src={require('../../../../public/images/road.png')} />
            </div>
          </div>
          <div id="div_road" className="col-6">
            <div className="logotype">
              <img src={require('../../../../public/images/logotype.png')} alt="Логотип"/>
            </div>

            <div>
              <form className="form_input">
                <div className="form-group">
                  <label for="exampleInputLogin">Логин</label>
                  <input type="text" className="form-control" id="exampleInputLogin" 
                    aria-describedby="LoginHelp" placeholder="Введите логин"/>
                  
                </div>
                <div className="form-group">
                  <label for="exampleInputPassword1">Пароль</label>
                  <input type="password" className="form-control" id="exampleInputPassword1" placeholder="Password"/>
                </div>

                <div id="button">                
                   
                   <a href="#" id="enter">Войти</a>
                </div>
              </form>
            </div>
          </div>
        </div>
      </React.Fragment>
    );
  }
}