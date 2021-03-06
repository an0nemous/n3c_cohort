<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
.node {
	stroke: #fff;
	stroke-width: 1.5px;
}

text {
	stroke: #000;
	stroke-width: 0.0px;
	font: 15px sans-serif;
	pointer-events: none;
}

.link {
	stroke: #999;
	stroke-opacity: .6;
}

#states path {
  fill: #bce4d8;
  stroke: #fff;
}

</style>

<script type="text/javascript" src="http://mbostock.github.io/d3/talk/20111116/d3/d3.geo.js"></script> 
<script src="//d3js.org/topojson.v1.min.js"></script>


<script>

var width = 921,
    height = 461,
    radius = 4, 
    map_scale = 900;

if ("${param.map_type}" == 'world'){
	map_scale = 120;	
	
	d3.json("<util:applicationRoot/>/graphs/countries.geojson", function(error, collection) {
		if (error) {
			throw error;
		}
		console.log(error);
	 	states.selectAll("path")
	   		.data(collection.features)
			.enter().append("svg:path")
	   		.attr("d", path)
	   		.attr("class", "countries");
	 });
}
else {	
		
	d3.json("<util:applicationRoot/>/graph_support/us-states.json", function(error, collection) {
		if (error) {
			throw error;
		}
		map_scale = 900;
		console.log(error);
	 	states.selectAll("path")
	   		.data(collection.features)
			.enter().append("svg:path")
	   		.attr("d", path)
	   		.attr("class", "state");
	});
}


var projection = d3.geo.azimuthal()
.mode("equidistant")
.origin([-98, 38])
.scale(map_scale)
.translate([340, 290]);

 var path = d3.geo.path()
 .projection(projection);

 var svg = d3.select("${param.dom_element}").insert("svg:svg", "h2")
 .attr("width", width)
 .attr("height", height);

 var states = svg.append("svg:g")
 .attr("id", "states");

 var countries = svg.append("svg:g")
 .attr("id", "countries");
 
  var links = svg.append("svg:g")
 .attr("id", "links");

 var circles = svg.append("svg:g")
 .attr("id", "circles");

 var cells = svg.append("svg:g")
 .attr("id", "cells");

 var color = d3.scaleOrdinal(d3.schemeCategory10).domain(d3.range(0,10));
 var edgeColor = d3.scaleOrdinal()
 				.domain(d3.range(0,16))
 				.range(["#fff","#eee","#ddd","#ccc","#bbb","#aaa","#999","#888","#777","#666","#555","#444","#333","#222","#111","#000"]);

 var svg = d3.select("${param.dom_element}").append("svg")
 	 .attr("xmlns","http://www.w3.org/2000/svg")
     .attr("width", width)
     .attr("height", height);
   
 var linksByOrigin = {},
 countByAirport = {},
 locationBySite = [],
 positions = [];

d3.select(window).on('resize', function() { alert(d3.select("${param.dom_element}").node().width); });
	
d3.json("${param.data_page}", function(graph) {
     var sites = graph.sites.filter(function(site) {
           var location = [site.longitude, site.latitude];
           locationBySite[site.id] = projection(location);
           positions.push(projection(location));
           return true;
     });

     var coauthors = graph.coauthors;
    
     var linearScale = d3.scaleLinear()
 						.domain([0,10000])
 						.range(["#fff","#000"])
 						.clamp(true);

     var logScale = d3.scaleLog()
 						.domain([0,10000])
 						.range(["#fff","#000"])
 						.clamp(true);
     
     var eScale = d3.scaleLinear()
				 	.domain([0, 1])
				 	.range([1, 2]) 
     				.clamp(true);
     
     circles.selectAll("circle")
 		.data(sites) 
     	.enter().append("svg:circle")
 		.style("stroke", "#fff")
 		.style("fill", function(d) { return color(d.id % 10); })
 		.on("click", function(d) { window.open(d.url,"_self");})
        .attr("cx", function(d, i) { return positions[i][0]; })
        .attr("cy", function(d, i) { return positions[i][1]; })
        .attr("r", function(d, i) { return 5; })
     	.on("mouseover", function(n) {
	         })
         .on("mouseout", function() {
	         })
 		.append("svg:title")
 			.text(function(d) {return d.description.replace('&amp;', '&');  });
     
;    
});
  
</script>