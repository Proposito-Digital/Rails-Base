
export default {
    data(){
        return {
            closed: false
        }
    },
    props: {
        messages: {
            type: Array,
            default: []
        },
        kind: {
            type: String,
            default: 'success'
        },
        light: {
            type: Boolean,
            default: false,
        }
    },
    computed: {
        alertClass(){
            var _alertStyle = ['alert', this.alertType];
            if(this.light == true)
                _alertStyle.splice(1, 0, 'light');
            _alertStyle = _alertStyle.join('-');

            return {
                'alert': true,
                [_alertStyle]: true
            }
        },
        alertType(){
            if(this.kind == 'success')
                return 'success';
            if(this.kind == 'error' || this.kind == 'danger')
                return 'danger';
            if(this.kind == 'primary')
                return 'primary'
            if(this.kind == 'warning')
                return 'warning'
            if(this.kind == 'info')
                return 'info'
            if(this.kind == 'dark')
                return 'dark'
        },
        hasMessages(){
            return this.messages.length > 0;
        }
    },
    methods:{
        close(){
            this.closed = true;
        }
    },
    template: `
      <div v-if="!closed && hasMessages" :class="alertClass" role="alert">
        <div class="alert-messages">
                <span v-for="(message, index) in messages" :key="index" class="alert-message">{{message}}</span>
        </div>
        <a class="close pointer" @click="close">×</a>
      </div>
    `

}