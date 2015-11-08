var testNetwork = {
    synapses: [
        {
            historicalMarking: 23,
            to: 170,
            from: 25,
            weight: 50
        },
        {
            historicalMarking: 30,
            to: 171,
            from: 120,
            weight: 10
        },
        {
            historicalMarking: 45,
            to: 180,
            from: 124,
            weight: 10
        },
        {
            historicalMarking: 46,
            to:172,
            from: 180,
            weight: 5
        },
        {
            historicalMarking: 50,
            to: 180,
            from: 55
        }
    ]
}


//Global config
var graphWidth = 750;
var graphHeight = 750;

$(document).ready(function(){
    //Add SVG to stage
    d3.select("body")
    .append("svg")
        .attr("width", graphWidth+20)
        .attr("height", graphHeight+20);

    //Draw the mario grid
    drawMarioGrid();

    //Draw network
    drawNetwork(testNetwork, function(){
        //Now that everything is loaded, we can bind buttons
        $(".node").hide();
        $(".link").hide();
        $(".node-label").hide();
        $(".link-label").hide();

        //Attach event handlers
        $("#show-network").click(function(){
            if($(this).is(":checked")){
                $(".node").show();
                $(".link").show();
            } else {
                $(".node").hide();
                $(".link").hide();
            }
        });

        $("#show-labels").click(function(){
            if($(this).is(":checked")){
                $(".node-label").show();
                $(".link-label").show();
            } else {
                $(".node-label").hide();
                $(".link-label").hide();
            }
        });

        //Add text to nodes that aren't input/output
        $(".node").each(function(i, el){
            var type = el.getAttribute("type");
            if(type==3){
                var x = parseInt(el.getAttribute("cx")) + 10;
                var y = parseInt(el.getAttribute("cy")) + 10;
                d3.select("svg").append("text")
                    .attr("x",x)
                    .attr("y",y)
                    .attr("class","node-label")
                    .text(el.getAttribute("label"))
            }
        });

        //Add text to lines to show historicalMarker
        $(".link").each(function(i,el){
            var historicalMarking = el.getAttribute("marking");
            var x = (parseInt(el.getAttribute("x1")) + parseInt(el.getAttribute("x2")))/2 + 10;
            var y = (parseInt(el.getAttribute("y1")) + parseInt(el.getAttribute("y2")))/2 + 10;
            d3.select("svg").append("text")
                .attr("x",x)
                .attr("y",y)
                .attr("class","link-label")
                .text(historicalMarking)
        });
    });
});