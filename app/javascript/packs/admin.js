import Vue from 'vue'
import App from '../admin.vue'
import { BootstrapVue } from 'bootstrap-vue'

import './stylesheets/application.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'

Vue.use(BootstrapVue)

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    render: h => h(App, { props: document.getElementById('props').dataset })
  }).$mount()
  document.body.appendChild(app.$el)
})
