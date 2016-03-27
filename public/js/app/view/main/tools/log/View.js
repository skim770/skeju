/**
 * Created by gatsby on 11/16/15.
 */
Ext.define('YardTool.view.main.tools.log.View', {
    extend: 'Ext.panel.Panel',
    xtype: 'log',
    layout: 'auto',
    title: 'Points',
    items: [
        {
            xtype: 'point',
            itemId: 'point'
        },
        {
            xtype: 'option',
            itemId: 'option',
            hidden: true
        }
    ]
});