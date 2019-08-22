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

  /**
   * Method for sliding to the next slide in the Herousel
   */
  slideNext() {
    this.currentIndex++;

    // We need a separate index to select our animation slide
    let animationIndex = this.currentIndex - 1;
    if (animationIndex > this.slides.length - 1) {
      animationIndex = 0;
    }

    if (this.currentIndex > this.slides.length - 1) {
      this.currentIndex = 0;
    }

    // Out the out class for the animation out
    this.slides[animationIndex].classList.add('out');

    // After 500ms, toggle the active class and remove the out class
    setTimeout(() => {
      Array.from(this.slides).forEach((slide, i) => {
        slide.classList.toggle('active', i === this.currentIndex);
      });
      this.slides[animationIndex].classList.remove('out');
    }, 500);

    // Reset the parentHeight
    this.setParentHeight();
  }

  /**
   * Method for sliding to the prev slide in the Herousel
   */
  slidePrev() {
    this.currentIndex--;

    // We need a separate index to select our animation slide
    let animationIndex = this.currentIndex + 1;
    if (animationIndex < 0) {
      animationIndex = this.slides.length - 1;
    }

    if (this.currentIndex < 0) {
      this.currentIndex = this.slides.length - 1;
    }

    // Out the out class for the animation out
    this.slides[animationIndex].classList.add('out');

    // After 500ms, toggle the active class and remove the out class
    setTimeout(() => {
      Array.from(this.slides).forEach((slide, i) => {
        slide.classList.toggle('active', i === this.currentIndex);
      });
      this.slides[animationIndex].classList.remove('out');
    }, 500);

    // Reset the parentHeight
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
