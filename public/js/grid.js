var pixels = [[]];
var colours = {'0': 'gray', '3': 'red', '2': 'green'};

function drawMarioGrid() {
	pixels = [[]];
	var chart = d3.select("svg");
	
	for (var y = 0; y < 13; y++){
		pixels.push([]);
		for (var x = 0; x < 13; x++){
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
