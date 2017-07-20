//Global config
var graphWidth = 1000;
var graphHeight = 500;

var leftYPos = 50;
var rightYPos = 150;
var aYPos = 250;
var bYPos = 350;

var synapsesDrawn = false;
var gridDrawn = false;
var socket;


$(document).ready(function(){
    console.log("Connecting");
    socket = io.connect('http://localhost:3000');
    prepareSockets();
    //Draw the mario grid
    drawMarioGrid();
    //Draw network
    //Called once on init
});

function prepareSockets() {
    socket.on('test', function(data) {
        console.log(data);
    });

    socket.on('grid', function(data) {
        updateGrid(data);
        gridDrawn = true;
    });

    socket.on('synapses_update',function(data){
        if (synapsesDrawn && gridDrawn) {
            updateNetworkStates(data);
        }
    });

    socket.on('synapses', function(data) {
        console.log(data);
        $('svg').empty();
        
        drawNetwork(data.synapses, function(){
            console.log("Drew Network");

            d3.select("svg").append("text")
                .attr("x",graphWidth - 25)
                .attr("y",leftYPos)
                .text("Left");
            d3.select("svg").append("text")
                .attr("x",graphWidth - 25)
                .attr("y",rightYPos)
                .text("Right");
            d3.select("svg").append("text")
                .attr("x",graphWidth - 25)
                .attr("y",aYPos)
                .text(" A");
            d3.select("svg").append("text")
                .attr("x",graphWidth - 25)
                .attr("y",bYPos)
                .text(" B");

            //Add text to nodes that aren't input/output
            $(".node").each(function(i, el){
                var type = el.getAttribute("type");
                if(type==3){
                    var x = parseInt(el.getAttribute("cx")) + 10;
                    var y = parseInt(el.getAttribute("cy")) + 10;
                    if(x && y){
                        d3.select("svg").append("text")
                            .attr("x",x)
                            .attr("y",y)
                            .attr("class","node-label")
                            .text(el.getAttribute("label"))
                    }
                }
            });

            //Add text to lines to show historicalMarker
            $(".link").each(function(i,el){
                var historicalMarking = el.getAttribute("marking");
                var x = (parseInt(el.getAttribute("x1")) + parseInt(el.getAttribute("x2")))/2 + 10;
                var y = (parseInt(el.getAttribute("y1")) + parseInt(el.getAttribute("y2")))/2 + 10;
                if(x && y && historicalMarking){
                    d3.select("svg").append("text")
                        .attr("x",x)
                        .attr("y",y)
                        .attr("class","link-label")
                        .text(historicalMarking)
                }
            });
            synapsesDrawn = true;
        });
    });
}