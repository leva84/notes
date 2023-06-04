// app/javascript/controllers/current_user_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    static values = { id: String };

    connect() {
        let currentUserId = this.idValue;
        document.body.dataset.currentUserId = currentUserId;
    }
}
