import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="current-user"
export default class extends Controller {
    static values = { id: String };

    connect() {
        let currentUserId = this.idValue;
        document.body.dataset.currentUserId = currentUserId;
    }
}
