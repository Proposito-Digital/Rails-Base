// Import Vue JS
import { createApp } from 'vue';

// Import Plugins
import globalMethodsPlugin from './plugins/globalMethods';

// Import Third Party Libs
import TurbolinksAdapter from 'vue-turbolinks';
import Vuex from 'vuex';
import VueMultiselect from 'vue-multiselect';

// Import Global components
import globalComponentsList from "./components/index";

// Import Store
import { globalStore } from './globalStore';
const store = new Vuex.Store(globalStore);

const createVueApp = ()=>{
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
  app.use(globalMethodsPlugin);

  // Load Third Party Libs
  app.use(TurbolinksAdapter);
  app.use(Vuex);

  // Load Third Party components
  app.component('vue-multiselect', VueMultiselect);

  // Load Global Components
  globalComponentsList.forEach((item)=>app.component(item.name, item.component));
  return app;
}
export default createVueApp