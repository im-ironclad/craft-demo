/**
 * EmergingPerspectives Component
 *
 * If you need to import anything, do so here
 */
import debounce from '../utilities/debounce';
import breakpoints from '../utilities/breakpoints'

/**
 * Create selector variables
 */
const btnPrevSelector = '.js-prev';
const btnNextSelector = '.js-next';
const slidesContSelector = '.emerging-perspectives__image-cards';
const slidesSelector = '.image-card';

/**
 * EmergingPerspectives Class
 */
export default class EmergingPerspectives {
  constructor({ parent }) {
    this.parent = parent;
    this.btnPrev = parent.querySelector(btnPrevSelector);
    this.btnNext = parent.querySelector(btnNextSelector);
    this.slidesContainer = parent.querySelector(slidesContSelector);
    this.slides = this.slidesContainer.querySelectorAll(slidesSelector);
    this.currentIndex = 0;
  }

  setSlideContainerHeight() {
    const windowWidth = window.innerWidth;
    if (windowWidth < breakpoints.sm.min) {
      const totalHeight = this.slides[this.currentIndex].clientHeight;
      this.slidesContainer.style.height = `${totalHeight}px`;
    } else {
      this.slidesContainer.style.height = 'auto';
    }
  }

  slideNext() {
    this.currentIndex++;

    if (this.currentIndex > this.slides.length - 1) {
      this.currentIndex = 0;
    }

    Array.from(this.slides).forEach((slide, i) => {
      slide.classList.toggle('active', i === this.currentIndex);
    });

    setTimeout(() => { this.setSlideContainerHeight(); }, 300);
  }

  slidePrev() {
    this.currentIndex--;

    if (this.currentIndex < 0) {
      this.currentIndex = this.slides.length - 1;
    }

    Array.from(this.slides).forEach((slide, i) => {
      slide.classList.toggle('active', i === this.currentIndex);
    });

    setTimeout(() => { this.setSlideContainerHeight(); }, 300);
  }

  attachListeners() {
    window.addEventListener('resize', debounce(() => {
      this.setSlideContainerHeight();
    }, 50));

    this.btnNext.addEventListener('click', () => {
      this.slideNext();
    });
    this.btnPrev.addEventListener('click', () => {
      this.slidePrev();
    });
  }

  init() {
    this.attachListeners();
    this.setSlideContainerHeight();
  }
}
