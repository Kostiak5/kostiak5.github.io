// Function to apply saved theme or default to 'minimal'
function applySavedTheme() {
  const savedTheme = localStorage.getItem('theme') || 'minimal';
  document.documentElement.setAttribute('data-theme', savedTheme);
  
  // Update toggle button text if present
  const toggleBtn = document.getElementById('theme-toggle');
  if (toggleBtn) {
    toggleBtn.textContent = savedTheme === 'retro' ? '[⚡ MINIMAL MODE]' : '[👾 RETRO MODE]';
  }
}

// Function to toggle between themes
function toggleTheme() {
  const currentTheme = document.documentElement.getAttribute('data-theme') || 'minimal';
  const newTheme = currentTheme === 'minimal' ? 'retro' : 'minimal';
  
  localStorage.setItem('theme', newTheme);
  applySavedTheme();
}

// Execute immediately to prevent screen flicker on page load
applySavedTheme();