<template>
  <div>
    <b-table striped hover :items="games" :fields="['Games']">
      <template v-slot:cell(games)="data">
        <a :href="'/'+data.item.type+'/'+data.item.id">{{data.item.name}}</a>
      </template>
    </b-table>
  </div>
</template>

<script>
export default {
  data () {
    return {
      games: []
    }
  },
  mounted () {
    const api = this.$api
    this.axios.get(api + 'games').then(response => {
      this.games = response.data
    })
  }
}
</script>

<style>
</style>
