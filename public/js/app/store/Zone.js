/**
 * Created by ylee on 11/5/2015.
 */
Ext.define('YardTool.store.Zone', {
    extend: 'Ext.data.TreeStore',
    alias: 'store.zone',
    storeId: 'zone',

    root: {
        expanded: true
    }
});

/**
 *  { text: 'B', expanded: true, children:
 *      [
             { text: '1', leaf: true },
             { text: '2'}
        ]},
 */