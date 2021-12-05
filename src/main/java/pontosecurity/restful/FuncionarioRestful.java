package pontosecurity.restful;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import pontosecurity.bean.Funcionario;
import pontosecurity.bo.IFuncionarioBo;
import pontosecurity.restful.dto.FuncionarioDto;

@Component
@Path("/funcionario")
public class FuncionarioRestful {

	@Autowired
	private IFuncionarioBo funcionarioBo;

	@Path("login")
	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	public Response login(FuncionarioDto funcionarioDto) {
		try {
			Funcionario funcionario = funcionarioBo.loadByCodigo(funcionarioDto.getCodigo());
			if (funcionario == null)
				return Response.status(Response.Status.FORBIDDEN).entity("CodeErro").build();
			if (funcionario.isLogado()) {
				if (!funcionarioBo.checkDevices(funcionarioDto.getEnderecoMacDevices(), funcionario)) {
					if(funcionario.isAtivo()) {
						funcionario.setAtivo(false);
						funcionario.setLogado(false);
						funcionarioBo.persist(funcionario);
						funcionarioBo.removeDevicesByCode(funcionarioDto.getEnderecoMacDevices(), funcionario);
						return Response.status(Response.Status.ACCEPTED).build();
					}
					funcionario.setAtivo(true);
					funcionarioBo.persist(funcionario);
					return Response.status(Response.Status.CONFLICT).build();
				}
				funcionario.setAtivo(false);
				funcionario.setLogado(false);
				funcionarioBo.persist(funcionario);
				funcionarioBo.removeDevicesByCode(funcionarioDto.getEnderecoMacDevices(), funcionario);
			} else {
				funcionario.setAtivo(false);
				funcionarioBo.persist(funcionario);
				funcionarioBo.storesDevicesByCode(funcionarioDto.getEnderecoMacDevices(), funcionario);
			}

			return Response.status(Response.Status.OK).build();
		} catch (Exception e) {
			e.printStackTrace();
			return Response.serverError().build();
		}
	}

	@Path("logout")
	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	public Response logout(FuncionarioDto funcionarioDto) {
		try {
			Funcionario funcionario = funcionarioBo.loadByCodigo(funcionarioDto.getCodigo());
			if (funcionario == null)
				return Response.status(Response.Status.FORBIDDEN).entity("CodeErro").build();

			return Response.status(Response.Status.OK).build();
		} catch (Exception e) {
			e.printStackTrace();
			return Response.serverError().build();
		}
	}
}
