var pixels = [[]];
var colours = {'0': 'gray', '-1': 'red', '2': 'green'};

function drawGrid() {

	var chart = d3.select("body")
				.append("svg")
				.attr("width", 750)
				.attr("height", 750);


	
	for (var y = 0; y < 12; y++){
		pixels.push([]);
		for (var x = 0; x < 12; x++){
			var rect = chart.append("rect")
					.attr('x', x * 25)
					.attr('y', y * 25)
					.attr('width', 20)
					.attr('height', 20)
					.attr('fill', 'gray');
			pixels[y].push(rect);
		}
	}
}

function updateGrid(data){

	for (var y = 0; y < 12; y++) {
		indexY = y - 6;
		var rowData = data['tiles'][indexY];
		for (var x = 0; x < 12; x++) {
			var rect = pixels[y][x];
			rect.attr('fill', colours[String(rowData[x])])
		}
	}
}
