import dinamycListItemComponent from './dynamicListItem'

export default {
  components: {
    'dinamycListItemComponent': dinamycListItemComponent
  },
  props: {
    instances: null,
    add_title: String,
    base_input_name: String,
    instance_to_add: Object,
    show_add: {
      type: Boolean,
      default: true
    }
  },
  methods: {
    addInstance: function () {
      var new_instance = {}
      Object.assign(new_instance, this.instance_to_add);
      this.instances.push(new_instance);
    },
    removeTopic: function(index){
      let instance_to_remove = this.instances[index];
      if(instance_to_remove.id==null){
        this.instances.splice(index, 1);
      }
    },
    template: /*html*/`
      <div>
        <div
          is='dinamyc-list-item-component'
          v-for="(instance, index) in instances"
          :key="index"
          :instance=instance
          :index=index
          :base_input_name=base_input_name
          @remove-topic='removeTopic'
        >
        </div>
        <a class="btn medium" @click="addInstance" v-if="show_add"> {{ add_title }}</a>
      </div >
    `
  }
}