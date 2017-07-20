var pixels = [[]];
var colours = {'0': 'gray', '3': 'red', '2': 'green'};
var gridData = {}
function drawMarioGrid() {


	d3.select("#graph").attr("width", graphWidth + 40).attr("height", graphHeight + 40);

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

	if (data == gridData) {
		console.log("No change in grid");
		return;
	} else {
		gridData = data;
		console.log("Updating grid");
		console.log(data);
	}
	for (var y = 0; y < 12; y++) {
		indexY = y - 6;
		var rowData = gridData['tiles'][indexY];
		for (var x = 0; x < 12; x++) {
			var rect = pixels[y][x];
			rect.attr('fill', colours[String(rowData[x])])
		}
	}
}
