var nodes = [];

function drawNetwork(species) { 

	var width = 750,
	    height = 750;

	var color = d3.scale.category20();

	var force = d3.layout.force()
	    .charge(-120)
	    .linkDistance(30)
	    .size([width, height]);

	var svg = d3.select("svg")

	//Create nodes
	var nodes = [];

	//Keep track of mappings
	var nodeMappings = {}

	//Add input nodes
	var mapIndex = 0;
	for(var y=0;y<13;y++){
		for(var x=0;x<13;x++){
			var newNode = {
				x: 11 + x*25,
				y: 11 + y*25,
				fixed: true,
				type: 1
			}
			nodes.push(newNode);
			nodeMappings[mapIndex+1] = mapIndex;
			mapIndex++;
		}
	}

	//Add output nodes
	//170
	nodes.push({
		x: 750,
		y: 100,
		fixed: true,
		type: 2
	});
	nodeMappings[170] = 169;

	//171
	nodes.push({
		x: 750,
		y: 150,
		fixed: true,
		type: 2
	});
	nodeMappings[171] = 170;

	//172
	nodes.push({
		x: 750,
		y: 200,
		fixed: true,
		type: 2
	});
	nodeMappings[172] = 171;

	//173
	nodes.push({
		x: 750,
		y: 250,
		fixed: true,
		type: 2
	});
	nodeMappings[173] = 172;

	//Figure out which other nodes exist and need to be pushed
	for(var i=0;i<species.synapses.length;i++){
		if(!nodeMappings[species.synapses[i].from]){
			//If there's no node associated with the from
			var newNode = {
				label: species.synapses[i].from,
				x: 400,
				y: 200,
				type: 3
			}
			nodes.push(newNode);
			nodeMappings[species.synapses[i].from] = nodes.length-1;
		}

		if(!nodeMappings[species.synapses[i].to]){
			//If there's no node associated with the to
			var newNode = {
				label: species.synapses[i].to,
				x: 400,
				y: 200,
				type: 3
			}
			nodes.push(newNode);
			nodeMappings[species.synapses[i].to] = nodes.length-1;
		}
	}

	var links = [];

	//Add synapses
	for(var i=0;i<species.synapses.length;i++){
		var newLink = {
			marking: species.synapses[i].historicalMarking,
			source: nodeMappings[species.synapses[i].from],
			target: nodeMappings[species.synapses[i].to],
			weight: species.synapses[i].weight
		}
		links.push(newLink);
	}

	var force = d3.layout.force()
		.size([width,height])
		.nodes(nodes)
		.links(links);

	force.linkDistance(width/2);

	var link = svg.selectAll('.link')
    .data(links)
    .enter().append('line')
    .attr('class', 'link')
    .attr("marking", function(d){
    	if(d.marking){
    		return d.marking
    	}
    });

	var node = svg.selectAll('.node')
    .data(nodes)
    .enter().append('circle')
    .attr('class', 'node')
    .attr('type', function(d){
    	return d.type
    })
    .attr('label', function(d){
    	if(d.label){
    		return d.label
    	} else {
    		return;
    	}
    })
    .style("fill", function(d){
    	if(d.type==1){
    		return "#ffffff"
    	} else if(d.type==2){
    		return "#000000"
    	} else if(d.type==3){
    		return "#00ff00"
    	}
    });

	/*node.append("title")
	.text(function(d) { return d.name; });*/

	force.on('end',function(){
		node.attr('r', 3)
        .attr('cx', function(d) { return d.x; })
        .attr('cy', function(d) { return d.y; });

        link.attr('x1', function(d) { return d.source.x; })
        .attr('y1', function(d) { return d.source.y; })
        .attr('x2', function(d) { return d.target.x; })
        .attr('y2', function(d) { return d.target.y; });

        //Also add text to nodes that aren't input or output
        $(".node").each(function(i, el){
        	var type = el.getAttribute("type");
        	if(type==3){
        		var x = el.getAttribute("cx");
        		var y = el.getAttribute("cy");
        		d3.select("svg").append("text")
        			.attr("x",x)
        			.attr("y",y)
        			.text(el.getAttribute("label"))
        	}
        });

        //Add text to lines to show historicalMarker
        $(".link").each(function(i,el){
        	var historicalMarking = el.getAttribute("marking");
        	var x = (parseInt(el.getAttribute("x1")) + parseInt(el.getAttribute("x2")))/2;
        	var y = (parseInt(el.getAttribute("y1")) + parseInt(el.getAttribute("y2")))/2;
    		d3.select("svg").append("text")
    			.attr("x",x)
    			.attr("y",y)
    			.text(historicalMarking)
        })
	});

	force.start();
}