<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script>
$.getJSON("feeds/preprints.jsp", function(data){
		
	var json = $.parseJSON(JSON.stringify(data));

	var col = [];

	for (i in json['headers']){
		col.push(json['headers'][i]['label']);
	}


	var table = document.createElement("table");
	table.className = 'table table-hover';
	table.style.width = '100%';
	table.style.textAlign = "left";
	table.id="xrviv_publications";

	var header= table.createTHead();
	var header_row = header.insertRow(0); 

	for (i in col) {
		var th = document.createElement("th");
		th.innerHTML = '<span style="color:#333; font-weight:600; font-size:16px;">' + col[i].toString() + '</span>';
		header_row.appendChild(th);
	}

	var divContainer = document.getElementById("preprints-div");
	divContainer.innerHTML = "";
	divContainer.appendChild(table);

	var data = json['rows'];

	$('#xrviv_publications').DataTable( {
    	data: data,
       	paging: true,
    	pageLength: 10,
    	lengthMenu: [ 5, 10, 25, 50, 75, 100 ],
    	order: [[3, 'desc']],
     	columns: [
	       	{ data: 'doi', visible: true, orderable: true,
        		render: function ( data, type, row ) {
        			return '<a href="https://doi.org/'+ row.doi + '"><span style="color:#376076";>' + row.doi + '<\/span></a>';
             		}
        		},
        	{ data: 'title', orderable: true },
        	{ data: 'site', orderable: true },
        	{ data: 'pub_date', orderable: true }
    	]
	} );

	
});
</script>
