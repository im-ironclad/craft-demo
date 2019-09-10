/**
 * Example Component
 *
 * If you need to import anything, do so here
 */
// import debounce from '../utilities/debounce';
// import breakpoints from '../utilities/breakpoints';

/**
 * Create selector variables
 */
// const exampleSelector = '.example-class';

/**
 * Example Class
 */
export default class Example {
  constructor({ parent }) {
    this.parent = parent;
    // this.example = parent.querySelector(exampleSelector);
  }

  /**
   * Method for attaching our event listeners
   */
  // attachListeners() {}

  init() {
    console.dir(this.parent); // eslint-disable-line
  }
}
