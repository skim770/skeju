Ext.define('YardTool.view.main.layouts.Controller', {
    extend: 'Ext.app.ViewController',
    alias: 'controller.image',

    coords: {},
    cRectId: {},
    countRectId: {},
    cPointId: {},
    countPoint: {},
    seriesId: {},
    currentPointId: {},
    mouseOnPoint: {},
    editing: {},
    data: {},
    img: {},
    zoneIds: {},
    dockIds: {},
    drag: {},
    //cZoneId: {},
    //countZoneId: {},
    // allCoordId: {},
    //allPointId: {},
    //firstPoint: {},

    init: function () {
        this.seriesId = [];
        this.coords = []; // current coordinate values to be shown on #points. Format: // [ [x0,y0], [x1,y1], [x2,y2] , ... , [xn, yn] ]
        this.cRectId = []; // keep track of currently drawn coordinates. Format: [ // 'ln0', 'ln1', 'ln2', 'ln3' ]
        this.countRectId = []; // temporary/simple 'id' to id. individual lines
        this.cPointId = []; // keep track of currently drawn coordinates. Format: [ 'c0', 'c1', 'c2', 'c3' ]
        this.countPoint = 1; // temporary/simple 'id' to id. individual points
        this.currentPointId = -1; // Useful to keep currently clicked pointId
        this.mouseOnPoint = 0; // Is a point clicked? Determines new dot or not.
        this.editing = false; // boolean value to tell if user is editing the existing slots
        this.data = Ext.create('YardTool.store.Data');

        this.drag = false;

        this.img = Ext.ComponentQuery.query('image#img')[0];
        this.zoneIds = []; // all zone/dock id. Format: ['znA', 'znABC','dkA', 'dkABC']
        this.dockIds = [];
        //this.countZoneId = 0; // String.fromCharCode(65 + n); # -(ascii)-> alphabet
        //this.allPointId = []; // keep track of currently drawn coordinates. Format: [ 'c0', 'c1', 'c2', 'c3', 'c4', 'c5', 'c6', ... , 'cn' ]
        //this.allCoordId = []; // keep track of currently drawn coordinates. Format: [ // 'ln0', 'ln1', 'ln2', 'ln3', 'ln4', 'ln5', 'ln6', ... , 'lnn' ]

        var _this = this;
        Ext.ComponentQuery.query('button#draw')[0].on('click', function () {
            _this.drawClick();
        });
        Ext.ComponentQuery.query('button#reset')[0].on('click', function () {
            _this.resetAll();
        });
        Ext.ComponentQuery.query('button#clear')[0].on('click', function () {
            _this.clear();
        });
        Ext.ComponentQuery.query('button#apply')[0].on('click', function () {
            _this.apply();
        });
        Ext.ComponentQuery.query('button#save')[0].on('click', function () {
            _this.apply();
            _this.clear();
        });
        this.control({
            'svg': { //widget name
                click: function (e) {
                    this.svgClick(e);
                }
            }
        });

    },

    svgClick: function (e) {
        /**
         * 1. If drawing new dot:
         *     a. Add a dot if less than 4 drawn (draw)
         *     b. Do not draw if already 4 (prompt user)
         * 2. An existing dot clicked, do not draw (X)
         *     a. If the clicked dot is currently being
         *        drawn, do nothing (X)
         *     b. If it is not, clear the current progress
         *        and load the selected 4 points
         * @type {*|Ext.Component|HTMLElement|Ext.dom.Element}
         */

        this.img = Ext.ComponentQuery.query('image#img')[0];

        if (this.img.getHeight() > 1) {
            if (this.mouseOnPoint == 0) {
                var xy = e.getXY();
                var imgXY = this.img.getXY();
                var x = xy[0] - imgXY[0];
                var y = xy[1] - imgXY[1];
                if (this.cPointId.length < 4) {
                    this.draw(x, y, 3);
                    if (this.cPointId.length == 4) {
                        this.showOptionView();
                    } else if (this.cPointId.length == 1) {
                        Ext.ComponentQuery.query('tools')[0].items.getAt(0).expand();
                    }
                } else {
                    // if 4 points already drawn
                }
            } else {
                if (this.editing) {

                    console.log(this.cPointId);
                    console.log(this.currentPointId);
                    var nslots = Ext.ComponentQuery.query('textfield#nslots')[0].getValue();
                    var item = d3.select('svg').select('#'+this.currentPointId);
                    var isZone = (item.attr('class') == 'slot') ? true : false;
                    var name = item.attr('dockzone');
                    this.drawSlot(nslots,isZone,name); // slots, isZone, name
                }
            }
        }
    },

    showOptionView: function () {
        Ext.ComponentQuery.query('option#option')[0].setHidden(false);
        if (this.editing) {
            Ext.ComponentQuery.query('button#draw')[0].setHidden(true);
            Ext.ComponentQuery.query('button#apply')[0].setHidden(false);
            Ext.ComponentQuery.query('button#save')[0].setHidden(false);
        }
    },
    hideOptionView: function () {
        Ext.ComponentQuery.query('option#option')[0].setHidden(true);
        if (this.editing) {
            Ext.ComponentQuery.query('button#draw')[0].setHidden(false);
            Ext.ComponentQuery.query('button#apply')[0].setHidden(true);
            Ext.ComponentQuery.query('button#save')[0].setHidden(true);
        }
    },
    updateZoneView: function (isZone, name) {
        var store = Ext.getStore('zone');
        if (this.zoneIds.indexOf(name) != -1) {
            // nothing
        } else {
            this.zoneIds.push(name);
            var n = store.getRoot().createNode({text: name, id: name.toLowerCase()}); // to update slot view
            store.getRoot().appendChild(n);
        }
    },
    updateZoneSlotView: function (isZone, name) {
        var store = Ext.getStore('zone');
        for (var i = 0; i < store.getRoot().childNodes.length; i++) {
            if (store.getRoot().getChildAt(i).id == name.toLowerCase()) {
                var seriesName = 'Series' + (store.getRoot().getChildAt(i).childNodes.length + 1) ;
                var curr = store.getRoot().getChildAt(i).appendChild({text: seriesName, id: seriesName.toLowerCase()});
                for (var k = 0; k < this.cRectId.length; k++)
                    curr.appendChild({
                        text: this.cRectId[k],
                        leaf: true
                    });
                break;
            }
        }
    },
    updateDockView: function (isZone, name) {
        var store = Ext.getStore('dock');
        if (this.dockIds.indexOf(name) != -1) {
            // nothing
        } else {
            this.dockIds.push(name);
            var n = store.getRoot().createNode({text: name, id: name.toLowerCase()});
            store.getRoot().appendChild(n);
        }
    },
    updateDockDoorView: function (isZone, name) {
        var store = Ext.getStore('dock');
        for (var i = 0; i < store.getRoot().childNodes.length; i++) {
            if (store.getRoot().getChildAt(i).id == name.toLowerCase()) {
                var seriesName = 'Series' + (store.getRoot().getChildAt(i).childNodes.length + 1) ;
                var curr = store.getRoot().getChildAt(i).appendChild({text: seriesName, id: seriesName.toLowerCase()});
                for (var k = 0; k < this.cRectId.length; k++)
                    curr.appendChild({
                        text: this.cRectId[k],
                        leaf: true
                    });
                break;
            }
        }
    },
    changePointStore: function (id, x, y) {
        var store = Ext.getStore('point');
        var item = store.getAt(this.cPointId.indexOf(id));
        //var item = store.getAt(0); // testing !
        item.set('x', x);
        item.set('y', y);
        item.commit();
    },
    updateData: function (isZone, name) {
        var root = (isZone) ? this.data.data.items[0].data['zones'] : this.data.data.items[0].data['docks'];
        
        if (find(root, 'id', name)) { // existing zone/dock
            //
        } else { // new zone/dock
            var node = {};
            node['id'] = name;
            node['val'] = [];
            var temp = {};
            temp['id'] = this.seriesId[name];
            temp['p'] = this.cPointId;
            temp['r'] = this.cRectId;
            temp  = JSON.parse(JSON.stringify(temp));
            node  = JSON.parse(JSON.stringify(node));
            node['val'].push(temp);
            root.push(node);
        }


        //return JSON.parse(a);
    },
    find: function (obj, key, val) {
        for (var i in obj) {
            if (obj[i][key] == val) {
                return obj[i];
            }
        }
        return null;
    },

    edit: function (itemId) {
        this.currentPointId = itemId;
        var zoneId = d3.select('svg').select('#'+itemId).attr('dockzone');
        var isZone = (d3.select('svg').select('#'+itemId).attr('type') == 'pSlot') ? true : false;
        //var layer = d3.select('svg').select('#'+itemId).attr('');
        //var layerN = layer.substring(0,layer.length-3);
        // cPointId, cRectId
        for (m in this.data.data.items[0].data['zones']) {
            var z = this.data.data.items[0].data['zones'][m];
            if (z.id == zoneId) {
                for (n in z.val) {
                    var series = z.val[n];
                    if (series.p.indexOf(itemId) >= 0) {
                        var index = series.id;
                        this.cPointId = series.p;
                        this.cRectId = series.r;
                        break;
                    }
                }
            }
        }
        this.reloadPointView(this.cPointId);
        this.showOptionView();
        return index;
    },
    reloadPointView: function (cp) {
        var temp = [];
        for (id in cp) {
            var thing = d3.select('svg').select('#'+cp[id]).attr('transform').split('(')[1].substring(0,(d3.select('svg').select('#'+cp[id]).attr('transform').split('(')[1]).length-1).split(',');
            temp.push(parseInt(thing[0]));
            temp.push(parseInt(thing[1]));
            this.coords.push([parseInt(d3.select('svg').select('#'+cp[id]).attr('cx'))+parseInt(thing[0]),parseInt(d3.select('svg').select('#'+cp[id]).attr('cy'))+parseInt(thing[1])]);
        }
        Ext.getStore('point').setData([
            {order: 1, x: parseInt(d3.select('svg').select('#'+cp[0]).attr('cx'))+temp[0], y: parseInt(d3.select('svg').select('#'+cp[0]).attr('cy'))+temp[1]},
            {order: 2, x: parseInt(d3.select('svg').select('#'+cp[1]).attr('cx'))+temp[2], y: parseInt(d3.select('svg').select('#'+cp[1]).attr('cy'))+temp[3]},
            {order: 3, x: parseInt(d3.select('svg').select('#'+cp[2]).attr('cx'))+temp[4], y: parseInt(d3.select('svg').select('#'+cp[2]).attr('cy'))+temp[5]},
            {order: 4, x: parseInt(d3.select('svg').select('#'+cp[3]).attr('cx'))+temp[6], y: parseInt(d3.select('svg').select('#'+cp[3]).attr('cy'))+temp[7]}
        ]);
    },

    draw: function (x, y, size) {
        var _this = this;
        this.currentPointId = 'c' + this.countPoint; // replace with hash function
        var drag = this.defineDrag(x, y);
        this.cPointId.push(this.currentPointId);
        d3.select('svg').append('circle').call(drag).attr('class', 'draggable').attr( //.attr('class', 'click-point')
            'cx', x).attr('cy', y).attr('r', size).attr('transform', 'translate(0,0)').attr('id',//
            this.currentPointId).on({

            'mouseover': function () {
                _this.mouseOnPoint = 1;
                // svg.select('#'+ this.id).attr('fill', 'pink');
            },
            'mouseout': function () {
                _this.mouseOnPoint = 0;
            },
            'mousedown': function () {
                _this.currentPointId = this.id;
                if (_this.cPointId.indexOf(this.id) < 0) {
                    // remove current SVG
                    _this.clear();
                    _this.editing = true;
                    _this.edit(this.id);
                    Ext.ComponentQuery.query('tools')[0].items.getAt(0).expand();
                }

            },
            'click': function () {
            }
        });

        this.changePointStore(this.currentPointId, x, y);
        this.coords.push([x, y]);
        this.countPoint++;

    },
    defineDrag: function (cursorX, cursorY) {
        var _this = this;
        return d3.behavior.drag().on("dragstart", function(){
            //do some drag start stuff...
        }).on('drag', function () {
            _this.drag = true;
            var x = d3.event.x - cursorX;
            var y = d3.event.y - cursorY;
            d3.select(this).attr('transform', 'translate(' + x + ',' + y + ')');
            _this.changePointStore(_this.currentPointId, x + cursorX, y + cursorY);
            _this.coords[_this.cPointId.indexOf(_this.currentPointId)] = [x + cursorX, y + cursorY];
        }).on("dragend", function(){
            if (_this.drag && _this.editing) {
                _this.drag = false;
                _this.apply();
            }
            });
    },
    apply: function() {
        console.log(this.cRectId);
        var series = this.removeRectSVG(this.cRectId);
        var nslots = Ext.ComponentQuery.query('textfield#nslots')[0].getValue();
        var item = d3.select('svg').select('#'+this.currentPointId); // problem
        var isZone = (item.attr('class') == 'Slot') ? true : false;
        var name = item.attr('dockzone');
        this.drawSlot(nslots,isZone,name, series); // slots, isZone, name
        this.updateData(isZone, name);
        if (isZone) {
            this.updateZoneSlotView(isZone, name);
        } else {
            this.updateDockDoorView(isZone, name);
        }
    },
    drawClick: function () {
        /**
         * When 'Draw' is clicked, the corresponding lines are drawn.
         * The corresponding Zone/Dock is updated
         */
        var name = Ext.ComponentQuery.query('textfield#name')[0].getValue();
        var isZone = Ext.getCmp('radiozone').value;
        for (n in this.cPointId) {
            d3.select('svg').select('#'+this.cPointId[n]).attr('class',(isZone)?'pSlot':'pDoor').attr('dockzone',name);
        }
        var tools = Ext.ComponentQuery.query('tools')[0];
        if (isZone) {
            this.updateZoneView(isZone, name);
            tools.items.getAt(1).expand();
        } else {
            this.updateDockView(isZone, name);
            tools.items.getAt(2).expand();
        }
        var nslots = Ext.ComponentQuery.query('textfield#nslots')[0].getValue();
        this.drawSlot(nslots, isZone, name, null);
        // update store with new data
        this.updateData(isZone, name);
        if (isZone) {
            this.updateZoneSlotView(isZone, name);
        } else {
            this.updateDockDoorView(isZone, name);
        }

        this.seriesId[name]++;
        this.clear();
    },
    drawSlot: function (slots, isZone, name, seriesIndex) { // TODO: update series number

        var deltaAx = (this.coords[3][0] - this.coords[0][0]) / slots;
        var deltaAy = (this.coords[3][1] - this.coords[0][1]) / slots;

        var ds = name[0] + name.substring(1).replace(/[aeiou]/ig, '');
        var cls = (isZone) ? 'Slot' : 'Door';

        this.seriesId[name] = (this.seriesId[name] == null) ? 1 : this.seriesId[name];
        var series = (seriesIndex == null) ? (this.seriesId[name]) : seriesIndex;


        for (var i = 0; i < slots; i++) { // for 40 spots we draw 39 lines --
            // 1-39.
            var Ax = this.coords[0][0] + deltaAx * i;
            var Ay = this.coords[0][1] + deltaAy * i;
            var Bx = Ax + deltaAx;
            var By = Ay + deltaAy;
            var Dx = this.coords[1][0] + deltaAx * i;
            var Dy = this.coords[1][1] + deltaAy * i;

            var dsn = ((i+1) < 10) ? '0' + (i+1) : (i+1).toString();
            var doorslot = ds + dsn;
            var id = cls.toLowerCase() + '_' + name.toLowerCase() + '_' + series + '_' + (i+1); // slot/door_name_series_order

            this.drawRect([Ax, Ay], [Bx, By], [Dx, Dy], isZone, cls, id, name, doorslot);
        }

    },
    drawRect: function (a, b, d, isZone, cls, id, name, doorslot) { // add color input. TODO: add expl-
        //if (seriesIn == null)
        //    var series = this.layerN;
        //var seriesIdF = 1000 * this.seriesId[name] + this.countRectId[name];
        //var id = name + '_' + doorslot + '_L_' + seriesIdF + '_' + cls.toLowerCase();

        var w = Math.sqrt(Math.pow(b[0] - a[0], 2) + Math.pow(b[1] - a[1], 2));
        var h = (b[0] * d[1] - b[0] * a[1] - a[0] * d[1] - d[0] * b[1] + d[0] * a[1] + a[0] * b[1]) / w;
        var rDegree = Math.acos(Math.abs(b[0] - a[0]) / w) * 180 / Math.PI;
        var ad = Math.sqrt(Math.pow(a[0] - d[0], 2) + Math.pow(a[1] - d[1], 2));
        var sDegree = Math.asin(h / ad) * 180 / Math.PI - 270;
        var transform = 'translate(' + a[0] + ',' + a[1] + ') skewX(' + sDegree + ') rotate(-' + rDegree + ',0,0)';
        // The line SVG Path we draw
        var svg = (isZone) ? d3.select('g#yard_slot') : d3.select('g#dock_door');
        svg.append('rect').attr('class', cls).attr('id', id).attr('width', w).attr('height', h).attr('dockzone', name).attr('doorslot', doorslot)
            .attr('transform', transform).attr('fill', 'none').attr('stroke', 'blue').attr('stroke-width', 2);
        this.cRectId.push(id);
    },
    removeRectSVG: function(cr) { // returns series # of that zone
        for (id in cr) {
            d3.select('svg').select('#'+cr[id]).remove();
        }
        var series = d3.select('svg').select('#'+cr[0]).attr('id').split('_')[3];
        this.cRectId.length = 0;
        return series;

    },
    removePointSVG: function(cp) {
        for (id in cp) {
            d3.select('svg').select('#'+cp[id]).remove();
        }
        this.cPointId = [];
    },
    clear: function () {
        // if svg is not clear (could be if called from resetAll), remove current SVG - add function
        //this.removePointSVG(this.cPointId);
       // this.removeRectSVG(this.cRectId);
        this.cRectId = [];
        this.cPointId = [];
        //this.currentPointId = -1;
        //this.currentRectId = -1;
        this.coords = [];
        this.editing = false;
        this.hideOptionView();
        this.resetPointView();
    },
    resetAll: function () {
        d3.select('svg').selectAll('*').remove();
        this.clear();
        var zStore = Ext.getStore('zone');
        //var dStore = Ext.getStore('dock');
        zStore.removeAll();
        //dStore.removeAll();
        zStore.reload();
        dStore.reload();
    },
    resetPointView: function () {
        Ext.getStore('point').setData([
            {order: 1, x: '-', y: '-'},
            {order: 2, x: '-', y: '-'},
            {order: 3, x: '-', y: '-'},
            {order: 4, x: '-', y: '-'}
        ]);
    }
});
