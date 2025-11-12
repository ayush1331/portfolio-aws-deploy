// Elements
const hamburger = document.getElementById('hamburger');
const navLinks = document.getElementById('nav-links');
const themeToggle = document.getElementById('theme-toggle');
const yearSpan = document.getElementById('year');

// Hamburger (mobile)
hamburger?.addEventListener('click', () => {
  navLinks.classList.toggle('active');
});

// Smooth scroll for anchor links
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
  anchor.addEventListener('click', function(e) {
    const href = this.getAttribute('href');
    const target = document.querySelector(href);
    if (target) {
      if (navLinks.classList.contains('active')) navLinks.classList.remove('active');
      e.preventDefault();
      target.scrollIntoView({ behavior: 'smooth', block: 'start' });
    }
  });
});

// THEME TOGGLE: dark <-> light
const THEME_KEY = 'site-theme';
const body = document.body;

// initialize theme: prefer saved -> prefer-color-scheme -> dark default
function applyTheme(theme) {
  if (theme === 'light') {
    body.classList.add('light');
    if (themeToggle) themeToggle.textContent = '🌙';
  } else {
    body.classList.remove('light');
    if (themeToggle) themeToggle.textContent = '🌗';
  }
  localStorage.setItem(THEME_KEY, theme);
}

// load theme
const saved = localStorage.getItem(THEME_KEY);
if (saved) {
  applyTheme(saved);
} else {
  // use system preference if available
  const prefersLight = window.matchMedia && window.matchMedia('(prefers-color-scheme: light)').matches;
  applyTheme(prefersLight ? 'light' : 'dark');
}

// toggle event
themeToggle?.addEventListener('click', () => {
  const current = body.classList.contains('light') ? 'light' : 'dark';
  applyTheme(current === 'dark' ? 'light' : 'dark');
});

// footer year
if (yearSpan) yearSpan.textContent = new Date().getFullYear();
