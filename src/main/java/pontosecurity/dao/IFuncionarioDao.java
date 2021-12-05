package pontosecurity.dao;

import java.util.List;

import pontosecurity.bean.Device;
import pontosecurity.bean.Funcionario;
import pontosecurity.commons.IOperations;
import pontosecurity.restful.dto.FuncionarioDto;

public interface IFuncionarioDao extends IOperations<Funcionario> {

	Funcionario loadByCodigo(String codigo);

	void storesDevicesByCode(List<String> enderecoMacDevices, Funcionario funcionario);

	void removeDevicesByCode(List<String> enderecoMacDevices, Funcionario funcionario);

	List<Device> devicesByFuncionario(Long id);

}
