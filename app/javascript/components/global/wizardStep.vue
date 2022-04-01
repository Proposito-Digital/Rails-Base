<template>
    <div class="wizard-step" v-show="active">
        <h4 class="content-title font-primary">{{ contentTitle }} </h4>
        <slot> </slot>
    </div>
</template>

<script>
export default {
    props: {
        title: String,
        contentTitle: String,
        icon: {
            type: String,
            default: 'bi bi-emoji-angry-fill'
        },
        onActive: {
            type: Function,
            default: null
        }
    },
    data: function(){
        return {
            active: false
        }
    },
    beforeUpdate(){
        if(this.onActive)
            this.onActive();
    }
}
</script>