/**
 * J.Lynch CutZ - Core JavaScript
 * Handles lightweight, context-efficient UI interactions:
 * 1. Theme toggling (Dark/Light mode)
 * 2. Hero Background Slideshow Transitions
 * 3. Mobile Navigation Hamburger Toggle
 */
document.addEventListener('DOMContentLoaded', () => {
  initThemeToggle();
  initHeroSlideshow();
  initMobileNav();
});

/**
 * Manages the mobile hamburger menu toggle and overlay navigation.
 */
function initMobileNav() {
  const hamburger = document.getElementById('hamburger-toggle');
  const navGroup = document.getElementById('nav-group');
  if (!hamburger || !navGroup) return;

  hamburger.addEventListener('click', () => {
    const isOpen = hamburger.classList.toggle('is-open');
    navGroup.classList.toggle('is-open');
    hamburger.setAttribute('aria-expanded', isOpen);
    // Prevent body scroll when menu is open
    document.body.style.overflow = isOpen ? 'hidden' : '';
  });

  // Close menu when a nav link is tapped
  navGroup.querySelectorAll('.nav-link').forEach(link => {
    link.addEventListener('click', () => {
      hamburger.classList.remove('is-open');
      navGroup.classList.remove('is-open');
      hamburger.setAttribute('aria-expanded', 'false');
      document.body.style.overflow = '';
    });
  });
}

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
