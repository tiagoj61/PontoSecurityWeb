<%@taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://htmlcompressor.googlecode.com/taglib/compressor" prefix="compress" %>
<compress:html compressCss="true">
    <s:include value="../layout/fragment/header.jsp">
        <s:param name="styles">
        </s:param> 
    </s:include>

    <section class="card">
        <header class="card-header">
            Salvar Usu&aacute;rio
        </header>

        <div class="card-body">

            <s:form acceptcharset="UTF-8" theme="bootstrap" cssClass="form-vertical" method="post" action="persistFuncionario">
                <s:hidden name="funcionario.id" />
                <s:hidden name="funcionario.ultimoAcesso" />
                <s:hidden name="funcionario.hash" />

                <s:textfield label="Nome" name="funcionario.nome" required="true" maxlength="100" />
                <div class="row">
                    <div class="col-lg-6">
                        <s:textfield label="Email" name="funcionario.email" required="true" type="email" maxlength="100" />
                    </div>
                    <div class="col-lg-6">
                        <s:password label="Senha" name="funcionario.senha" />
                    </div>
                </div>

                <div class="row">
                    <div class="col-lg-4">
                        <s:select label="Tipo de acesso" list="tipoFuncionarioEnum" listValue="name" name="funcionario.tipoFuncionario" />
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-4">
                        <s:select label="Cadastro ativo?" list="booleanConditionEnum" listKey="key" listValue="value" name="funcionario.ativo" />
                    </div>
                </div>


                <div class="card-body text-right">
                    <button type="button" class="btn btn-outline-danger btn-lg" onclick="js_cancel('listFuncionario')">
                        <i class="fas fa-times"></i>
                        Cancelar
                    </button>
                    <button type="submit" class="btn btn-outline-primary btn-lg">
                        <i class="fas fa-save"></i>
                        Salvar
                    </button>
                </div>

            </s:form>

        </div>
    </section>


    <s:include value="../layout/fragment/footer.jsp">
        <s:param name="scripts">
            <script type="text/javascript" src="../funcionario/js/script.min.js"></script>
        </s:param> 
    </s:include>
</compress:html>