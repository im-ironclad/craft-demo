/**
 * DigitalInsights Component
 *
 * If you need to import anything, do so here
 */
// import debounce from '../utilities/debounce';
// import breakpoints from '../utilities/breakpoints';

/**
 * Create variables
 */
const componentName = 'digital-insights';
const btnFilterSelector = `.${componentName}__header__btn-filter`;
const filterListSelector = `.${componentName}__header__filter-list`;
/**
 * DigitalInsights Class
 */
export default class Example {
  constructor({ parent }) {
    this.parent = parent;
    this.btnFilter = this.parent.querySelector(btnFilterSelector);
    this.filterList = this.parent.querySelector(filterListSelector);
  }

  /**
   * Method for toggling the active class on our btnFilter
   */
  toggleActiveClass() {
    this.filterList.classList.toggle('active');
  }

  /**
   * Method for attaching our event listeners
   */
  attachListeners() {
    this.btnFilter.addEventListener('click', () => {
      this.toggleActiveClass();
    });
  }

  init() {
    this.attachListeners();
  }
}
