const template = `
<div class="vue-dynamic_form">
<div v-for="(instance, index) in instances" :key="index" class="vue-dynamic_form__instance_row" :class="{remove: instance._destroy}" flex-box flex-space="between" mt=1 bottom-right>
  <slot name="form" :instance="instance" :index=index :inputName="inputName(index)"/>
  <input type=hidden :value="true" :name="\`\${inputName(index)}[_destroy]\`">
  <slot name="actions" :instance=instance />
  <a v-if="!showOnly" class="vue-dynamic_form__remove_instance_button button-icon-danger" title="Remover" data-placement="top" @click="removeInstance(index)"><i class="bi bi-trash"></i></a>
</div>
<slot name="new"  :current-index="currentIndex" />
<slot name="add">
  <div flex-box bottom-right mt=1>
    <a v-if="!showOnly" class="vue-dynamic_form__add_instance_button button-outline" @click="addInstance"> {{ addTitle }}</a>
  </div>
</slot>
</div>
`

export default {
  template: template,
  props: {
    initialInstances: [],
    addTitle: {
      type: String,
      default: "Adicionar"
    },
    baseName: {
      type: String,
      default: ''
    },
    initialIndex: {
      type: Number,
      default: 0
    },
    showOnly: {
      type: Boolean,
      default: false
    },
    showEmpty: {
      type: Boolean,
      default: true
    }
  },
  data: function(){
    return {
      currentIndex: 0,
      instances: []
    }
  },
  beforeMount(){
    this.instances = this.initialInstances;
    this.currentIndex = this.initialIndex;
    this.instances.forEach(instance => {
      instance.preExistent = true;
    });
    if(this.showEmpty)
      this.addInstance();
  },
  methods:{
    inputName(index){
      return `${this.baseName}[${index}]`
    },
    addInstance(){
      this.instances.push({preExistent: false});
    },
    removeInstance(index){
      if(!this.instances[index].preExistent){
        this.instances.splice(index,1);
      } else {
        this.instances[index]._destroy = true;
        this.instances = [...this.instances];
      }
    }
  }
}