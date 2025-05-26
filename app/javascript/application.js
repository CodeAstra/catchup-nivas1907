// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
document.addEventListener("DOMContentLoaded", () => {
  document.addEventListener("click", function (e) {
    if (e.target && e.target.classList.contains("cancel-button")) {
      const formContainer = e.target.closest("turbo-frame");
      if (formContainer) {
        formContainer.remove(); 
      }
    }
  });
});
