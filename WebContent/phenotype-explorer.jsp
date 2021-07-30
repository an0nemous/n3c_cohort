<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<!DOCTYPE html>
<html>
<jsp:include page="head.jsp" flush="true" />

<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

<!-- jQuery library -->
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<script src="resources/MT.BootstrapLazyloader.js"></script>
	<link href="https://cdn.datatables.net/1.10.23/css/jquery.dataTables.min.css" rel="stylesheet">
	<script src="https://cdn.datatables.net/1.10.23/js/jquery.dataTables.min.js"></script>

<script src="resources/d3.v4.min.js"></script>
<script src="resources/d3-tip.js"></script>

<style type="text/css" media="all">
@import "resources/n3c_login_style.css";
@import "resources/main_style.css";
</style>

<style type="text/css">
table.dataTable thead .sorting_asc {
	background-image: none !important;
}
</style>

<body>

	<jsp:include page="navbar.jsp" flush="true" />

	<div class="container-fluid">
		<h2 class="header-text">
			<img src="images/n3c_logo.png" class="n3c_logo_header" alt="N3C Logo">N3C Cohort Exploration
		</h2>
		<div class = "row" style="margin:auto; padding-left:10%; padding-right:10%; font-size:16px;">
			<p><span style="font-size:20px; font-weight:500;">Ready to dive into the data?</span>&emsp;View and analyze data in our secure N3C Data Enclave.
			The data include harmonized de-identified information from electronic health records.
			The Data Enclave is open to academic researchers, clinicians, and citizen scientists. <a href="https://covid.cd2h.org/enclave" style="font-weight:600;">Register for an account now!</a></p>
		
			<p>You are encouraged to submit suggestions for
				enhancements/additions to <a href="https://n3c-help.atlassian.net/jira/software/c/projects/N3CINTA/issues/N3CINTA-4">this
				tracking issue.</a></p>
		</div>
		<p>&nbsp;</p>
		<ul class="nav nav-tabs" id="maintabs" style="font-size: 16px;">
			<li><a class="nav-link" href="cohort.jsp">The Cohort</a></li>
			<li><a class="nav-link" href="collaborative.jsp">The Collaborative</a></li>
			<li><a class="nav-link" href="clinical-details.jsp">Clinical Details</a></li>
			<li><a class="nav-link" href="machine-learning.jsp">Machine Learning Details</a></li>
			<li><a href="publications.jsp" class="nav-link">Publications</a></li>
            <li class="active"><a class="nav-link">Phenotype Explorer</a></li>
		</ul>

		<div class="tab-content" id="maintabscontent">
            <div class="tab-pane fade in active" id="pe">
				<jsp:include page="graphs/pe.jsp" flush="true" />
			</div>
		</div>
		<jsp:include page="footer.jsp" flush="true" />
	</div>
</body>



</html>


