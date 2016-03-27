/**
 * Created by ylee on 11/17/2015.
 */
Ext.define('YardTool.store.Data', {
    extend: 'Ext.data.Store',
    autoLoad: true,
    alias: 'store.data',
    storeId: 'data',

    proxy: {
        type: 'rest',
        url : '/',
        reader:{
            type: 'json',
            root: '/'
        }
    },
    /*
    Uncomment to use a specific model class
    model: 'User',
    */

    /*
    Fields can also be declared without a model class:
    fields: [
        {name: 'firstName', type: 'string'},
        {name: 'lastName',  type: 'string'},
        {name: 'age',       type: 'int'},
        {name: 'eyeColor',  type: 'string'}
    ]
    */


    data : [
        {
            'zones': [{
                'id': 'Test',
                'val': [{
                    'id': '',
                    'p': [],
                    'r': []
                }]
            }],
            'docks': [{
                'id': 'Test',
                'val': [{
                    'id': '',
                    'p': [],
                    'r': []
                }]
            }]
        }
    ]

});