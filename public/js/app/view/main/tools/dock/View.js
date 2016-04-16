/**
 * Created by ylee on 11/5/2015.
 */
Ext.define('YardTool.view.main.tools.dock.View', {
    extend: 'Ext.tree.Panel',
    xtype: 'dock',
    requires: [
        'YardTool.store.Dock'
    ],

    width: '100%',

    title: 'Docks',
    store: {
        type: 'dock'
    },
    rootVisible: false
});