
<%
HttpSession sessao = request.getSession();
%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta name="author" content="Audax App" />
<title>Ponto security</title>

<link rel="icon" type="image/png" sizes="16x16"
	href="../layout/img/icon/favicon.svg">

<link rel="stylesheet" type="text/css"
	href="../layout/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css"
	href="../layout/css/bootstrap-reset.css" />
<link rel="stylesheet" type="text/css"
	href="../layout/assets/font-awesome/css/all.min.css" />
<link rel="stylesheet" type="text/css"
	href="../layout/css/slidebars.css" />
<link rel="stylesheet" type="text/css"
	href="../layout/css/style.min.css" />
<link rel="stylesheet" type="text/css"
	href="../layout/css/style-responsive.css" />
<link rel="stylesheet" type="text/css"
	href="../layout/assets/toastr-master/toastr.css" />
<link rel="stylesheet" type="text/css"
	href="../layout/assets/gritter/css/jquery.gritter.css" />
<link rel="stylesheet" type="text/css"
	href="../layout/assets/bootstrap-fileupload/bootstrap-fileupload.css" />
<link rel="stylesheet" type="text/css"
	href="../layout/assets/fancybox/dist/jquery.fancybox.min.css" />
<link
	href="https://cdn.jsdelivr.net/gh/gitbrent/bootstrap4-toggle@3.6.1/css/bootstrap4-toggle.min.css"
	rel="stylesheet" />
<link
	href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css"
	rel="stylesheet" />

${param.styles}
<style type="text/css">
#sidebar {
	z-index: 1;
}
</style>
</head>
<body>

	<section id="container">
<!-- 		<header class="header white-bg"> -->
<!-- 			<div class="sidebar-toggle-box"> -->
<!-- 				<i class="fas fa-bars"></i> -->
<!-- 			</div> -->
<!-- 			<a class="logo" href="dashboard"> <img -->
<!-- 				src="../layout/img/icon/logo.svg" style="height: 26px" /> -->
<!-- 			</a> -->
<!-- 			<div class="top-nav"> -->
<!-- 			</div> -->
<!-- 		</header> -->
		<aside>
			<div id="sidebar" class="nav-collapse ">
				<a class="logo" style="margin-left:1rem" href="dashboard"> <img
					src="../layout/img/icon/logo.svg" style="height: 20%;">
				</a>
				<s:include value="menu.jsp" />
			</div>
		</aside>
		<section id="main-content">
			<section class="wrapper site-min-height">