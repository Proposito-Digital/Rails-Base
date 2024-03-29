export default {
    install (Vue, options) {
      Vue.prototype.copyTextToClipboard = function(text){
        navigator.clipboard.writeText(text);
      }
      Vue.prototype.submitForm = function(id){
        var form_object = document.getElementById(id);
        form_object.submit()
      }
      Vue.prototype.toogleSidebar = function(){
        sidebar = document.getElementById('sidebar');
        sidebar.classList.toggle('collapsed');
      }
    }
}