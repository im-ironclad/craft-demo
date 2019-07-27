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
const btnPrevSelector = '.btn-prev';
const btnNextSelector = '.btn-next';
const slidesSelector = '.herousel__slide';

/**
 * Herousel Class
 */
export default class Herousel {
  constructor({ parent }) {
    this.parent = parent;
    this.btnPrev = parent.querySelector(btnPrevSelector);
    this.btnNext = parent.querySelector(btnNextSelector);
    this.slides = parent.querySelectorAll(slidesSelector);
    this.currentIndex = 0;
  }

  slideNext() {
    this.currentIndex++;

    if (this.currentIndex > this.slides.length - 1) {
      this.currentIndex = 0;
    }

    Array.from(this.slides).forEach((slide, i) => {
      slide.classList.toggle('active', i === this.currentIndex);
    });
  }

  slidePrev() {
    this.currentIndex--;

    if (this.currentIndex < 0) {
      this.currentIndex = this.slides.length - 1;
    }

    Array.from(this.slides).forEach((slide, i) => {
      slide.classList.toggle('active', i === this.currentIndex);
    });
  }

  attachListeners() {
    this.btnNext.addEventListener('click', () => {
      this.slideNext();
    });
    this.btnPrev.addEventListener('click', () => {
      this.slidePrev();
    });
  }

  init() {
    this.attachListeners();
  }
}
