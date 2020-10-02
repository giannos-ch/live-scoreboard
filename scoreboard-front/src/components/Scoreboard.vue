<template>
  <div class="wrapper" v-on:click="auth">
    <div class="editor">
      <span v-if="editing">
        <b-button v-on:click="points_h--">Home--</b-button>
        <b-button v-on:click="points_a--">Away--</b-button>
        <b-button v-on:click="end_set">End set</b-button>
        <b-button v-on:click="undo_end_set">Undo end set</b-button>
      </span>
    </div>
    <b-row style="margin-top:80px">
      <b-col cols="6" style="text-align:right">
        <label class="large4 unselectable" style="width:30vw;text-align:center">{{home}}</label>
      </b-col>
      <b-col cols="6" style="text-align:left">
        <label class="large4 unselectable" style="width:30vw;text-align:center">{{away}}</label>
      </b-col>
    </b-row>
    <b-row style="margin-top:-8vw">
      <b-col cols="12" class="centering">
        <transition name="bounce" mode="out-in">
          <label :key="sets_h" class="large2 unselectable">{{sets_h}}</label>
        </transition>
        <transition name="bounce" mode="out-in">
          <label
            :key="points_h"
            class="large1 unselectable"
            v-on:click="editing && points_h++"
          >{{pad2(points_h)}}</label>
        </transition>
        <label class="large1 unselectable">:</label>
        <transition name="bounce" mode="out-in">
          <label
            :key="points_a"
            class="large1 unselectable"
            v-on:click="editing && points_a++"
          >{{pad2(points_a)}}</label>
        </transition>
        <transition name="bounce" mode="out-in">
          <label :key="sets_a" class="large2 unselectable">{{sets_a}}</label>
        </transition>
      </b-col>
    </b-row>
    <b-row>
      <b-col cols="3">
        <label
          class="large3 unselectable"
          v-if="sets_h+sets_a>0"
        >{{pad2(prev_sets[0][0])}}:{{pad2(prev_sets[0][1])}}</label>
      </b-col>
      <b-col cols="3">
        <label
          class="large3 unselectable"
          v-if="sets_h+sets_a>1"
        >{{pad2(prev_sets[1][0])}}:{{pad2(prev_sets[1][1])}}</label>
      </b-col>
      <b-col cols="3">
        <label
          class="large3 unselectable"
          v-if="sets_h+sets_a>2"
        >{{pad2(prev_sets[2][0])}}:{{pad2(prev_sets[2][1])}}</label>
      </b-col>
      <b-col cols="3">
        <label
          class="large3 unselectable"
          v-if="sets_h+sets_a>3"
        >{{pad2(prev_sets[3][0])}}:{{pad2(prev_sets[3][1])}}</label>
      </b-col>
    </b-row>
  </div>
</template>

<script>
export default {
  name: 'Scoreboard',
  data () {
    return {
      home: 'kamos1',
      away: 'kamos2',
      points_h: 0,
      points_a: 0,
      sets_h: 0,
      sets_a: 0,
      prev_sets: [
        [0, 0],
        [0, 0],
        [0, 0],
        [0, 0]
      ],
      editing: false
    }
  },
  methods: {
    pad2 (i) {
      var s = '00' + i
      return s.substr(s.length - 2)
    },
    auth (evt) {
      this.editing ^= evt.detail === 3
    },
    end_set () {
      const setNo = this.sets_h + this.sets_a
      if (setNo > 3) return
      this.prev_sets[setNo][0] = this.points_h
      this.prev_sets[setNo][1] = this.points_a
      if (this.points_h < this.points_a) this.sets_a++
      else if (this.points_h > this.points_a) this.sets_h++
      this.points_h = this.prev_sets[setNo + 1][0]
      this.points_a = this.prev_sets[setNo + 1][1]
    },
    undo_end_set () {
      const setNo = this.sets_h + this.sets_a
      if (setNo < 1) return
      this.points_h = this.prev_sets[setNo - 1][0]
      this.points_a = this.prev_sets[setNo - 1][1]
      if (this.points_h < this.points_a) this.sets_a--
      else if (this.points_h > this.points_a) this.sets_h--
    }
  }
}
</script>

<style scoped>
.wrapper {
  background-color: black;
  color: gray;
  height: 100%;
  width: 100%;
  position: fixed;
}
.editor {
  position: absolute;
  right: 0;
  top: 0;
}
.home_label {
  text-align: right;
}
.away_label {
  text-align: left;
}
.centering {
  text-align: center;
}
.large1 {
  font-size: 20vw;
}
.large2 {
  font-size: 10vw;
}
.large3 {
  font-size: 8vw;
}
.large4 {
  font-size: 5vw;
}
.unselectable {
  -webkit-touch-callout: none;
  -webkit-user-select: none;
  -khtml-user-select: none;
  -moz-user-select: none;
  -ms-user-select: none;
  user-select: none;
}
.bounce-enter-active {
  animation: bounce-in 0.5s;
}
.bounce-leave-active {
  animation: bounce-in 0.5s reverse;
}
@keyframes bounce-in {
  0% {
    transform: scale(0);
  }
  50% {
    transform: scale(2);
  }
  100% {
    transform: scale(1);
  }
}
</style>
