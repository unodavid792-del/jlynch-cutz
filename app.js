/**
 * J.Lynch CutZ - Core JavaScript
 * Handles lightweight, context-efficient UI interactions:
 * 1. Theme toggling (Dark/Light mode)
 * 2. Hero Background Slideshow Transitions
 */
document.addEventListener('DOMContentLoaded', () => {
  initThemeToggle();
  initHeroSlideshow();
});

/**
 * Initializes light/dark theme switching and persists preference.
 */
function initThemeToggle() {
  const toggleBtn = document.getElementById('theme-toggle');
  const htmlRoot = document.documentElement;
  
  if (!toggleBtn) return;

  // Retrieve saved preference or system theme
  const savedTheme = localStorage.getItem('theme');
  const systemPrefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
  
  const currentTheme = savedTheme || (systemPrefersDark ? 'dark' : 'light');
  htmlRoot.setAttribute('data-theme', currentTheme);

  toggleBtn.addEventListener('click', () => {
    const nextTheme = htmlRoot.getAttribute('data-theme') === 'dark' ? 'light' : 'dark';
    htmlRoot.setAttribute('data-theme', nextTheme);
    localStorage.setItem('theme', nextTheme);
  });
}

/**
 * Manages the fading background transitions in the hero section.
 */
function initHeroSlideshow() {
  const slides = document.querySelectorAll('.hero-slides .slide');
  if (slides.length <= 1) return;

  let currentSlideIndex = 0;
  const slideIntervalTime = 6000; // Switch slide every 6 seconds

  setInterval(() => {
    // Fade out current slide
    slides[currentSlideIndex].classList.remove('active');
    
    // Calculate index of next slide
    currentSlideIndex = (currentSlideIndex + 1) % slides.length;
    
    // Fade in next slide
    slides[currentSlideIndex].classList.add('active');
  }, slideIntervalTime);
}
