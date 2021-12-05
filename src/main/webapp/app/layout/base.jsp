<%@taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://htmlcompressor.googlecode.com/taglib/compressor" prefix="compress" %>
<compress:html compressCss="true">
    <s:include value="../layout/fragment/header.jsp">
        <s:param name="styles">
            <!-- <link rel="stylesheet" type="text/css" href="../layout/css/mycustom.css" /> -->
        </s:param> 
    </s:include>

    <section class="card">
        <header class="card-header">
            Título da página
        </header>

        <div class="card-body">

            <p>put your code here</p>

        </div>
    </section>




    <s:include value="../layout/fragment/footer.jsp">
        <s:param name="scripts">
            <!-- <script type="text/javascript" src="../layout/js/mycustom.js" /> -->
        </s:param> 
    </s:include>
</compress:html>