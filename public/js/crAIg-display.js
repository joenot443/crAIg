//Global config
var graphWidth = 750;
var graphHeight = 750;

var watchingSocket = false;

$(document).ready(function(){
    //Add SVG to stage

    //Draw network
    //Called once on init
    var socket = io.connect('http://localhost');
    socket.on('synapses', function(data) {
        console.log(data);

        $("svg").remove();

        d3.select("body")
        .append("svg")
            .attr("width", graphWidth+20)
            .attr("height", graphHeight+20);

            
        //Draw the mario grid
        drawMarioGrid();


        drawNetwork(data.synapses, function(){
            console.log("Drew Network");

            d3.select("svg").append("text")
                .attr("x",760)
                .attr("y",105)
                .text("Left");
            d3.select("svg").append("text")
                .attr("x",760)
                .attr("y",155)
                .text("Right");
            d3.select("svg").append("text")
                .attr("x",760)
                .attr("y",205)
                .text("A");
            d3.select("svg").append("text")
                .attr("x",760)
                .attr("y",255)
                .text("B");

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

            $("#watch-socket").click(function(){
                //Start watching socket
                if(!watchingSocket){
                    socket.on('grid', function(data) {
                      updateGrid(data);
                    });

                    socket.on('synapses_update',function(data){
                        updateNetworkStates(data);
                    });
                    
                    watchingSocket = true;
                }
            });
        });
    });
});