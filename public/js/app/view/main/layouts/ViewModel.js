Ext.define('YardTool.view.main.layouts.ViewModel', {
    extend: 'Ext.app.ViewModel',
    alias: 'viewmodel.layouts',

    data: {
        svg : '<svg id = "svg" style="z-index: 100; width:100%;height:100%">' +
        '<g id="yard_slot"></g> <g id="dock_door"></g></svg>'
     }

});