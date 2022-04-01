export default {
    data: function(){
        return {
            opened: true,
        }
    },
    props:{
        alwaysOpen:{
            type: Boolean,
            default: false
        },
        startOpened: {
            type: Boolean,
            default: true
        },
        toggleIcon:{
            type: String,
            default: "bi bi-chevron-up"
        },
        title: {
            type: String,
            default: 'Titulo'
        },
        icon: {
            type: String,
            default: 'bi bi-info-circle'
        }
    },
    computed: {
        bodyStyle: function (){
            if(this.isOpen){
                return {};
            } else {
                return {display: 'none'};
            }
        },
        isOpen: function(){
            return this.$data.opened;
        },
        toggleClass: function(){
            if(this.isOpen){
                return 'expanded';
            } else {
                return 'colapsed';
            }
        },
        bodyClass: function(){
            if(this.isOpen){
                return 'expanded';
            } else {
                return 'colapsed';
            }
        }
    },
    methods: {
        toggle(){
            if(!this.alwaysOpen){
                if(this.isOpen == true)
                    this.colapse();
                else 
                    this.expand();
            }
        },
        expand(){
            this.setOpened(true);
        },
        colapse(){
            this.setOpened(false);
        },
        setOpened(value){
            this.$data.opened = value;
        }
    },
    beforeMount: function() {
        this.setOpened(this.start_opened);
    },
  template: /*html*/`
      <div accordion-component >
          <div header ui-row @click="toggle" class="space-between">
              <slot name="header"></slot>
              <div :class="toggleClass">
                  <i toggle-icon :class="headerIcon" aria-hidden="true"></i>
              </div>
          </div>
          <div body :style="bodyStyle" mt=1>
              <slot name="body" class="colapsed"></slot>
          </div>
      </div>
    `
}
