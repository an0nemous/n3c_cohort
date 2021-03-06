<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<script>
//accessor functions
var barLabel = function(d) { return d.element; };
var barValue = function(d) { return parseFloat(d.count); };

d3.json("${param.data_page}", function(data) {
	var valueLabelWidth = 50; // space reserved for value labels (right)
	var barHeight = 20; // height of one bar
	var barLabelWidth = 10; // space reserved for bar labels
	var barLabelPadding = 5; // padding between bar and bar labels (left)
	var gridLabelHeight = 0; // space reserved for gridline labels
	var gridChartOffset = 3; // space between start of grid and first bar
	var maxBarWidth = 280; // width of the bar with the max value

	data.forEach(function(node) {
		barLabelWidth = Math.max(barLabelWidth,node.element.length * 8);
	    //console.log(node.element + "  " + node.element.length*7. );
	});
	
	var myObserver = new ResizeObserver(entries => {
		entries.forEach(entry => {
			var newWidth = Math.floor(entry.contentRect.width);
			if (newWidth > 0) {
				d3.select("${param.dom_element}").select("svg").remove();
				//console.log('${param.dom_element} width '+newWidth);
				maxBarWidth = newWidth - barLabelWidth - barLabelPadding - valueLabelWidth;
				draw();
			}
		});
	});
	myObserver.observe(d3.select("${param.dom_element}").node());

	draw();

	function draw() {
		var formatComma = d3.format(",");

		// scales
		var yScale = d3.scale.ordinal().domain(d3.range(0, data.length)).rangeBands([0, data.length * barHeight]);
		var y = function(d, i) { return yScale(i); };
		var yText = function(d, i) { return y(d, i) + yScale.rangeBand() / 2; };
		var x = d3.scale.linear().domain([0, d3.max(data, barValue)]).range([0, maxBarWidth]);

		// svg container element
		var chart = d3.select("${param.dom_element}").append("svg")
			.attr('width', maxBarWidth + barLabelWidth + barLabelPadding + valueLabelWidth)
			.attr('height', gridLabelHeight + gridChartOffset + data.length * barHeight);
		
		<c:choose>
			<c:when test="${param.html ==  'percentage'}">
				var tip = d3.tip()
				  .attr('class', 'd3-tip')
				  .offset([-10, 0])
				  .html(function(d) {
						var total = d3.sum(data.map(function(d) {
							return d.count;
						}));
						var percent = Math.round(1000 * d.count / total) / 10;
				    return "<strong>" + d.element + "</strong><br>" + formatComma(d.count) + " patients<br>" + percent + "% of  category";
				  })
		
				// activate the tip
				chart.call(tip);
			</c:when>
			</c:choose>
		
		// bar labels
		var labelsContainer = chart.append('g')
			.attr('transform', 'translate(' + (barLabelWidth - barLabelPadding) + ',' + (gridLabelHeight + gridChartOffset) + ')');
		labelsContainer.selectAll('text').data(data).enter().append('text')
			.attr('y', yText)
			.attr('stroke', 'none')
			.attr('fill', 'black')
			.attr("dy", ".35em") // vertical-align: middle
			.attr('text-anchor', 'end')
			.text(barLabel);
		// bars
		var barsContainer = chart.append('g')
			.attr('transform', 'translate(' + barLabelWidth + ',' + (gridLabelHeight + gridChartOffset) + ')');
		barsContainer.selectAll("rect").data(data).enter().append("rect")
			.attr('class', 'bar')
			.attr('y', y)
			.attr('height', yScale.rangeBand())
			.attr('width', function(d) { return x(barValue(d)); })
			.attr('stroke', 'white')
			.attr('fill', '#376076')
			<c:if test="${not empty param.html}">
		        .on('mouseover', tip.show)
		        .on('mouseout', tip.hide)
	        </c:if>
	        ;
		// bar value labels
		barsContainer.selectAll("text").data(data).enter().append("text")
			.attr("x", function(d) { return x(barValue(d)); })
			.attr("y", yText)
			.attr("dx", 3) // padding-left
			.attr("dy", ".35em") // vertical-align: middle
			.attr("text-anchor", "start") // text-align: right
			.attr("fill", "black")
			.attr("stroke", "none")
			.text(function(d) { return formatComma(d3.round(barValue(d), 2)); });
		// start line
		barsContainer.append("line")
			.attr("y1", -gridChartOffset)
			.attr("y2", yScale.rangeExtent()[1] + gridChartOffset)
			.style("stroke", "#000");
	}
});
</script>
