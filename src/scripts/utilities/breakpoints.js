// Breakpoints from src/styles/settings/_variables.scss
const screenSmMin = 768;
const screenMdMin = 992;
const screenLgMin = 1250;
const screenXlMin = 1500;

const breakpoints = {
  xs: {
    max: screenSmMin - 1,
  },
  sm: {
    min: screenSmMin,
    max: screenMdMin - 1,
  },
  md: {
    min: screenMdMin,
    max: screenLgMin - 1,
  },
  lg: {
    min: screenLgMin,
    max: screenXlMin - 1,
  },
  xl: {
    min: screenXlMin,
  },
};

export default breakpoints;
