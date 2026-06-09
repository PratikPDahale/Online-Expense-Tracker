<%@page import="com.entity.Expense"%>
<%@page import="java.util.List"%>
<%@page import="com.entity.User"%>
<%@page import="com.db.HibernateUtil"%>
<%@page import="com.dao.ExpenseDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>All Expenses</title>
<%@include file="../component/all_css.jsp"%>
<style>

/* Custom Card Styles */
.expense-card {
	border: 1px solid #ddd;
	border-radius: 8px;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	padding: 20px;
	margin-bottom: 20px;
	background-color: #fff;
	display: flex;
	flex-direction: column; /* Ensure content is arranged vertically */
	height: 100%; /* Make sure card height expands to fill space */
	transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.expense-card:hover {
	transform: translateY(-10px);
	box-shadow: 0 8px 12px rgba(0, 0, 0, 0.1);
}

/* Styling for the title of the card */
.expense-card .card-title {
	font-size: 1.5rem;
	font-weight: bold;
	color: #007bff;
}

/* Styling for the description of the card */
.expense-card .card-description {
	color: #6c757d;
	flex-grow: 1; /* Allow this section to grow and fill available space */
}

/* Styling for the footer section to stay fixed at the bottom */
.expense-card .card-footer {
	margin-top: 20px;
	display: flex;
	justify-content: space-between;
	align-items: center;
	background: white;
	margin-top: auto; /* Push the footer to the bottom */
}

.expense-card .card-footer .btn {
	margin-left: 10px;
}

/* Grid layout for displaying multiple cards */
.expense-container {
	display: grid;
	grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
	gap: 20px;
}
</style>
</head>
<body>
	<c:if test="${empty loginUser}">
		<c:redirect url="../login.jsp"></c:redirect>
	</c:if>
	<%@include file="../component/navbar.jsp"%>
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<div class="card mt-3">
					<div class="card-header text-center">
						<p class="fs-3">All Expenses</p>

						<c:if test="${not empty msg}">
							<p class="text-center text-success fs-4">${msg }</p>
							<c:remove var="msg" />
						</c:if>
					</div>
					<div class="card-body">
						<div class="expense-container">
							<% 
                                User user = (User) session.getAttribute("loginUser");
                                ExpenseDao dao = new ExpenseDao(HibernateUtil.getSessionFactory());
                                List<Expense> list = dao.getAllExpenseByUser(user);
                                for (Expense ex : list) {
                            %>
							<div class="expense-card">
								<div class="card-title"><%= ex.getTitle() %></div>
								<div class="card-description">
									<p>
										<strong>Description:</strong>
										<%= ex.getDescription() %></p>
									<p>
										<strong>Date:</strong>
										<%= ex.getDate() %></p>
									<p>
										<strong>Time:</strong>
										<%= ex.getTime() %></p>
									<p>
										<strong>Price:</strong>
										<%= ex.getPrice() %></p>
								</div>
								<div class="card-footer">
									<a href="edit_expense.jsp?id=<%= ex.getId() %>"
										class="btn btn-sm btn-primary">Edit</a> <a
										href="../deleteExpense?id=<%= ex.getId() %>"
										class="btn btn-sm btn-danger">Delete</a>
								</div>
							</div>
							<% } %>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>


<%-- <%@page import="com.entity.Expense"%>
<%@page import="java.util.List"%>
<%@page import="com.entity.User"%>
<%@page import="com.db.HibernateUtil"%>
<%@page import="com.dao.ExpenseDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@include file="../component/all_css.jsp"%>
</head>
<body>
	<c:if test="${empty loginUser}">
		<c:redirect url="../login.jsp"></c:redirect>
	</c:if>
	<%@include file="../component/navbar.jsp"%>
	<div class="container">
		<div class="row">
			<div class="col-md-8 offset-md-2">
				<div class="card mt-3">
					<div class="card-header text-center">
						<p class="fs-3">All Expenses</p>
						
						<c:if test="${not empty msg}">
							<p class="text-center text-success fs-4">${msg }</p>
							<c:remove var="msg" />
						</c:if>
					</div>
					<div class="card-body">
						<table class="table">
							<thead>
								<tr>
									<th scope="col">Title</th>
									<th scope="col">Description</th>
									<th scope="col">Date</th>
									<th scope="col">Time</th>
									<th scope="col">Price</th>
									<th scope="col">Action</th>
								</tr>
							</thead>
							<tbody>
								<%
									
									User user = (User)session.getAttribute("loginUser");
									
									ExpenseDao dao= new ExpenseDao(HibernateUtil.getSessionFactory());
									List<Expense> list = dao.getAllExpenseByUser(user);
									for(Expense ex:list){
										%>
								<tr>
									<th scope="row"><%=ex.getTitle() %></th>
									<td><%= ex.getDescription()%></td>
									<td><%= ex.getDate()%></td>
									<td><%= ex.getTime()%></td>
									<td><%= ex.getPrice()%></td>
									<td><a href="edit_expense.jsp?id=<%=ex.getId() %>" class="btn btn-sm btn-primary me-1">Edit</a>
										<a href="../deleteExpense?id=<%=ex.getId() %>" class="btn btn-sm btn-danger me-1">Delete</a></td>
								</tr>
								<%
									}
								%>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html> --%>