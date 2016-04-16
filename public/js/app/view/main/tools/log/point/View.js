/**
 * This view is an example list of people.
 */
Ext.define('YardTool.view.main.tools.log.point.View', {
    extend: 'Ext.grid.Panel',
    xtype: 'point',
    requires: [
        'YardTool.store.Point'
    ],

    width: '100%',

    //title: 'Point',

    store: {
        type: 'point'
    },

    columns: [
        { text: '#',  dataIndex: 'order', flex: 1 },
        { text: 'X', dataIndex: 'x', flex: 1 },
        { text: 'Y', dataIndex: 'y', flex: 1 }
    ],

    listeners: {
        select: 'onItemSelected'
    }
});
