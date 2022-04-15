import { mapActions, mapState } from 'vuex' 
export default{
  computed: {
    sidebarClass(){
      return {
        'collapsed': this.collapsed
      }
    },
    ...mapState('sidebarModule', ['collapsed'])
  },
  methods: {
    ...mapActions('sidebarModule', ['toogleSidebar'])
  }
}