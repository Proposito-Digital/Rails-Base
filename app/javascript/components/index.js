import Vue from 'vue'
import componentAccordion from "./global/accordion";
import componentDynamicList from "./global/dynamicList";
import componentDynamicListItem from "./global/dynamicListItem";
import modal from "./global/modal";
import alert from "./global/alert";

Vue.component("vue-component-accordion", componentAccordion);
Vue.component("vue-component-dynamic-list", componentDynamicList);
Vue.component("vue-component-dynamic-list-item", componentDynamicListItem);
Vue.component("vue-modal", modal);
Vue.component("vue-alert", alert);
  
// LOADING PAGE SPECIFIC COMPONENTS
