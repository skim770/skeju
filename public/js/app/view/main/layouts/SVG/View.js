/**
 * Created by ylee on 11/11/2015.
 */
Ext.define('YardTool.view.main.layouts.SVG.View', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.svg',
    xtype: 'svg',
    //draggable: true,
    frame: false,

    bind: {
        html: '{svg}'
    },

    listeners: {
        click: {
            element: 'el',
            fn: function (e, target) {
                var panel = Ext.getCmp(this.id);
                panel.fireEvent('click', e); // fire 'click' event from panel
            }
        }
    }
});