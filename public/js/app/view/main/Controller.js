/**
 * This class is the controller for the main view for the application. It is specified as
 * the 'controller' of the Main view class.
 *
 * TODO - Replace this content of this view to suit the needs of your application.
 */
Ext.define('YardTool.view.main.Controller', {
    extend: 'Ext.app.ViewController',

    alias: 'controller.main',

    init: function () {
        //Ext.ComponentQuery.query('button#upload')[0].on('click', this.upload);

        this.control({
            'topbutton': {

                afterrender: function () {
                    var browse = Ext.ComponentQuery.query('browse#browse')[0];
/*
                    d3.xml('resources/svg/svg15.svg', 'image/svg+xml', function(error, xml) {
                        if (error) throw error;
                        Ext.getBy.appendChild(xml.documentElement.);
                    });*/

                    browse.fileInputEl.dom.addEventListener('change', function (event) {    // TODO: fix!!!!!!!!!!!!!!!!!!
                            var file = event.target.files[0];
                            var reader = new FileReader();
                            reader.onload = function (e) {
                                Ext.ComponentQuery.query('image#img')[0].setSrc(e.target.result);
                                Ext.ComponentQuery.query('#svg')[0].setWidth(Ext.ComponentQuery.query('image#img')[0].getWidth());
                                Ext.ComponentQuery.query('#svg')[0].setHeight(Ext.ComponentQuery.query('image#img')[0].getHeight());
                            };
                            reader.onerror = function () {
                                console.log('Failed to upload image');
                            };
                            reader.readAsDataURL(file);
                        }
                    );
                }
            }
        });
    },

    upload: function () {



    }
/*
    onItemSelected: function (sender, record) {
        Ext.Msg.confirm('Confirm', 'Delete this data?', 'onConfirm', this);
    }
    ,

    onConfirm: function (choice) {
        if (choice === 'yes') {
            //
        }
    }*/

});
