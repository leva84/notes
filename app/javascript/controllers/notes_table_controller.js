// app/javascript/controllers/notes_table_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    static targets = ["deleteIcon", "noTrashIcon"];

    connect() {
        this.updateIcons();
        document.addEventListener("turbo:load", this.updateIcons.bind(this));
    }

    disconnect() {
        document.removeEventListener("turbo:load", this.updateIcons.bind(this));
    }

    updateIcons() {
        let currentUserId = document.body.dataset.currentUserId;
        this.deleteIconTargets.forEach((icon) => {
            if (icon.dataset.userId !== currentUserId) {
                icon.style.display = "none";
            } else {
                icon.style.display = "";
            }
        });
        this.noTrashIconTargets.forEach((icon) => {
            if (icon.dataset.userId === currentUserId) {
                icon.style.display = "none";
            } else {
                icon.style.display = "";
            }
        });
    }
}
