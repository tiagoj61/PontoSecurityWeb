<%@taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://htmlcompressor.googlecode.com/taglib/compressor" prefix="compress" %>
<compress:html compressCss="true" enabled="false">
    <s:include value="../layout/fragment/header.jsp">
        <s:param name="styles">
            <style type="text/css">
                .retorno {
                    overflow: auto;
                    width: calc(100% - 20px);
                    height: 350px;
                    margin-top: 20px;
                    border: 1px solid #ccc;
                    padding: 10px;
                    background-color: white;
                    margin: 10px;
                    white-space: pre;
                }

                h2 {
                    margin: 15px;
                }

                .alert-success, .alert-danger, .alert-info, .alert-warning {
                    margin: 14px;
                }
            </style>
        </s:param> 
    </s:include>

    <section class="card">
        <header class="card-header">
            Retorno do servidor
        </header>

        <div class="card-body">


            <s:actionerror theme="bootstrap" escape="false" />
            <s:actionmessage theme="bootstrap" escape="false" />
            <s:fielderror theme="bootstrap" escape="false" />


            <s:if test="#session.logged != null">
                <s:if test='redirectURL != null && redirectURL != ""'>
                    <a class="btn btn-success" style="float: right; margin: 0px 14px;" href="<s:property value="redirectURL"/>">Voltar</a>
                </s:if>
                <s:else>
                    <a class="btn btn-success" style="float: right; margin: 0px 14px;" href="javascript:history.back();">Voltar</a>
                </s:else>
            </s:if>
            <s:else>
                <a class="btn btn-danger" style="float: right; margin: 0px 14px;" href="../home/login.jsp">Fazer Login</a>
            </s:else>

            <s:if test="logger.length() > 0">
                <h2>Log do processo</h2>
                <div class="retorno"><s:property value="logger" escapeHtml="false" /></div>        
            </s:if>
        </div>
    </section>

    <s:include value="../layout/fragment/footer.jsp">
        <s:param name="scripts">
        </s:param> 
    </s:include>
</compress:html>