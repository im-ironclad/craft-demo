import './polyfills';

// Import components
import components from './utilities/components';

((function domReady() {
  // Loop through each component
  components.forEach(component => {
    // Get all the component elements on the page
    const componentEls = document.querySelectorAll(component.elsSelector);
    // For each element make it a new Component and initialize
    componentEls.forEach(el => {
      el = new component.Component({
        parent: el,
      });
      el.init();
    });
  });
})());
