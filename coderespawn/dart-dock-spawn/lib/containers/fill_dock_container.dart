part of dock_spawn;

class FillDockContainer implements IDockContainer {
  String containerType = "fill";
  DivElement element;
  DockManager dockManager;
  TabHost tabHost;
  int tabOrientation = TabHost.DIRECTION_BOTTOM;
  int get minimumAllowedChildNodes { return 2; }
  String name;
  
  FillDockContainer(this.dockManager, [int tabStripDirection = TabHost.DIRECTION_BOTTOM]) {
    this.tabOrientation = tabStripDirection;
    name = getNextId("fill_");
    element = new DivElement();
    element.classes.add("dock-container");
    element.classes.add("dock-container-fill");
    
    tabHost = new TabHost(tabOrientation);
    element.nodes.add(tabHost.hostElement);
  }

  
  void setActiveChild(IDockContainer child) {
    tabHost.setActiveTab(child);
  }
  
  void resize(int _width, int _height) {
    element.style.width = "${_width}px";
    element.style.height = "${_height}px";
    tabHost.resize(_width, _height);
  }
  
  void performLayout(List<IDockContainer> children) {
    tabHost.performLayout(children);
  }
  
  void destroy() {
    element.remove();
    element = null;
  }

  void saveState(Map<String, Object> state) {
    state['width'] = width;
    state['height'] = height;
  }
  
  void loadState(Map<String, Object> state) {
    width = state['width'];
    height = state['height'];
  }
  
  Element get containerElement {
    return element;
  }

  
  int get width => element.client.width;
  set width(int value) => element.style.width = "${value}px";
  
  int get height => element.client.height;
  set height(int value) => element.style.height = "${value}px";
  
}
