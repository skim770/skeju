/**
 * This class is the main view for the application. It is specified in app.js as the
 * "mainView" property. That setting automatically applies the "viewport"
 * plugin causing this view to become the body element (i.e., the viewport).
 *
 * TODO - Replace this content of this view to suite the needs of your application.
 */
Ext.define('YardTool.view.main.View', {
    extend: 'Ext.panel.Panel',
    xtype: 'app-main',

    requires: [
        'Ext.plugin.Viewport',
        'Ext.window.MessageBox',

        'YardTool.view.main.Controller',
        'YardTool.view.main.ViewModel'
    ],

    controller: 'main',
    viewModel: 'main',

    header: {
        layout: {
            align: 'stretchmax'
        },
        title: {
            bind: {
                text: '{name}' // Sidebar title calls for 'name'
            },
            flex: 0
        }
    },


    responsiveConfig: {
        tall: {
            headerPosition: 'top'
        },
        wide: {
            headerPosition: 'left'
        }
    },

    defaults: {
        bodyPadding: 20,
        tabConfig: {
            plugins: 'responsive',
            responsiveConfig: {
                wide: {
                    iconAlign: 'left',
                    textAlign: 'left'
                },
                tall: {
                    iconAlign: 'top',
                    textAlign: 'center',
                    width: 120
                }
            }
        }
    },


    items: [
        {
            xtype: 'topbutton'
        },
        {
            xtype: 'panel',
            layout: 'border',
            height: 680,  //860 - dell, 1310- imac, 680  - macbook

            items: [{
                // xtype: 'panel' implied by default
                region: 'east',
                xtype: 'tools',
                split: true,
                collapsible: true
            },{
               region: 'center',     // center region is required, no width/height specified
                xtype: 'layouts'
                //split: true
            }]
        }
    ]
});
