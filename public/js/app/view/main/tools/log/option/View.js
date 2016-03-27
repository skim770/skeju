/**
 * Created by gatsby on 11/15/15.
 */
Ext.define('YardTool.view.main.tools.log.option.View', {
    extend: 'Ext.Container',
    width: '100%',
    xtype: 'option',
    style: 'top: 5px',

    items: [
        {
            xtype: 'textfield',
            itemId: 'name',
            name: 'name',
            fieldLabel: 'ID',
            allowBlank: false,
            style: 'margin-bottom: 5px',
            width: '100%'
        },
        {
            xtype: 'fieldcontainer',
            itemId: 'type',
            fieldLabel : 'Type',
            defaultType: 'radiofield',
            layout: 'hbox',
            style: 'margin-bottom: 5px',
            items: [
                {
                    boxLabel  : 'Zone',
                    name      : 'type',
                    inputValue: 'zone',
                    id        : 'radiozone'
                },
                {
                    boxLabel  : 'Dock',
                    name      : 'type',
                    inputValue: 'dock',
                    id        : 'radiodock'
                }
            ]
        },
        {
            xtype: 'textfield',
            itemId: 'nslots',
            name: 'nslots',
            fieldLabel: '# of slots',
            allowBlank: false,
            style: 'margin-bottom: 5px',
            width: '100%'
        },
        {
            xtype: 'button',
            itemId: 'draw',
            text: 'Draw',
            width: '100%'
        },
        {
            xtype: 'button',
            itemId: 'apply',
            text: 'Apply Changes',
            width: '100%',
            hidden: true
        },
        {
            xtype: 'button',
            itemId: 'save',
            text: 'Save',
            width: '100%',
            hidden: true
        }

        /* include child components here */
    ]
});