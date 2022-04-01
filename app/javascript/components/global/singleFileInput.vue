<template>
  <div class="single-file-input-component">
    <div v-if="hasfile" max-height="15">
        <a class="btn outline gray btn-file-attached" :href="file.path" weight=5 target=_blank>
          <i class="bi bi-file-earmark-text"></i>
          <span overflow-hidden> {{ file.name }}</span>
        </a>
    </div>
    <div v-else flex-box flex-wrap flex-gap=1>
      <label :for="targetInput" class="btn outline green btn-attach-file" weight=5>
        <i class="bi bi-paperclip" mr=1></i>{{attachLabel}}
      </label>
      <div v-for="(file, index) in insertedFiles" :key="index" max-height="15">
        <a class="btn outline green btn-new-file-attached" weight=5 >
          <i class="bi bi-file-earmark-text"></i>
          <span overflow-hidden> {{ file.name }}</span>
        </a>
      </div>
      <input type="file" :id="inputId" :name="name" :ref="inputRef" :hidden="true" :multiple="multiple" @change="addFiles">
    </div>
  </div>
</template>

<script>
export default {
  props: {
    name: String,
    id: {
      type: String,
      default: null
    },
    file: {
      type: Object,
      default: null
    },
    attachLabel: {
      type: String,
      default: 'Anexar Arquivo'
    },
    multiple: {
      type: Boolean,
      default: false
    }
  },
  data(){
      return {
          fileInput: null,
      }
  },
  computed: {
    inputId(){
      return this.id || `vue-file-input__${this.name}`;
    },
    inputRef(){
        return this.inputId;
    },
    hasfile(){
        return this.file != null;
    },
    hasInsertedFiles(){
      return this.insertedFiles.length > 0;
    },
    insertedFiles(){
      if(this.fileInput != null)
        return this.fileInput.files;
      return [];
    },
    targetInput(){
      return this.inputId;
    },
  },
  methods: {
    addFiles(event){
      this.fileInput = null;
      this.fileInput = event.target
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