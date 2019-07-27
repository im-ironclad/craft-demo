/**
 * Function for debouncing events
 * @param {function} func
 * @param {number} delay in ms
 * @returns {function}
 */
const debounce = (func, delay = 150) => {
  let timeout;
  return (...args) => {
    clearTimeout(timeout);
    timeout = setTimeout(() => {
      func.apply(this, args);
    }, delay);
  };
};

export default debounce;
