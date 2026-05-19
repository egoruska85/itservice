// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import "popper"
import "bootstrap"

document.addEventListener("turbo:load", function() {
  // Находим все алерты
  const alerts = document.querySelectorAll('.custom-alert');

  alerts.forEach(function(alert) {
    // Через 5 секунд запускаем скрытие
    setTimeout(function() {
      if (alert) {
        // Используем встроенный метод Bootstrap для плавного закрытия
        const bsAlert = new bootstrap.Alert(alert);
        bsAlert.close();
      }
    }, 5000);
  });
});
