import Vue from 'vue'
import Router from 'vue-router'
import VolleyballScoreboard from '@/components/VolleyballScoreboard'
import Home from '@/components/Home'
import BootstrapVue from 'bootstrap-vue'
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'
import axios from 'axios'
import VueAxios from 'vue-axios'

Vue.use(BootstrapVue)

Vue.use(VueAxios, axios)

Vue.use(Router)

export default new Router({
  mode: 'history',
  routes: [
    {
      path: '/',
      name: 'Home',
      component: Home
    },
    {
      path: '/volleyball/:game_id',
      name: VolleyballScoreboard,
      component: VolleyballScoreboard
    }
  ]
})
