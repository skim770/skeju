
Ext.define('YardTool.view.main.buttons.View', {
    extend: 'Ext.toolbar.Toolbar',
    xtype: 'topbutton',

        items: [
            {
                xtype: 'button',
                name: 'clear',
                text: 'Clear',
                itemId: 'clear'
            },
            {
                xtype: 'button',
                name: 'reset',
                text: 'Reset All',
                itemId: 'reset'
            },
            {
                xtype: 'button',
                name: 'generate',
                text: 'Generate SVG XML',
                itemId: 'generate',
                listeners: {
                    click: function() {
                            if (Ext.ComponentQuery.query('image#img')[0].getHeight() > 0) {
                                //hideAllCircleSVG();
                                // get svg element.
                                var svg = document.getElementById("svg");
                                // get svg source.
                                var serializer = new XMLSerializer();
                                var source = serializer.serializeToString(svg);

                                // add name spaces.
                                if (!source
                                        .match(/^<svg[^>]+xmlns="http\:\/\/www\.w3\.org\/2000\/svg"/)) {
                                    source = source.replace(/^<svg/,
                                        '<svg xmlns="http://www.w3.org/2000/svg"');
                                }
                                if (!source.match(/^<svg[^>]+"http\:\/\/www\.w3\.org\/1999\/xlink"/)) {
                                    source = source.replace(/^<svg/,
                                        '<svg xmlns:xlink="http://www.w3.org/1999/xlink"');
                                }

                                // add xml declaration
                                source = '<?xml version="1.0" standalone="no"?>\r\n' + source;

                                // convert svg source to URI data scheme.
                                // set url value to a element's href attribute.
                                //document.getElementById("link").href = url;
                                Ext.ComponentQuery.query('box#svgxml')[0].getEl().dom.href = "data:image/svg+xml;charset=utf-8,"  + encodeURIComponent(source);
                                // you can download svg file by right click menu.
                                //showAllCircleSVG();
                            }
                        }
                    }

            },
            {
                xtype: 'box',
                itemId: 'svgxml',
                autoEl: {tag: 'a', href: '', html: 'SVG-XML'}
            },
            {
                xtype: 'tbfill'
            },
            {
                xtype: 'browse',
                itemId: 'browse'
            }
        ]
});