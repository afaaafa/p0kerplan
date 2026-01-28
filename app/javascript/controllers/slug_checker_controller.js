import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["slug", "status"]

  checkSlug(){
    clearTimeout(this.timeout)

    this.timeout = setTimeout(() => {
      this.performCheckSlug()
    }, 1000)
  }

  performCheckSlug(){
    fetch(`/rooms/check_slug?slug=${this.slugTarget.value}`)
      .then(response => response.json())
      .then(data => {
        this.statusTarget.textContent = data.available ? "Slug is available" : "Slug is already taken"
      })
  }
}
