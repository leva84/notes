import { Application } from "@hotwired/stimulus";
import "@hotwired/turbo-rails";
import "controllers";
import "bootstrap";
import NotesTableController from "./controllers/notes_table_controller";
import CurrentUserController from "./controllers/current_user_controller";

const application = Application.start();
application.register("notes-table", NotesTableController);
application.register("current-user", CurrentUserController);

window.application = application;
