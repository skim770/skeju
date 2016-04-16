/**
 * Created by gatsby on 11/4/15.
 */
Ext.define('YardTool.store.Instruction', {
    extend: 'Ext.data.Store',
    alias: 'store.instruction',

    /*
     Uncomment to use a specific model class
     model: 'User',
     */
    fields: [
        {name: 'order', type: 'string'},
        {name: 'content', type: 'string'}
    ],
    /*
     Fields can also be declared without a model class:
     fields: [
     {name: 'firstName', type: 'string'},
     {name: 'lastName',  type: 'string'},
     {name: 'age',       type: 'int'},
     {name: 'eyeColor',  type: 'string'}
     ]
     */

    data: {
        items: [
            {order: 0, content: 'Now choose the first "point" of the zone range'},
            {order: 1, content: 'Now choose the next "point (2)" of the zone range'},
            {order: 2, content: 'Now choose the next "point (3)" of the zone range'},
            {order: 3, content: 'Now choose the next "point (4)" of the zone range'}
        ]
    },
    /*
     Uncomment to specify data inline
     data : [
     {firstName: 'Ed',    lastName: 'Spencer'},
     {firstName: 'Tommy', lastName: 'Maintz'},
     {firstName: 'Aaron', lastName: 'Conran'}
     ]
     */

    proxy: {
        type: 'memory',
        reader: {
            type: 'json',
            rootProperty: 'items'
        }
    }
});