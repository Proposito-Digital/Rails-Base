const sidebardModule = {
  namespaced: true,
  state: () => ({ /* data */
    activeItem: 0,
    collapsed: true
  }),
  mutations: { /* methods */
    INCREASE_ACTIVE_ITEM(state) {
      return state.activeItem += 1;
    },
    TOOGLE_COLAPSE(state) {
      return state.collapsed = !state.collapsed;
    }
  },
  actions: { /* computed */
    increaseActiveItem(context) {
      context.commit('INCREASE_ACTIVE_ITEM');
    },
    toogleCollapse(context) {
      context.commit('TOOGLE_COLAPSE');
    }
  }
}


export const globalStore = {
  modules: {
    sidebardModule: sidebardModule
  }
}