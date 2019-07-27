/**
 * Herousel Component
 *
 * If you need to import anything, do so here
 */
// import Component from './ExampleComponent';

/**
 * Create selector variables
 * (e.g. const btnPrevSelector = '.herousel__controls .btn-prev')
 */
// const someSelector = '.someclass'

/**
 * Herousel Class
 */
export default class Herousel {
  constructor({ parent }) {
    this.parent = parent;
  }

  init() {
    console.dir(this.parent); // eslint-disable-line
  }
}
