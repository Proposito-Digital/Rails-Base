<template>
    <div class="my-multiselect-container">
        <input type="hidden" :name="name" :id="id" v-model="selectedValue" :disabled="disabled || disableInput" >
        <vue-multiselect
            v-model="selectedOption"
            :options="options"
            :label="label"
            :placeholder="placeholder"
            :customLabel="customLabel"
            :disabled="disabled"
            :readonly="readonly"
            :searchable="searchable"
            :close-on-select="closeOnSelect"
            :clear-on-select="clearOnSelect"
            :allow-empty="allowEmpty"
            :open-direction="'bottom'"
            :preserve-search="preserveSearch"
            :taggable="taggable"
            :reset-after="resetAfter"
            @search-change="asyncFind"
            @select="onSelect"
        >
            <template slot="singleLabel" slot-scope="{ option }">
                <slot name="singleLabel" :option=option>
                </slot>
            </template>
            <template v-if="useSearchIcon" slot="caret">
                <i class="caret-icon bi bi-search"></i>
            </template>
            <template slot="noResult">
                <slot name="noResult"></slot>
            </template>
        </vue-multiselect>
    </div>
</template>

<script>
export default {
    props:{
        name: String,
        id: String,
        value: String|Number,
        default: String|Number,
        icon: {
            type: String,
            default: 'arrow',
            validator: (value)=>{
                return ['arrow', 'search'].includes(value);
            }
        },
        taggable: {
            type: Boolean,
            default: false
        },
        label: String,
        disabled: {
            type: Boolean,
            default: false
        },
        readonly: {
            type: Boolean,
            default: false
        },
        disableInput: {
            type: Boolean,
            default: false
        },
        searchable: {
            type: Boolean,
            default: false
        },
        closeOnSelect: {
            type: Boolean,
            default: true
        },
        clearOnSelect: {
            type: Boolean,
            default: true
        },
        preserveSearch: {
            type: Boolean,
            default: false
        },
        allowEmpty: {
            type: Boolean,
            default: true
        },
        resetAfter: {
            type: Boolean,
            default: false
        },
        optionsLimit: {
            type: Number,
            default: undefined
        },
        options: {
            type: Array,
            default: ()=>[]
        },
        placeholder: {
            type: String,
            default: 'Selecione uma opção'
        },
        asyncFind: {
            type: Function,
            default: (searchQuery, id) => {}
        },
        onSelect: {
            type: Function,
            default: (selectedOption, id) =>{}
        }
    },
    data(){
        return {
            selectedOption: null,
            selectedValue: null
        }
    },
    beforeMount(){
        if(this.value != null){
            this.selectedOption = this.options.find(option=>option.value==this.value);
        }else if (this.value == null && this.default !=null){
            this.selectedOption = this.options.find(option=>option.value==this.default);
        }
    },
    computed: {
        useSearchIcon(){
            return this.icon == 'search';
        }
    },
    watch:{
        selectedOption: function (newOption, oldOption){
            if(newOption){
                this.selectedValue = newOption.value;
            }
        },
        selectedValue: function (newOption, oldOption){
            this.$emit('input', this.selectedValue);
        },
        value(newOption, oldOption){
            if(this.value != null){
                this.selectedOption = this.options.find(option=>option.value==this.value);
            }
        }
    },
    methods: {
        customLabel(option){
            return option.text
        }
    },
}
</script>