Ext.define('YardTool.store.Point', {
    extend: 'Ext.data.Store',

    alias: 'store.point',
    storeId: 'point',

    fields: [
        'order', 'x', 'y'
    ],

    data: {
        items: [
            { order: 1,     x: '-',    y: '-' },
            { order: 2,     x: '-',    y: '-' },
            { order: 3,     x: '-',     y: '-' },
            { order: 4,     x: '-',      y: '-' }
        ]
    },

    proxy: {
        type: 'memory',
        reader: {
            type: 'json',
            rootProperty: 'items'
        }
    }
});
