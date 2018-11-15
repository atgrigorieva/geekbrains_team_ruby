export const fetchJsonURL = (url, method, data) => {
  const token = getToken();

  return fetch(url, {
    headers: {
      Accept: 'application/json',
      'Content-Type': 'application/json',
      'X-CSRF-Token': token,
    },
    method: method,
    body: JSON.stringify(data),
  });
};

export const getToken = () => {
  let token;
  try {
    token = document.getElementsByName('csrf-token')[0].content;
  } catch (e) {
    token = '';
  }
  return token;
};
