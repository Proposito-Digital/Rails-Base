export default {
  template: "#list-item-template",
  data: function () {
    return {
      destroy : 0
    }
  },
  props: {
    instance: null,
    topic: Object, 
    index: Number,
    base_input_name: String,
  },
  computed: {
    _style: function(){
      if (this.isDestroyed){
        return {
          'display': 'none'
        }
      }else{
        return {

        }
      }
    },
    isDestroyed: function(){
      if (this.$data.destroy == 1){
        return true
      } else {
        return false
      }
    }
  },
  methods: {
    deleteInstance: function(){
      if (this.instance.id == null){
        this.$emit('remove-topic', this.index);
      }else{
        this.destroySelf();
      }
    },
    inputName: function(name){
      return `${this.base_input_name}[${this.index}][${name}]`
    },
    destroySelf: function() {
      this.$data.destroy = 1;
    }
  }
}