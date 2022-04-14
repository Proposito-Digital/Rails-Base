// Import Vue JS
import { createApp } from 'vue';

// Import Plugins
// import myPlugin from './plugins/main';

// Import Third Party Libs
import TurbolinksAdapter from 'vue-turbolinks';
import Vuex from 'vuex';
import VueMultiselect from 'vue-multiselect';

// Import Store
import { globalStore } from './globalStore';
const store = new Vuex.Store(globalStore);


// Create App
const app = createApp({
  // store: store,
  data() {
    return {
      message: 'Hello Vue!'
    }
  },
  store: store
});
app.config.devtools = true;

// Load Plugins
// app.use(myPlugin);

// Load Third Party Libs
app.use(TurbolinksAdapter);
app.use(Vuex);

// Load Third Party components
app.component('vue-multiselect', VueMultiselect);

export default app