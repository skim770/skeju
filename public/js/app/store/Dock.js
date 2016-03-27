/**
 * Created by ylee on 11/5/2015.
 */
Ext.define('YardTool.store.Dock', {
    extend: 'Ext.data.TreeStore',
    alias: 'store.dock',
    storeId: 'dock',

    root: {
        expanded: true
    }

});