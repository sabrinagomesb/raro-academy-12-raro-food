// Entry point for the build script in your package.json
import { Turbo } from "@hotwired/turbo-rails";
import "./controllers";
import "trix"
import "@rails/actiontext"

Turbo.session.drive = false;
