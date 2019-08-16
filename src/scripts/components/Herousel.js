/**
 * Herousel Component
 *
 * If you need to import anything, do so here
 */
import debounce from '../utilities/debounce';

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

  setParentHeight() {
    const totalHeight = this.btnPrev.clientHeight + this.slides[this.currentIndex].clientHeight;
    this.parent.style.height = `${totalHeight}px`;
  }

  slideNext() {
    this.currentIndex++;

    if (this.currentIndex > this.slides.length - 1) {
      this.currentIndex = 0;
    }

    // TODO: Fix bug on last slide.
    this.slides[this.currentIndex - 1].classList.add('out');
    setTimeout(() => {
      Array.from(this.slides).forEach((slide, i) => {
        slide.classList.toggle('active', i === this.currentIndex);
      });
      this.slides[this.currentIndex - 1].classList.remove('out');
    }, 500);
    this.setParentHeight();
  }

  slidePrev() {
    this.currentIndex--;

    if (this.currentIndex < 0) {
      this.currentIndex = this.slides.length - 1;
    }

    Array.from(this.slides).forEach((slide, i) => {
      slide.classList.toggle('active', i === this.currentIndex);
    });
    this.setParentHeight();
  }

  attachListeners() {
    window.addEventListener('resize', debounce(() => {
      this.setParentHeight();
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
    this.setParentHeight();
  }
}
