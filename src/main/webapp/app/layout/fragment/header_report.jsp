<%

    HttpSession sessao = request.getSession();
    if (sessao.getAttribute("logged") == null && sessao.getAttribute("authorized") == null) {
        response.sendRedirect("../home/login.jsp");
    }

%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <meta name="author" content="Audax App" />
        <title>Torke</title>

        <link rel="icon" type="image/png" sizes="16x16" href="../layout/img/icon/favicon.svg">

        <link rel="stylesheet" type="text/css" href="../layout/css/bootstrap.min.css" />
        <link rel="stylesheet" type="text/css" href="../layout/css/bootstrap-reset.css" />
        <link rel="stylesheet" type="text/css" href="../layout/assets/font-awesome/css/all.min.css" />
        <link rel="stylesheet" type="text/css" href="../layout/css/slidebars.css" />
        <link rel="stylesheet" type="text/css" href="../layout/css/style.min.css" />
        <link rel="stylesheet" type="text/css" href="../layout/css/style-responsive.css"/>
        <link rel="stylesheet" type="text/css" href="../layout/assets/toastr-master/toastr.css" />
        <link rel="stylesheet" type="text/css" href="../layout/assets/gritter/css/jquery.gritter.css" />
        <link rel="stylesheet" type="text/css" href="../layout/assets/bootstrap-fileupload/bootstrap-fileupload.css" />
        <link rel="stylesheet" type="text/css" href="../layout/assets/fancybox/dist/jquery.fancybox.min.css" />
        <link href="https://cdn.jsdelivr.net/gh/gitbrent/bootstrap4-toggle@3.6.1/css/bootstrap4-toggle.min.css" rel="stylesheet" />
        <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
        <style type="text/css">
            body {
                background: transparent;
                color: black;
            }

            .site-footer {
                padding-left: 0px;
            }

            .site-footer{ 
                position: relative;
            }
            th {
                background-color: #F9F9F9;
                width: 200px;
            }

            div.row > div {
                margin-bottom: 20px;
            }

            label {
                font-weight: bold;
                margin-bottom: 0px;
            }

            div.data {

            }

            div.picture {
                border: solid 2px #ccc;
                text-align: center;
                font-weight: bolder;
            }

            hr {
                width: 70%;
                margin: auto;
                background: black;
                margin-top: 60px;
            }

            table.signature {
                margin-top: 20px;
                width: 100%;
            }

            table.signature > tbody > tr > td {
                border: none;
            }

            label {
                width: 100%;
                padding: 10px 0px;
                background-color: #f9f9f9;
            }

            @media print {
                .page-break {page-break-after: always;}
                footer { 
                    display: none
                }
                .btn-print {
                    display: none;
                }
            }
            .btn-print {
                position: fixed;
                right: 0;
                top: 0;
                border-radius: 0px;
            }
            .highcharts-container  {
                text-align: center;
                width: 100%;
            }
            .chart-container {
                width: 800px;
                margin: 20px auto;
            }
        </style>
        ${param.styles}
    </head>
    <body>

        <section class="container">
