# Pin npm packages by running ./bin/importmap PACKEGE@VERSION
# Rails JS
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
# Bootstrap JS
pin "bootstrap", to: "https://ga.jspm.io/npm:bootstrap@5.1.3/dist/js/bootstrap.esm.js"
pin "@popperjs/core", to: "https://ga.jspm.io/npm:@popperjs/core@2.11.2/lib/index.js"
# Vue JS
pin "vue", to: "https://ga.jspm.io/npm:vue@2.6.11/dist/vue.common.js"
pin "process", to: "https://ga.jspm.io/npm:@jspm/core@2.0.0-beta.19/nodelibs/browser/process-production.js", preload: true
pin "vue-turbolinks", to: "https://ga.jspm.io/npm:vue-turbolinks@2.2.2/index.js"
pin "vuex", to: "https://cdn.jsdelivr.net/npm/vuex@3.6.2/dist/vuex.esm.browser.min.js"
pin "vue-the-mask", to: "https://ga.jspm.io/npm:vue-the-mask@0.11.1/dist/vue-the-mask.js"
pin "vue-multiselect", to: "https://ga.jspm.io/npm:vue-multiselect@2.1.6/dist/vue-multiselect.min.js"
pin "v-money", to: "https://ga.jspm.io/npm:v-money@0.8.1/dist/v-money.js"
# Custom JS
pin "application"
pin_all_from "app/javascript/controllers"
pin_all_from "app/javascript/plugins"