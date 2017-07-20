var nodes = []
var nodeMappings = {};
var links = [];
var linkMappings = {};
function drawNetwork(synapses,callback) {
    nodes = [];
    nodeMappings = {};
    links = [];
    var width = graphWidth,
        height = graphHeight;

    var color = d3.scale.category20();

    var force = d3.layout.force()
        .charge(-60)
        .linkDistance(30)
        .size([width, height]);

    var svg = d3.select("svg")

    //Add input nodes
    var mapIndex = 0;
    for(var y=0;y<13;y++){
        for(var x=0;x<13;x++){
            var newNode = {
                x: 11 + x*25,
                y: 11 + y*25,
                fixed: true,
                type: 1,
                label: mapIndex+1
            }
            nodes.push(newNode);
            nodeMappings[mapIndex+1] = mapIndex;
            mapIndex++;
        }
    }

    //Add output nodes
    //170
    nodes.push({
        x: graphWidth - 30,
        y: leftYPos,
        fixed: true,
        type: 2
    });
    nodeMappings[170] = 169;

    //171
    nodes.push({
        x: graphWidth - 30,
        y: rightYPos,
        fixed: true,
        type: 2
    });
    nodeMappings[171] = 170;

    //172
    nodes.push({
        x: graphWidth - 30,
        y: aYPos,
        fixed: true,
        type: 2
    });
    nodeMappings[174] = 171;

    //173
    nodes.push({
        x: graphWidth - 30,
        y: bYPos,
        fixed: true,
        type: 2
    });
    nodeMappings[175] = 172;

    //Find the other neurons by traversing through synapses
    for(var i=0;i<synapses.length;i++){
        if(!nodeMappings[synapses[i].from]){
            //If there's no node associated with the from
            var newNode = {
                label: synapses[i].from,
                x: 400,
                y: 200,
                type: 3
            }
            nodes.push(newNode);
            nodeMappings[synapses[i].from] = nodes.length-1;
        }

        if(!nodeMappings[synapses[i].to]){
            //If there's no node associated with the to
            var newNode = {
                label: synapses[i].to,
                x: 400,
                y: 200,
                type: 3
            }
            nodes.push(newNode);
            nodeMappings[synapses[i].to] = nodes.length-1;
        }
    }

    //Add synapses
    for(var i=0;i<synapses.length;i++){
        var newLink = {
            marking: synapses[i].historicalMarking,
            source: nodeMappings[synapses[i].from],
            target: nodeMappings[synapses[i].to],
            weight: synapses[i].weight,
            type: synapses[i].type
        }
        linkMappings[newLink.marking] = i;
        links.push(newLink);
    }

    var force = d3.layout.force()
        .size([width,height])
        .nodes(nodes)
        .links(links);

    force.linkDistance(width/4);

    var link = svg.selectAll('.link')
        .data(links)
        .enter().append('line')
        .attr('class', function(d){
            var baseClass = "link"
            switch(d.type){
                case 1:
                    baseClass += " type-goomba"
                    break;
                case 2:
                    baseClass += " type-tile"
                    break;
            }
            return baseClass
        })
        .attr("marking", function(d){
            if(d.marking){
                return d.marking
            }
        });

    var node = svg.selectAll('.node')
    .data(nodes)
    .enter().append('circle')
    .attr('class', function(d){
        var baseClass = "node"
        switch(d.type){
            case 1:
                baseClass += " input-node"
                break;
            case 2:
                baseClass += " output-node"
                break;
            case 3:
                baseClass += " hidden-node"
                break;
        }

        return baseClass
    })
    .attr('type', function(d){
        return d.type
    })
    .attr('label', function(d){
        if(d.label){
            return d.label
        } else {
            return;
        }
    });

    /*node.append("title")
    .text(function(d) { return d.name; });*/

    force.on('end',function(){
        node.attr('r', 3)
        .attr('cx', function(d) { return d.x; })
        .attr('cy', function(d) { return d.y > 0 ? d.y : 10; });

        link.attr('x1', function(d) { return d.source.x; })
        .attr('y1', function(d) { return d.source.y; })
        .attr('x2', function(d) { return d.target.x; })
        .attr('y2', function(d) { return d.target.y; });

        callback();

    });

    force.start();
}

function updateNetworkStates(synapses){
    var synapseMap = {}
    // var neuronMap = {}

    for(var i=0;i<synapses.length;i++){
        synapseMap[synapses[i].historicalMarking] = synapses[i].lit;
        // if(synapses[i].lit){
        //     neuronMap[links[linkMappings[synapses[i].historicalMarking]].source.label] = true;
        //     neuronMap[links[linkMappings[synapses[i].historicalMarking]].target.label] = true;
        // }
    }
    console.log("Updating network states");
    $(".link").each(function(){
        var marking = this.getAttribute("marking");
        if(synapseMap[marking]){
            var oldClasses = $(this).attr("class");
            if (oldClasses.indexOf(" active-link") == -1) {
                oldClasses = oldClasses.replace(" inactive-link", "");
                $(this).attr("class",oldClasses + " active-link");
            }
        } else {
            var oldClasses = $(this).attr("class");
            if (oldClasses.indexOf(" inactive-link") == -1) {
                oldClasses = oldClasses.replace(" active-link", "");
                $(this).attr("class", oldClasses + " inactive-link");
            }
        }
    })

    // $(".node").each(function(index,el){
    //     var label = el.getAttribute("label");
    //     if(neuronMap[label]){
    //         var oldClasses = $(el).attr("class");
    //         $(el).attr("class",oldClasses + " active-node");
    //     } else {
    //         var oldClasses = $(el).attr("class");
    //         oldClasses.replace(" active-node","");
    //         $(el).attr("class",oldClasses);
    //     }
    // })
}