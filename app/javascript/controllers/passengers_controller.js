import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = [ "container", "template" ]

    connect() {
        this.passengerCount = this.containerTarget.querySelectorAll("fieldset").length
    }

    addPassenger(event) {
        event.preventDefault()

        const newIndex = this.passengerCount
        const html = this.templateTarget.innerHTML.replaceAll("NEW_RECORD", newIndex)

        this.containerTarget.insertAdjacentHTML("beforeend", html)
        this.passengerCount++
    }

    removePassenger(event) {
        event.preventDefault()
        const fieldsets = this.containerTarget.querySelectorAll("fieldset")
        if (fieldsets.length <= 1) return
        event.target.closest("fieldset").remove()
    }
}