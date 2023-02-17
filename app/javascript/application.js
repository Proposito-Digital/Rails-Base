// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

// Import Rails JS
import "@hotwired/turbo-rails"

// Import boostrap JS
import "@popperjs/core";
import "bootstrap";

// boostrap JS init
import './boostrap/init';

// Import VueApp
import createVueApp from './vueApp';

document.addEventListener('turbo:load', () => {
  const element = document.getElementById('appAdmin');
  if (element != null) {
    const vueApp = createVueApp();
    vueApp.config.compilerOptions.whitespace = 'preserve';
    vueApp.mount('#appAdmin');
  }
})

console.log('Loaded Application');