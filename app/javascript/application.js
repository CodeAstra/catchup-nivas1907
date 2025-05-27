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

window.handleCreateSubmit = async function(event) {
  event.preventDefault();
  const form = event.target;
  const formData = new FormData(form);

  try {
    const response = await fetch(form.action, {
      method: form.method.toUpperCase(),
      headers: {
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
      },
      body: formData,
    });

    if (response.ok) {
      const html = await response.text();
      document.querySelector('#posts-list').insertAdjacentHTML('afterbegin', html);
      form.reset();
      window.dispatchEvent(new CustomEvent("post-created"));
    } else {
      console.error("Failed to create post");
    }
  } catch (err) {
    console.error("Error:", err);
  }
};

window.handleEditSubmit = async function(event, postId) {
  event.preventDefault();
  const form = event.target;
  const formData = new FormData(form);

  try {
    const response = await fetch(form.action, {
      method: form.method.toUpperCase(),
      headers: {
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
      },
      body: formData,
    });

    if (response.ok) {
      const html = await response.text();
      document.querySelector(`turbo-frame[id="post_${postId}"]`).outerHTML = html;
    } else {
      console.error("Failed to update post");
    }
  } catch (err) {
    console.error("Error:", err);
  }
};
