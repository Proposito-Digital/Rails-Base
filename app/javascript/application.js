// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
// Import Rails JS
import "@hotwired/turbo-rails"
// Import boostrap JS
import "@popperjs/core";
import "bootstrap";
// Import Vue JS
import Vue from "vue"
import Vuex from 'vuex';
import TurbolinksAdapter from 'vue-turbolinks';
import VueTheMask from 'vue-the-mask'
import Multiselect from 'vue-multiselect';
import money from 'v-money'
// Import Plugins
import MainPlugin from './plugins/main';
// Import Store
import { globalStore } from './globalStore';
import './components/index';
// boostrap JS init
import './boostrap/init';

// Register Third Parties Libs
Vue.use(TurbolinksAdapter)
Vue.use(Vuex)
Vue.use(MainPlugin);
Vue.use(VueTheMask)
Vue.component('vue-multiselect', Multiselect);
Vue.use(money, { precision: 2 })

const store = new Vuex.Store(globalStore);

document.addEventListener('turbo:load', () => {
  const element = document.getElementById('appAdmin');
  if (element != null) {
    const app = new Vue({
      el: '#appAdmin',
      store: store,
      data : {
        message: 'Hello Vue!'
      }
    });
  }
})

console.log('Loaded Application');