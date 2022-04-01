<template>
  <div style="width: 100%">
    <input type="hidden" :value="value" :name="name"/>
	  <money v-model="value" :prefix="prefix" :decimal="decimal" :thousands="thousands" :id="id" :value="value"></money>
  </div>
</template>
<script>
export default {
  props: {
    prefix: {
      type: String,
      default: "R$ ",
    },
    decimal: {
      type: String,
      default: ",",
    },
    thousands: {
      type: String,
      default: "."
    },
    name: {
      type: String,
      default: ""
    },
    id: {
      type: String,
      default: "",
    },
    initialValue: {
      type: String,
      default: "0"
    }
  },
  data: function(){
    return {
      value: "",
    }
  },
  beforeMount(){
    this.value = this.initialValue
  }
}
</script>
