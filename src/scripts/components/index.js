import Header from './Header';
import Herousel from './Herousel';
import EmergingPerspectives from './EmergingPerspectives';

const components = [
  {
    Component: Herousel,
    elsSelector: '.herousel'
  },
  {
    Component: EmergingPerspectives,
    elsSelector: '.emerging-perspectives'
  },
  {
    Component: Header,
    elsSelector: '.header'
  }
];

export default components;
