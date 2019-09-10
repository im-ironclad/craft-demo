!function s(o,a,l){function c(t,e){if(!a[t]){if(!o[t]){var n="function"==typeof require&&require;if(!e&&n)return n(t,!0);if(u)return u(t,!0);var i=new Error("Cannot find module '"+t+"'");throw i.code="MODULE_NOT_FOUND",i}var r=a[t]={exports:{}};o[t][0].call(r.exports,function(e){return c(o[t][1][e]||e)},r,r.exports,s,o,a,l)}return a[t].exports}for(var u="function"==typeof require&&require,e=0;e<l.length;e++)c(l[e]);return c}({1:[function(e,t,n){"use strict";function i(e,t){for(var n=0;n<t.length;n++){var i=t[n];i.enumerable=i.enumerable||!1,i.configurable=!0,"value"in i&&(i.writable=!0),Object.defineProperty(e,i.key,i)}}Object.defineProperty(n,"__esModule",{value:!0}),n.default=void 0;var r="digital-insights",s=".".concat(r,"__header__btn-filter"),o=".".concat(r,"__header__filter-list"),a=function(){function n(e){var t=e.parent;!function(e,t){if(!(e instanceof t))throw new TypeError("Cannot call a class as a function")}(this,n),this.parent=t,this.btnFilter=this.parent.querySelector(s),this.filterList=this.parent.querySelector(o)}return function(e,t,n){t&&i(e.prototype,t),n&&i(e,n)}(n,[{key:"toggleActiveClass",value:function(){this.filterList.classList.toggle("active")}},{key:"attachListeners",value:function(){var e=this;this.btnFilter.addEventListener("click",function(){e.toggleActiveClass()})}},{key:"init",value:function(){console.log(this.filterList),this.attachListeners()}}]),n}();n.default=a},{}],2:[function(e,t,n){"use strict";Object.defineProperty(n,"__esModule",{value:!0}),n.default=void 0;var i=s(e("../utilities/debounce")),r=s(e("../utilities/breakpoints"));function s(e){return e&&e.__esModule?e:{default:e}}function o(e,t){for(var n=0;n<t.length;n++){var i=t[n];i.enumerable=i.enumerable||!1,i.configurable=!0,"value"in i&&(i.writable=!0),Object.defineProperty(e,i.key,i)}}var a=function(){function n(e){var t=e.parent;!function(e,t){if(!(e instanceof t))throw new TypeError("Cannot call a class as a function")}(this,n),this.parent=t,this.btnPrev=t.querySelector(".js-prev"),this.btnNext=t.querySelector(".js-next"),this.slidesContainer=t.querySelector(".emerging-perspectives__image-cards"),this.slides=this.slidesContainer.querySelectorAll(".image-card"),this.slidesFrame=this.slidesContainer.querySelector(".emerging-perspectives__image-cards__frame"),this.currentIndex=0,this.numberOfActiveSlides=1}return function(e,t,n){t&&o(e.prototype,t),n&&o(e,n)}(n,[{key:"setNumberOfActiveSlides",value:function(){var e=window.innerWidth;e<r.default.xs.max?this.numberOfActiveSlides=1:e>=r.default.sm.min&&e<=r.default.lg.min?this.numberOfActiveSlides=2:this.numberOfActiveSlides=3}},{key:"setSlideContainerHeight",value:function(){if(window.innerWidth<r.default.sm.min){var e=this.slides[this.currentIndex].clientHeight;this.slidesContainer.style.height="".concat(e,"px")}else this.slidesContainer.style.height="auto"}},{key:"resetSlider",value:function(){this.currentIndex=0,this.slidesFrame.style.transform="translateX(0)"}},{key:"slideNext",value:function(){var e=this;this.currentIndex++,(this.currentIndex>this.slides.length-1||this.currentIndex>this.slides.length-this.numberOfActiveSlides)&&(this.currentIndex=0);var t=this.slides[this.currentIndex].clientWidth,n=getComputedStyle(this.slides[this.currentIndex]).marginLeft;this.slidesFrame.style.transform="translateX(calc((-".concat(t,"px - ").concat(n,") * ").concat(this.currentIndex,"))"),setTimeout(function(){e.setSlideContainerHeight()},300)}},{key:"slidePrev",value:function(){var e=this;this.currentIndex--,this.currentIndex<0&&(this.currentIndex=this.slides.length-this.numberOfActiveSlides);var t=this.slides[this.currentIndex].clientWidth,n=getComputedStyle(this.slides[this.currentIndex]).marginLeft;this.slidesFrame.style.transform="translateX(calc((-".concat(t,"px - ").concat(n,") * ").concat(this.currentIndex,"))"),setTimeout(function(){e.setSlideContainerHeight()},300)}},{key:"attachListeners",value:function(){var e=this;window.addEventListener("resize",(0,i.default)(function(){e.setSlideContainerHeight(),e.resetSlider()},100)),window.addEventListener("resize",(0,i.default)(function(){e.setNumberOfActiveSlides()},250)),this.btnNext.addEventListener("click",function(){e.slideNext()}),this.btnPrev.addEventListener("click",function(){e.slidePrev()})}},{key:"init",value:function(){this.attachListeners(),this.setSlideContainerHeight(),this.setNumberOfActiveSlides()}}]),n}();n.default=a},{"../utilities/breakpoints":17,"../utilities/debounce":18}],3:[function(e,t,n){"use strict";Object.defineProperty(n,"__esModule",{value:!0}),n.default=void 0;var i=s(e("../utilities/breakpoints")),r=s(e("../utilities/debounce"));function s(e){return e&&e.__esModule?e:{default:e}}function o(e,t){for(var n=0;n<t.length;n++){var i=t[n];i.enumerable=i.enumerable||!1,i.configurable=!0,"value"in i&&(i.writable=!0),Object.defineProperty(e,i.key,i)}}var a=function(){function n(e){var t=e.parent;!function(e,t){if(!(e instanceof t))throw new TypeError("Cannot call a class as a function")}(this,n),this.parent=t,this.menuToggle=this.parent.querySelector(".btn-menu"),this.menuCopy=this.parent.querySelector('.btn-menu [class$="btn__copy"]'),this.linksList=this.parent.querySelector(".header__nav__links"),this.parentToggles=Array.from(this.linksList.querySelectorAll(".header__nav__links__list__parent__toggle")),this.navigationBlocks=Array.from(this.parent.querySelectorAll(".header__nav__blocks a")),this.childLinks=Array.from(this.parent.querySelectorAll(".header__nav__links__list__parent__child-list__item a"))}return function(e,t,n){t&&o(e.prototype,t),n&&o(e,n)}(n,[{key:"toggleMenuActiveClass",value:function(){var t=this;this.parent.classList.toggle("nav-active"),this.menuCopy.textContent=this.parent.classList.contains("nav-active")?"close":"menu",this.navigationBlocks.forEach(function(e){e.tabIndex=t.parent.classList.contains("nav-active")?0:-1}),this.parentToggles.forEach(function(e){e.tabIndex=t.parent.classList.contains("nav-active")?0:-1}),window.innerWidth>i.default.md.min&&this.childLinks.forEach(function(e){e.tabIndex=t.parent.classList.contains("nav-active")?0:-1})}},{key:"handleDisablingToggles",value:function(){window.innerWidth>i.default.md.min?this.parentToggles.forEach(function(e){e.disabled=!0}):this.parentToggles.forEach(function(e){e.disabled=!1})}},{key:"addListeners",value:function(){var t=this;window.addEventListener("resize",(0,r.default)(function(){t.handleDisablingToggles()})),this.menuToggle.addEventListener("click",function(){t.toggleMenuActiveClass()}),this.parentToggles.forEach(function(e){e.addEventListener("click",function(e){t.constructor.toggleParentActiveClass(e)})})}},{key:"init",value:function(){this.addListeners(),this.handleDisablingToggles()}}],[{key:"toggleParentActiveClass",value:function(e){var t=e.currentTarget.parentNode,n=Array.from(e.currentTarget.nextElementSibling.children);t.classList.toggle("active"),n.forEach(function(e){e.firstElementChild.tabIndex=t.classList.contains("active")?0:-1})}}]),n}();n.default=a},{"../utilities/breakpoints":17,"../utilities/debounce":18}],4:[function(e,t,n){"use strict";Object.defineProperty(n,"__esModule",{value:!0}),n.default=void 0;var i,r=(i=e("../utilities/debounce"))&&i.__esModule?i:{default:i};function s(e,t){for(var n=0;n<t.length;n++){var i=t[n];i.enumerable=i.enumerable||!1,i.configurable=!0,"value"in i&&(i.writable=!0),Object.defineProperty(e,i.key,i)}}var o=function(){function n(e){var t=e.parent;!function(e,t){if(!(e instanceof t))throw new TypeError("Cannot call a class as a function")}(this,n),this.parent=t,this.btnPrev=t.querySelector(".btn-prev"),this.btnNext=t.querySelector(".btn-next"),this.slides=t.querySelectorAll(".herousel__slide"),this.currentIndex=0}return function(e,t,n){t&&s(e.prototype,t),n&&s(e,n)}(n,[{key:"setParentHeight",value:function(){var e=this.btnPrev.clientHeight+this.slides[this.currentIndex].clientHeight;this.parent.style.height="".concat(e,"px")}},{key:"slideNext",value:function(){var n=this;this.currentIndex++;var e=this.currentIndex-1;e>this.slides.length-1&&(e=0),this.currentIndex>this.slides.length-1&&(this.currentIndex=0),this.slides[e].classList.add("out"),setTimeout(function(){Array.from(n.slides).forEach(function(e,t){e.classList.toggle("active",t===n.currentIndex)}),n.slides[e].classList.remove("out")},500),this.setParentHeight()}},{key:"slidePrev",value:function(){var n=this;this.currentIndex--;var e=this.currentIndex+1;e<0&&(e=this.slides.length-1),this.currentIndex<0&&(this.currentIndex=this.slides.length-1),this.slides[e].classList.add("out"),setTimeout(function(){Array.from(n.slides).forEach(function(e,t){e.classList.toggle("active",t===n.currentIndex)}),n.slides[e].classList.remove("out")},500),this.setParentHeight()}},{key:"attachListeners",value:function(){var e=this;window.addEventListener("resize",(0,r.default)(function(){e.setParentHeight()},50)),this.btnNext.addEventListener("click",function(){e.slideNext()}),this.btnPrev.addEventListener("click",function(){e.slidePrev()})}},{key:"init",value:function(){this.attachListeners(),this.setParentHeight()}}]),n}();n.default=o},{"../utilities/debounce":18}],5:[function(e,t,n){"use strict";Object.defineProperty(n,"__esModule",{value:!0}),n.default=void 0;var i=a(e("./DigitalInsights")),r=a(e("./Header")),s=a(e("./Herousel")),o=a(e("./EmergingPerspectives"));function a(e){return e&&e.__esModule?e:{default:e}}var l=[{Component:i.default,elsSelector:".digital-insights"},{Component:s.default,elsSelector:".herousel"},{Component:o.default,elsSelector:".emerging-perspectives"},{Component:r.default,elsSelector:".header"}];n.default=l},{"./DigitalInsights":1,"./EmergingPerspectives":2,"./Header":3,"./Herousel":4}],6:[function(e,t,n){"use strict";var i;e("./polyfills"),((i=e("./components"))&&i.__esModule?i:{default:i}).default.forEach(function(t){document.querySelectorAll(t.elsSelector).forEach(function(e){(e=new t.Component({parent:e})).init()})})},{"./components":5,"./polyfills":12}],7:[function(e,t,n){"use strict";Array.prototype.find||(Array.prototype.find=function(e){if(null==this)throw new TypeError('"this" is null or not defined');var t=Object(this),n=t.length>>>0;if("function"!=typeof e)throw new TypeError("callback must be a function");for(var i=arguments[1],r=0;r<n;){var s=t[r];if(e.call(i,s,r,t))return s;r++}})},{}],8:[function(e,t,n){"use strict";Array.prototype.findIndex||Object.defineProperty(Array.prototype,"findIndex",{value:function(e,t){if(null==this)throw new TypeError('"this" is null or not defined');var n=Object(this),i=n.length>>>0;if("function"!=typeof e)throw new TypeError("predicate must be a function");for(var r=t,s=0;s<i;){var o=n[s];if(e.call(r,o,s,n))return s;s++}return-1},configurable:!0,writable:!0})},{}],9:[function(e,t,n){"use strict";Array.prototype.forEach||(Array.prototype.forEach=function(e){var t,n;if(null==this)throw new TypeError("this is null or not defined");var i=Object(this),r=i.length>>>0;if("function"!=typeof e)throw new TypeError(e+" is not a function");for(1<arguments.length&&(t=arguments[1]),n=0;n<r;){var s;n in i&&(s=i[n],e.call(t,s,n,i)),n++}})},{}],10:[function(e,t,n){"use strict";function u(e){return"function"==typeof e||"[object Function]"===i.call(e)}function f(e){var t=function(e){var t=Number(e);return isNaN(t)?0:0!==t&&isFinite(t)?(0<t?1:-1)*Math.floor(Math.abs(t)):t}(e);return Math.min(Math.max(t,0),r)}var i,r;Array.from||(Array.from=(i=Object.prototype.toString,r=Math.pow(2,53)-1,function(e,t,n){var i=Object(e);if(null==e)throw new TypeError("Array.from requires an array-like object - not null or undefined");var r,s=1<arguments.length?t:void 0;if(void 0!==s){if(!u(s))throw new TypeError("Array.from: when provided, the second argument must be a function");2<arguments.length&&(r=n)}for(var o,a=f(i.length),l=u(this)?Object(new this(a)):new Array(a),c=0;c<a;)o=i[c],l[c]=s?void 0===r?s(o,c):s.call(r,o,c):o,c+=1;return l.length=a,l}))},{}],11:[function(e,t,n){"use strict";function i(e){return new RegExp("(^| )"+e+"( |$)")}function r(e,t,n){for(var i=0;i<e.length;i++)t.call(n,e[i])}function s(e){this.element=e}s.prototype={add:function(){r(arguments,function(e){this.contains(e)||(this.element.className+=0<this.element.className.length?" "+e:e)},this)},remove:function(){r(arguments,function(e){this.element.className=this.element.className.replace(i(e),"")},this)},toggle:function(e){return this.contains(e)?(this.remove(e),!1):(this.add(e),!0)},contains:function(e){return i(e).test(this.element.className)},replace:function(e,t){this.remove(e),this.add(t)}},"classList"in Element.prototype||Object.defineProperty(Element.prototype,"classList",{get:function(){return new s(this)}}),window.DOMTokenList&&null==DOMTokenList.prototype.replace&&(DOMTokenList.prototype.replace=s.prototype.replace)},{}],12:[function(e,t,n){"use strict";e("./array-find"),e("./array-findindex"),e("./array-foreach"),e("./array-from"),e("./element-classlist"),e("./object-assign"),e("./string-includes"),e("./window-customevent"),e("./window-requestanimationframe")},{"./array-find":7,"./array-findindex":8,"./array-foreach":9,"./array-from":10,"./element-classlist":11,"./object-assign":13,"./string-includes":14,"./window-customevent":15,"./window-requestanimationframe":16}],13:[function(e,t,n){"use strict";"function"!=typeof Object.assign&&Object.defineProperty(Object,"assign",{value:function(e,t){if(null==e)throw new TypeError("Cannot convert undefined or null to object");for(var n=Object(e),i=1;i<arguments.length;i++){var r=arguments[i];if(null!=r)for(var s in r)Object.prototype.hasOwnProperty.call(r,s)&&(n[s]=r[s])}return n},writable:!0,configurable:!0})},{}],14:[function(e,t,n){"use strict";String.prototype.includes||(String.prototype.includes=function(e,t){return"number"!=typeof t&&(t=0),!(t+e.length>this.length)&&-1!==this.indexOf(e,t)})},{}],15:[function(e,t,n){"use strict";!function(){if("function"==typeof window.CustomEvent)return;function e(e,t){t=t||{bubbles:!1,cancelable:!1,detail:void 0};var n=document.createEvent("CustomEvent");return n.initCustomEvent(e,t.bubbles,t.cancelable,t.detail),n}e.prototype=window.Event.prototype,window.CustomEvent=e}()},{}],16:[function(e,t,n){"use strict";!function(){for(var s=0,e=["ms","moz","webkit","o"],t=0;t<e.length&&!window.requestAnimationFrame;++t)window.requestAnimationFrame=window[e[t]+"RequestAnimationFrame"],window.cancelAnimationFrame=window[e[t]+"CancelAnimationFrame"]||window[e[t]+"CancelRequestAnimationFrame"];window.requestAnimationFrame||(window.requestAnimationFrame=function(e,t){var n=(new Date).getTime(),i=Math.max(0,16-(n-s)),r=window.setTimeout(function(){e(n+i)},i);return s=n+i,r}),window.cancelAnimationFrame||(window.cancelAnimationFrame=function(e){clearTimeout(e)})}()},{}],17:[function(e,t,n){"use strict";Object.defineProperty(n,"__esModule",{value:!0}),n.default=void 0;var i={xs:{max:767},sm:{min:768,max:991},md:{min:992,max:1249},lg:{min:1250,max:1499},xl:{min:1500}};n.default=i},{}],18:[function(e,t,n){"use strict";Object.defineProperty(n,"__esModule",{value:!0});function i(i,e){var r,s=1<arguments.length&&void 0!==e?e:150;return function(){for(var e=arguments.length,t=new Array(e),n=0;n<e;n++)t[n]=arguments[n];clearTimeout(r),r=setTimeout(function(){i.apply(void 0,t)},s)}}n.default=void 0;n.default=i},{}]},{},[6]);