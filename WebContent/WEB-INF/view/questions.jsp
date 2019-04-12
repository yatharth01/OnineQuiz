<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.morphosis.quiz.DatabaseConnection" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Questions</title>
</head>
<body>
<%


response.setContentType("text/html");


String ques="loading...";
int count=0;
String option_A = "loading..";
String option_B = "loading..";
String option_C = "loading..";
String option_D = "loading..";

try {
	Statement s=DatabaseConnection.getConnection();
	Statement s2=DatabaseConnection.getConnection();
	Statement s3=DatabaseConnection.getConnection();
	Statement s4=DatabaseConnection.getConnection();
	
	ResultSet rs2= s2.executeQuery("select Count from counter");
	if(rs2.next())
	count=rs2.getInt(1);
	
	count++;
	int rows= s3.executeUpdate("UPDATE counter SET Count=" + count);
	System.out.println("connection established\n");
	System.out.println(count);
	ResultSet rs= s.executeQuery("select ques from options where flag="+count);
	ResultSet rs3= s4.executeQuery("select A,B,C,D from options where flag="+count);
	
	if(rs3.next()) {
		option_A=rs3.getString("A");
		option_B=rs3.getString("B");
		option_C=rs3.getString("C");
		option_D=rs3.getString("D");

	}
	
	if(rs.next())
	{
	ques=rs.getString(1);
	 response.setIntHeader("Refresh", 10);
	}
	else ques="Quiz has ended. Wait for the results...";
	//System.out.println(ques);
	
	
	
	DatabaseConnection.getCloseConnection();
} catch (Exception e) {
	// TODO Auto-generated catch block
	e.printStackTrace();
}

%>

<p><%=ques%></p>
<br></br>
<p><%=option_A %></p>
<p><%=option_B %></p>
<p><%=option_C %></p>
<p><%=option_D %></p>
</body>
</html>