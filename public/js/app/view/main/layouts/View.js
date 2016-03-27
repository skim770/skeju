/**
 * Created by ylee on 11/6/2015.
 */
Ext.define('YardTool.view.main.layouts.View', {
    extend: 'Ext.panel.Panel',
    xtype: 'layouts',

    requires: [
        'YardTool.view.main.layouts.Controller',
        'YardTool.view.main.layouts.ViewModel'
    ],

    controller: 'image',
    viewModel: 'layouts',

    layout: {
        type: 'absolute'
    },

    x: 0,
    y: 0,

    items: [
        {
            extend: 'Ext.Img',
            xtype: 'image',
            alt: 'No image',
            itemId: 'img'
            // draggable: true,
        },
        {
            xtype: 'svg',
            itemId: 'svg',
            bodyStyle: 'background:transparent;',
            width: '0',
            height: '0'
        }
    ]
});