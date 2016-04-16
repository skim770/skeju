/**
 * Created by gatsby on 11/4/15.
 */
Ext.define('YardTool.view.main.instruction.View', {
    extend: 'Ext.grid.Panel',
    title: 'Instructions',
    xtype: 'instruction',

    fieldStyle: 'text-align: right',

    requires: [
        'YardTool.store.Instruction'
    ],

    store: {
        type: 'instruction'
    },

    columns: [
        { text: 'Message',  dataIndex: 'content', flex: 1 }
    ]
});