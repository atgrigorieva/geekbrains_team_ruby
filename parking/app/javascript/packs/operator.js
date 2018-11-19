import React from 'react';
import { render } from 'react-dom';

import Operator from './components/Operator';

document.addEventListener('DOMContentLoaded', () => {
    render(<Operator />, document.getElementById('application'));})

