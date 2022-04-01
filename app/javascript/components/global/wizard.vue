<template>
    <div class="wizard">
        <div class="progress-bar" :style="progressBarStyle"></div>
        <div class="steps-header" flex-box flex-space="around">
            <div v-for="(header, index) in stepsHeaders" :key="index" :class="headerContainerClass(index)" @click=" openStep(index)">
                <div class="header-icon-container" flex-box middle>
                    <i :class="`icon ${header.icon}`"></i>
                </div>
                <span class="header-title"> {{header.title}} </span>
            </div>
        </div>
        <div class="steps-content" mt=1>
            <slot></slot>
        </div>
        <div class="footer" flex-box bottom-right mt=2>
            <span v-if="currentStepIndex > 0" class="button-outline" font-size=1 @click="goToPrevioustStep" mr=1>Voltar</span>
            <span v-if="(currentStepIndex+1) < steps.length" class="button" font-size=1 @click="goToNextStep">Avançar</span>
            <button v-else class="button" type="submit" font-size=1>{{ finishString }}</button>
        </div>
    </div>
</template>

<script>
export default {
    props: {
        stepComponent: {
            type: String,
            default: 'vue-wizard-step'
        },
        openedStep:{
            type: Number,
            default: 0
        },
        finishString: {
            type: String,
            default: 'Finalizar'
        }
    },
    data: function(){
        return {
            currentStepIndex: 0,
        }
    },
    mounted(){
        this.currentStepIndex = this.openedStep;
        this.changeStep(0, this.currentStepIndex);
    },
    computed: {
        steps(){
            return this.$slots.default.filter(slot=> slot.componentOptions && slot.componentOptions.tag == this.stepComponent);
        },
        stepsAmount(){
            return this.steps.length;
        },
        lastStep(){
            return (this.currentStepIndex + 1) == this.stepsAmount;
        },
        stepsHeaders(){
            return this.steps.map((step)=>{
                return {
                    'title': step.componentOptions.propsData.title,
                    'icon': step.componentOptions.propsData.icon
                }
            });
        },
        progressBarStyle(){
            return {
                'background': `linear-gradient(to right, #8DC4E2, ${this.progress}%, #E6E6E6 50% )`
            }
        },
        progress(){
            var _elementsCount = this.steps.length - 1;
            var _step = 100/_elementsCount;
            return this.currentStepIndex * _step;
        }
    },
    methods: {
        openStep(index){
            if(index != this.currentStepIndex){
                this.currentStepIndex = index;
            }
        },
        headerContainerClass(index){
            return {
                'step-header-container': true,
                'active': (this.currentStepIndex == index),
                'visited': (this.currentStepIndex > index)
            }
        },
        changeStep(toIndex, fromIndex){
            this.steps[fromIndex].componentInstance.$data.active = false;
            this.steps[toIndex].componentInstance.$data.active = true;
        },
        goToPrevioustStep(){
            this.openStep(this.currentStepIndex - 1);
        },
        goToNextStep(){
            this.openStep(this.currentStepIndex + 1);
        }
    },
    watch: {
        currentStepIndex(newValue, oldValue){
            this.changeStep(newValue, oldValue);
        }
    }
}
</script>