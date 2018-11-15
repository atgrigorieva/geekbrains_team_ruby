import React from 'react';
import { render } from 'react-dom';

import Login from './components/Login';

document.addEventListener('DOMContentLoaded', () => {
  render(<Login />, document.getElementById('application'));})