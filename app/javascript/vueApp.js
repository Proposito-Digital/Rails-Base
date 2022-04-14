// Import Vue JS
import { createApp } from 'vue';

// Import Third Party Libs
import TurbolinksAdapter from 'vue-turbolinks';
import VueMultiselect from 'vue-multiselect';

// Create Apps

const app = createApp({
  // store: store,
  data() {
    return {
      message: 'Hello Vue!'
    }
  }
});
app.config.devtools = true;

// Load Third Party Libs
app.use(TurbolinksAdapter);

// Load Third Party components
app.component('vue-multiselect', VueMultiselect);

export default app