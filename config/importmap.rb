# Pin npm packages by running ./bin/importmap PACKEGE@VERSION
# Rails JS
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
# Bootstrap JS
pin "bootstrap", to: "https://ga.jspm.io/npm:bootstrap@5.1.3/dist/js/bootstrap.esm.js"
pin "@popperjs/core", to: "https://ga.jspm.io/npm:@popperjs/core@2.11.6/lib/index.js"

# Vue JS
pin "vue", to: "https://cdn.jsdelivr.net/npm/vue@3.2.31/dist/vue.esm-browser.js"
pin "process", to: "https://ga.jspm.io/npm:@jspm/core@2.0.0-beta.19/nodelibs/browser/process-production.js", preload: true
pin "vue-turbolinks", to: "https://ga.jspm.io/npm:vue-turbolinks@2.2.2/index.js"
pin "vuex", to: "https://cdn.jsdelivr.net/npm/vuex@4.0.0/dist/vuex.esm-browser.js"

# Thidr Party Libs
pin "vue-multiselect", to: "https://cdn.jsdelivr.net/npm/vue-multiselect@3.0.0-alpha.1/dist/vue-multiselect.esm.min.js"

# Custom JS
pin "application"
pin_all_from "app/javascript/controllers"
pin_all_from "app/javascript/plugins"