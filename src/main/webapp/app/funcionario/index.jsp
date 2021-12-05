<%@taglib prefix="s" uri="/struts-tags"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib uri="http://htmlcompressor.googlecode.com/taglib/compressor" prefix="compress" %>
<compress:html compressCss="true">

    <s:include value="../layout/fragment/header.jsp">
        <s:param name="styles"></s:param> 
    </s:include>

    <section class="card">
        <header class="card-header">Registros</header>

        <div class="card-body text-right">
            <button type="button" class="btn btn-primary" onclick="window.location.href = 'prepareFuncionario';">
                <i class="fas fa-plus"></i>
                Adicionar Novo
            </button>
        </div>

        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-striped table-advance table-hover">
                    <thead>
                        <tr>	
                            <th>Nome</th>
                            <th>Email</th>
                            <th class="text-center">Em conflito</th>
                            <th class="text-center">Na empresa</th>
                            <th class="text-right" style="width: 172px">A&ccedil;&otilde;es</th>
                        </tr>
                    </thead>
                    <tbody>
                        <s:iterator value="funcionarios">
                            <tr>
                                <td>${nome}</td>
                                <td>${email}</td>
                                <td class="text-center">${ativo? "Sim" : "Não"}</td>
                                <td class="text-center">${logado? "Sim" : "Não"}</td>
                                <td class="text-right">
                                    <button type="button" class="btn btn-outline-primary btn-xs" onclick="window.location.href = 'prepareFuncionario?funcionario.id=${id}'">
                                        <i class="fas fa-edit"></i> editar
                                    </button>
                                    <button type="button" class="btn btn-outline-danger btn-xs" onclick="js_remove(${id}, '<s:property value="nome" escapeJavaScript="true"/>', 'deleteFuncionario?funcionario.id=');">
                                        <i class="fas fa-trash-alt"></i> excluir
                                    </button>
                                </td>
                            </tr>
                        </s:iterator>
                    </tbody>
                </table>
            </div>
        </div>
    </section>


    <s:include value="../layout/fragment/footer.jsp">
        <s:param name="scripts">
        	<script type>
        		window.location.href = 'prepareFuncionario';
        	</>
            <script type="text/javascript" src="../layout/js/pagination.js"></script>
        </s:param> 
    </s:include>
</compress:html>