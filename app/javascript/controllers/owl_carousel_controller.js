import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["track", "item", "dots"]

  connect() {
    this.currentIndex = 0
    this.createDots()
    this.updateCarousel()

    // Пересчет при изменении экрана
    this.resizeHandler = () => {
      this.currentIndex = 0
      this.createDots()
      this.updateCarousel()
    }
    window.addEventListener("resize", this.resizeHandler)
  }

  disconnect() {
    // Удаляем слушатель при уходе со страницы, чтобы не было утечек памяти
    window.removeEventListener("resize", this.resizeHandler)
  }

  getVisibleItemsCount() {
    if (window.innerWidth <= 576) return 1
    if (window.innerWidth <= 992) return 2
    return 3
  }

  createDots() {
    if (!this.hasDotsTarget) return
    this.dotsTarget.innerHTML = ""

    const maxScrollIndex = this.itemTargets.length - this.getVisibleItemsCount()

    for (let i = 0; i <= maxScrollIndex; i++) {
      const dot = document.createElement("div")
      dot.classList.add("owl-dot")
      if (i === this.currentIndex) dot.classList.add("active")

      dot.addEventListener("click", () => {
        this.currentIndex = i
        this.updateCarousel()
      })
      this.dotsTarget.appendChild(dot)
    }
  }

  updateCarousel() {
    if (!this.hasTrackTarget || this.itemTargets.length === 0) return
    const itemWidth = this.itemTargets[0].getBoundingClientRect().width
    this.trackTarget.style.transform = `translateX(-${this.currentIndex * itemWidth}px)`

    const dots = this.dotsTarget.querySelectorAll(".owl-dot")
    dots.forEach((dot, idx) => {
      dot.classList.toggle("active", idx === this.currentIndex)
    })
  }

  next() {
    const maxScrollIndex = this.itemTargets.length - this.getVisibleItemsCount()
    this.currentIndex = (this.currentIndex < maxScrollIndex) ? this.currentIndex + 1 : 0
    this.updateCarousel()
  }

  prev() {
    const maxScrollIndex = this.itemTargets.length - this.getVisibleItemsCount()
    this.currentIndex = (this.currentIndex > 0) ? this.currentIndex - 1 : maxScrollIndex
    this.updateCarousel()
  }
}
