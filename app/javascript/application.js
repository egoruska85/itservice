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


document.addEventListener("DOMContentLoaded", () => {
  const track = document.getElementById("owlTrack");
  const prevBtn = document.getElementById("owlPrev");
  const nextBtn = document.getElementById("owlNext");
  const dotsContainer = document.getElementById("owlDots");

  if (!track) return;

  const items = track.querySelectorAll(".owl-item");
  let currentIndex = 0;

  // Рассчитываем, сколько карточек сейчас видно на экране
  function getVisibleItemsCount() {
    if (window.innerWidth <= 576) return 1;
    if (window.innerWidth <= 992) return 2;
    return 3;
  }

  // Динамически создаем точки (dots)
  function createDots() {
    dotsContainer.innerHTML = "";
    const visibleCount = getVisibleItemsCount();
    const maxScrollIndex = items.length - visibleCount;

    // Генерируем точки для всех доступных шагов
    for (let i = 0; i <= maxScrollIndex; i++) {
      const dot = document.createElement("div");
      dot.classList.add("owl-dot");
      if (i === currentIndex) dot.classList.add("active");

      dot.addEventListener("click", () => {
        currentIndex = i;
        updateCarousel();
      });
      dotsContainer.appendChild(dot);
    }
  }

  // Обновляем положение ленты и активную точку
  function updateCarousel() {
    const itemWidth = items[0].getBoundingClientRect().width;
    track.style.transform = `translateX(-${currentIndex * itemWidth}px)`;

    const dots = dotsContainer.querySelectorAll(".owl-dot");
    dots.forEach((dot, idx) => {
      dot.classList.toggle("active", idx === currentIndex);
    });
  }

  // Кнопка Вперед (с циклическим возвратом в начало)
  nextBtn.addEventListener("click", () => {
    const maxScrollIndex = items.length - getVisibleItemsCount();
    if (currentIndex < maxScrollIndex) {
      currentIndex++;
    } else {
      currentIndex = 0;
    }
    updateCarousel();
  });

  // Кнопка Назад (с циклическим переходом в конец)
  prevBtn.addEventListener("click", () => {
    const maxScrollIndex = items.length - getVisibleItemsCount();
    if (currentIndex > 0) {
      currentIndex--;
    } else {
      currentIndex = maxScrollIndex;
    }
    updateCarousel();
  });

  // Сброс и пересчет параметров при изменении размеров окна браузера
  window.addEventListener("resize", () => {
    currentIndex = 0;
    createDots();
    updateCarousel();
  });

  // Первичный запуск инициализации
  createDots();
  updateCarousel();
});

// Замените document.addEventListener("DOMContentLoaded", ... на это:
document.addEventListener("turbo:load", () => {
  const track = document.getElementById("owlTrack");
  const prevBtn = document.getElementById("owlPrev");
  const nextBtn = document.getElementById("owlNext");
  const dotsContainer = document.getElementById("owlDots");

  if (!track) return; // Важно: предотвращает ошибки на страницах без карусели

  const items = track.querySelectorAll(".owl-item");
  let currentIndex = 0;

  // ... (весь остальной ваш код функций getVisibleItemsCount, createDots, updateCarousel)

  // Перед вызовом createDots() очистите обработчики кликов со стрелок,
  // чтобы они не срабатывали дважды при повторных переходах:
  const newNextBtn = nextBtn.cloneNode(true);
  const newPrevBtn = prevBtn.cloneNode(true);
  nextBtn.parentNode.replaceChild(newNextBtn, nextBtn);
  prevBtn.parentNode.replaceChild(newPrevBtn, prevBtn);

  // Привязываем события заново к чистым кнопкам
  newNextBtn.addEventListener("click", () => {
    const maxScrollIndex = items.length - getVisibleItemsCount();
    currentIndex = (currentIndex < maxScrollIndex) ? currentIndex + 1 : 0;
    updateCarousel();
  });

  newPrevBtn.addEventListener("click", () => {
    const maxScrollIndex = items.length - getVisibleItemsCount();
    currentIndex = (currentIndex > 0) ? currentIndex - 1 : maxScrollIndex;
    updateCarousel();
  });

  // Инициализация
  createDots();
  updateCarousel();
});
