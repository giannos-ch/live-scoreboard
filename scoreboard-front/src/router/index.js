import VueRouter from "vue-router";
import Home from "@/components/Home.vue";
import VolleyballScoreboard from "@/components/VolleyballScoreboard.vue";

const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home
  },
  {
    path: '/volleyball/:game_id',
    name: 'VolleyballScoreboard',
    component: VolleyballScoreboard,
  }
]

const router = new VueRouter({
  mode: 'history',
  routes,
});

export default router;