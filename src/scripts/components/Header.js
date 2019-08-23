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
const navigationBlocksSelector = '.header__nav__blocks a'; // TODO re-order appropriately
const childLinksSelector = '.header__nav__links__list__parent__child-list__item a'; // TODO re-order appropriately

/**
 * Header Class
 * @todo try to abstract the tabindex forEach loops to a function with params:
 * - (elementsToChange, elementToCheck, classToReference)
 */
export default class Header {
  constructor({ parent }) {
    this.parent = parent;
    this.menuToggle = this.parent.querySelector(menuToggleSelector);
    this.menuCopy = this.parent.querySelector(menuCopySelector);
    this.linksList = this.parent.querySelector(linksListSelector);
    this.parentToggles = Array.from(this.linksList.querySelectorAll(parentToggleSelector));
    this.navigationBlocks = Array.from(this.parent.querySelectorAll(navigationBlocksSelector));
    this.childLinks = Array.from(this.parent.querySelectorAll(childLinksSelector));
  }

  /**
   * Method for toggling the active class on the navbar
   * and adjusting the button copy
   */
  toggleMenuActiveClass() {
    this.parent.classList.toggle('nav-active');
    this.menuCopy.textContent = this.parent.classList.contains('nav-active')
      ? 'close'
      : 'menu';
    // Update the tabindex of our navigationBlocks
    this.navigationBlocks.forEach(block => {
      block.tabIndex = this.parent.classList.contains('nav-active')
        ? 0
        : -1;
    });
    // Update the tabindex of our parentToggles
    this.parentToggles.forEach(toggle => {
      toggle.tabIndex = this.parent.classList.contains('nav-active')
        ? 0
        : -1;
    });
    // Update the tabindex of our child-list anchors,
    // We only want to do this > breakpoints.md.min
    if (window.innerWidth > breakpoints.md.min) {
      this.childLinks.forEach(child => {
        child.tabIndex = this.parent.classList.contains('nav-active')
          ? 0
          : -1;
      });
    }
  }

  /**
   * Method for toggling the active class on parent navigation-links
   */
  static toggleParentActiveClass(e) {
    const parentList = e.currentTarget.parentNode;
    const thisChildList = Array.from(e.currentTarget.nextElementSibling.children);
    // Toggle the active class on the parent
    parentList.classList.toggle('active');
    // Go through this parents children and adjust the tabindex to make them tab-able
    thisChildList.forEach(list => {
      list.firstElementChild.tabIndex = parentList.classList.contains('active')
        ? 0
        : -1;
    });
  }

  /**
   * Method for disabling the parent navigation links on desktop
   * because we only want that functionality on smaller viewports
   */
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

  /**
   * Attach all of our needed eventListeners
   */
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

  /**
   * Initialize our component
   */
  init() {
    this.addListeners();
    this.handleDisablingToggles();
  }
}
