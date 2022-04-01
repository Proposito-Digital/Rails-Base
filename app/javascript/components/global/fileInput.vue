<template>
    <div>
        <label :for="targetInput" class="btn outline gray small attach-file topic" weight=5>
            <i class="bi bi-paperclip" mr=1></i>{{attachLabel}}
        </label>
        <div v-if="hasFiles" flex-box flex-wrap max-height="15" overflow-y-scroll>
            <div v-for="(fileInput, inputIndex) in fileInputs" :key="inputIndex">
                <label v-for="(file, fileIndex) in fileInput.files" :key="fileIndex" class="btn outline gray small attach-file file-attached topic" weight=5>
                    <i class="bi bi-file-earmark-text"></i>
                    <span overflow-hidden> {{ file.name }}</span>
                    <i class="bibi bi-x-circle remove-btn" ml=0.5 @click="removeFileInput(inputIndex)"></i>
                </label>
            </div>
        </div>
        <div v-else-if="hasExistentFiles" flex-box flex-wrap max-height="15" overflow-y-scroll>
            <div v-for="(file, index) in existentFiles" :key="index">
                <a class="btn outline blue small attach-file file-attached topic" :href="file.path" weight=5>
                    <i class="bi bi-file-earmark-text"></i>
                    <span overflow-hidden> {{ file.name }}</span>
                </a>
            </div>
        </div>
        <input v-for="index in inputsAmount" :key="index" type="file" @change="addFiles" :id="inputId(index)" :name="name" :multiple="multiple" :ref="inputRef(index)" :hidden="true">
    </div>
</template>

<script>
export default {
    props: {
        name: String,
        id: String,
        multiple: false,
        limit: null,
        existentFiles: {
            type: Array,
            default: []
        },
        attachLabel: {
            type: String,
            default: 'Anexar arquivo(s)'
        }
    },
    data(){
        return {
            fileInputs: [],
        }
    },
    computed:{
        emptyInputId(){
            return `${this.inputId}__empty`;
        },
        targetInput(){
            return this.inputId(this.inputsAmount);
        },
        hasFiles(){
            return this.insertedFiles.length > 0;
        },
        hasExistentFiles(){
            return this.existentFiles.length > 0;
        },
        insertedFiles(){
            var _files = [];
            this.fileInputs.forEach(input=>{_files = [..._files, ...input.files]});
            return _files;
        },
        inputsAmount(){
            return this.fileInputs.length + 1;
        }
    },
    methods: {
        inputId(index){
            return `vue-file-input__${this.name}__${index}`;
        },
        inputRef(index){
            return this.inputId(index);
        },
        addFiles(event){
            this.fileInputs.push(event.target);
        },
        removeFileInput(inputIndex){
            var _refElement = this.$refs[this.inputRef(inputIndex+1)][0];
            this.fileInputs = this.fileInputs.filter((input, index)=>index!=inputIndex);
            if(this.inputsAmount > 2){
                _refElement.remove();
            } else {
                _refElement.value = "";
            }

        },
        formatFileSize(bytes, decimalPoint) {
            if(bytes == 0) return '0 Bytes';
            var k = 1000,
                dm = decimalPoint || 2,
                sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'],
                i = Math.floor(Math.log(bytes) / Math.log(k));
            return parseFloat((bytes / Math.pow(k, i)).toFixed(dm)) + ' ' + sizes[i];
        }
    }
}
</script>