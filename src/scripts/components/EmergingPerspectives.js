/**
 * EmergingPerspectives Component
 *
 * If you need to import anything, do so here
 */
import debounce from '../utilities/debounce';
import breakpoints from '../utilities/breakpoints';

/**
 * Create selector variables
 */
const btnPrevSelector = '.js-prev';
const btnNextSelector = '.js-next';
const slidesContSelector = '.emerging-perspectives__image-cards';
const slidesFrameSelector = '.emerging-perspectives__image-cards__frame';
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
    this.slidesFrame = this.slidesContainer.querySelector(slidesFrameSelector);
    this.currentIndex = 0;
    this.numberOfActiveSlides = 1;
  }

  /**
   * Method for setting the number of active slides
   * 1 for mobile
   * 2 for tablet
   * 3 for desktop
   */
  setNumberOfActiveSlides() {
    const windowWidth = window.innerWidth;

    if (windowWidth < breakpoints.xs.max) {
      this.numberOfActiveSlides = 1;
    } else if (windowWidth >= breakpoints.sm.min && windowWidth <= breakpoints.lg.min) {
      this.numberOfActiveSlides = 2;
    } else {
      this.numberOfActiveSlides = 3;
    }
  }

  /**
   * Method for setting the slide containers height so there's no extra spacing
   */
  setSlideContainerHeight() {
    const windowWidth = window.innerWidth;
    if (windowWidth < breakpoints.sm.min) {
      const totalHeight = this.slides[this.currentIndex].clientHeight;
      this.slidesContainer.style.height = `${totalHeight}px`;
    } else {
      this.slidesContainer.style.height = 'auto';
    }
  }

  /**
   * Reset currentIndex and frame transform upon resizing
   */
  resetSlider() {
    this.currentIndex = 0;
    this.slidesFrame.style.transform = 'translateX(0)';
  }

  /**
   * Method for sliding to the next slide(s)
   */
  slideNext() {
    this.currentIndex++;

    if (
      this.currentIndex > this.slides.length - 1
      || this.currentIndex > this.slides.length - this.numberOfActiveSlides
    ) {
      this.currentIndex = 0;
    }

    const slideWidth = this.slides[this.currentIndex].clientWidth;
    const marginOffset = getComputedStyle(this.slides[this.currentIndex]).marginLeft;
    this.slidesFrame.style.transform = `translateX(calc((-${slideWidth}px - ${marginOffset}) * ${this.currentIndex}))`;

    setTimeout(() => { this.setSlideContainerHeight(); }, 300);
  }

  /**
   * Method for sliding to the previous slide(s)
   */
  slidePrev() {
    this.currentIndex--;

    if (this.currentIndex < 0) {
      this.currentIndex = this.slides.length - this.numberOfActiveSlides;
    }

    const slideWidth = this.slides[this.currentIndex].clientWidth;
    const marginOffset = getComputedStyle(this.slides[this.currentIndex]).marginLeft;
    this.slidesFrame.style.transform = `translateX(calc((-${slideWidth}px - ${marginOffset}) * ${this.currentIndex}))`;

    setTimeout(() => { this.setSlideContainerHeight(); }, 300);
  }

  /**
   * Method for attaching our event listeners
   */
  attachListeners() {
    // Watch the resize for setting our container height
    window.addEventListener('resize', debounce(() => {
      this.setSlideContainerHeight();
      this.resetSlider();
    }, 100));

    // Watch the resize for setting our numberOfActiveSlides
    window.addEventListener('resize', debounce(() => {
      this.setNumberOfActiveSlides();
    }, 250));

    // Hook up our next button
    this.btnNext.addEventListener('click', () => {
      this.slideNext();
    });

    // Hook up our previous button
    this.btnPrev.addEventListener('click', () => {
      this.slidePrev();
    });
  }

  init() {
    this.attachListeners();
    this.setSlideContainerHeight();
    this.setNumberOfActiveSlides();
  }
}
