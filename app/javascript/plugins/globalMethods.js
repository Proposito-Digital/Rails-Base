export default {
    install (app, options) {
      app.config.globalProperties.copyTextToClipboard = (text)=>{
        navigator.clipboard.writeText(text);
      }
      app.config.globalProperties.submitForm = (id)=>{
        var form_object = document.getElementById(id);
        form_object.submit()
      }
      app.config.globalProperties.toogleSidebar = function(){
        var sidebar = document.getElementById('sidebar');
        sidebar.classList.toggle('collapsed');
      }

    }
}