/**
 * Header Component
 *
 * If you need to import anything, do so here
 */
import breakpoints from '../utilities/breakpoints';
import debounce from '../utilities/debounce';

/**
 * Create selector variables
 * (e.g. const btnPrevSelector = '.herousel__controls .btn-prev')
 */
const menuToggleSelector = '.btn-menu';
const menuCopySelector = '.btn-menu [class$="btn__copy"]';
const linksListSelector = '.header__nav__links';
const parentToggleSelector = '.header__nav__links__list__parent__toggle';

/**
 * Header Class
 */
export default class Header {
  constructor({ parent }) {
    this.parent = parent;
    this.menuToggle = this.parent.querySelector(menuToggleSelector);
    this.menuCopy = this.parent.querySelector(menuCopySelector);
    this.linksList = this.parent.querySelector(linksListSelector);
    this.parentToggles = Array.from(this.linksList.querySelectorAll(parentToggleSelector));
  }

  toggleMenuActiveClass() {
    this.parent.classList.toggle('nav-active');
    this.menuCopy.textContent = this.parent.classList.contains('nav-active')
      ? 'close'
      : 'menu';
  }

  static toggleParentActiveClass(e) {
    const parentList = e.currentTarget.parentNode;
    parentList.classList.toggle('active');
  }

  handleDisablingToggles() {
    const windowWidth = window.innerWidth;
    if (windowWidth > breakpoints.md.min) {
      this.parentToggles.forEach(toggle => {
        toggle.disabled = true;
      });
    } else {
      this.parentToggles.forEach(toggle => {
        toggle.disabled = false;
      });
    }
  }

  addListeners() {
    // Event listener for watching window width and disabling our parent toggles
    window.addEventListener('resize', debounce(() => {
      this.handleDisablingToggles();
    }));

    // Event listener for toggling active class on menu
    this.menuToggle.addEventListener('click', () => {
      this.toggleMenuActiveClass();
    });

    // Event Listener for parent nav links to open their child list
    this.parentToggles.forEach(toggle => {
      toggle.addEventListener('click', e => {
        this.constructor.toggleParentActiveClass(e);
      });
    });
  }

  init() {
    this.addListeners();
    this.handleDisablingToggles();
  }
}
