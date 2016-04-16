/**
 * Created by ylee on 11/5/2015.
 */
Ext.define('YardTool.view.main.tools.zone.View', {
    extend: 'Ext.tree.Panel',
    xtype: 'zone',
    requires: [
        'YardTool.store.Zone'
    ],

    width: '100%',

    title: 'Zones',
    store: {
        type: 'zone'
    },
    rootVisible: false
});