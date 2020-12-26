<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<h3>Ethnicity</h3>

<sql:query var="elements" dataSource="jdbc/N3CCohort">
select * from 
	(select to_char(substring(x__all from '[0-9]+')::int, '999,999,999') as hispanic from enclave_cohort.severity_table2_for_export where value='Hispanic or Latino') as hispanic
	left join
	(select to_char(substring(x__all from '[0-9]+')::int, '999,999,999') as non from enclave_cohort.severity_table2_for_export where value='Not Hispanic or Latino') as non
	on true
	left join
	(select to_char(substring(x__all from '[0-9]+')::int, '999,999,999') as unknown from enclave_cohort.severity_table2_for_export where value='Missing/Unknown' and variable='Ethnicity') as unknown
	on true
</sql:query>

<c:forEach items="${elements.rows}" var="row" varStatus="rowCounter">
	<div class="row">
		<div class="col-sm-6">
			<div class="panel panel-default">
				<div class="panel-heading">Hispanic or Latino</div>
				<div class="panel-body">
					<div id="severity_ethnicity_hispanic"></div>
					<p>Total: ${row.hispanic}</p>
				</div>
			</div>
		</div>
		<div class="col-sm-6">
			<div class="panel panel-default">
				<div class="panel-heading">Not Hispanic or Latino</div>
				<div class="panel-body">
					<div id="severity_ethnicity_not"></div>
					<p>Total: ${row.non}</p>
				</div>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-sm-6">
			<div class="panel panel-default">
				<div class="panel-heading">Missing/Unknown</div>
				<div class="panel-body">
					<div id="severity_ethnicity_missing"></div>
					<p>Total: ${row.unknown}</p>
				</div>
			</div>
		</div>
	</div>
</c:forEach>

<jsp:include page="../graph_support/verticalBarChart.jsp">
	<jsp:param name="data_page"	value="feeds/severity_detail.jsp?variable=Ethnicity&value=Hispanic or Latino" />
	<jsp:param name="dom_element" value="#severity_ethnicity_hispanic" />
</jsp:include>

<jsp:include page="../graph_support/verticalBarChart.jsp">
	<jsp:param name="data_page"	value="feeds/severity_detail.jsp?variable=Ethnicity&value=Not+Hispanic or Latino" />
	<jsp:param name="dom_element" value="#severity_ethnicity_not" />
</jsp:include>

<jsp:include page="../graph_support/verticalBarChart.jsp">
	<jsp:param name="data_page"	value="feeds/severity_detail.jsp?variable=Ethnicity&value=Missing/Unknown" />
	<jsp:param name="dom_element" value="#severity_ethnicity_missing" />
</jsp:include>

