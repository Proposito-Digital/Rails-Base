const sidebarModule = {
  namespaced: true,
  state: () => ({ /* data */
    collapsed: false
  }),
  mutations: { /* methods */
    TOOGLE_SIDEBAR(state) {
      return state.collapsed = !state.collapsed;
    }
  },
  actions: { /* computed */
    toogleSidebar(context) {
      context.commit('TOOGLE_SIDEBAR');
    }
  }
}


export const globalStore = {
  modules: {
    sidebarModule: sidebarModule
  }
}