  export default {
    props:{
      overflow: {
        type: Boolean,
        default: true
      }
    },
    data () {
      return {
          cleanModal: false,
          showModal: false,
          loadingSubmit: false,
      }
      },
    watch: {
      showModal: {
        immediate: true,
        deep: true,
        handler(newValue, oldValue) {
            if (newValue) {
                document.body.classList.add('no-scroll');
            }
            if (!newValue) {
                document.body.classList.remove('no-scroll');
            }
        }
      }
    },
    computed:{
      bodyStyle: function(){
        var _style = {};

        if(this.overflow == true){
          _style.overflow = 'scroll';
        }
        return _style
      }
    },
    methods: {
      close() {
        this.showModal = false;
      },
      open(){
        this.showModal = true;
      }
    },
    created() {
      const that = this;
      document.addEventListener('keyup', function (evt) {
        if (evt.keyCode === 27) {
          that.close();
        }
      });
    },
    template: /*html*/`
      <div class="modal-component" :showmodal="showModal">
        <div bg-modal></div>
        <div class="modal-box" ref="modal-page">
          <div header>
            <slot name="header"></slot>
            <span class="icon-close" @click="close">
              <i class="fa fa-times"></i>
            </span>
          </div>
          <div body>
            <slot name="body"></slot>
          </div>
        </div>
      </div>
    `
  }

