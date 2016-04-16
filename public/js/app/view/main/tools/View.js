
Ext.define('YardTool.view.main.tools.View', {
    extend: 'Ext.panel.Panel',
    xtype: 'tools',


    width: '15%',

    defaults: {
        // applied to each contained panel
        //bodyStyle: 'padding:5px'
    },
    layout: {
        // layout-specific configs go here
        type: 'accordion',
        titleCollapse: true,
        animate: true
        //activeOnTop: true
    },

    items: [
        {
            xtype: 'log'
        },
        {
            xtype: 'zone'
        },
        {
            xtype: 'dock'
        }
    ]
});