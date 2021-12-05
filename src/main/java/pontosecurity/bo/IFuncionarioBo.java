package pontosecurity.bo;

import java.util.List;

import pontosecurity.bean.Funcionario;
import pontosecurity.commons.IOperations;
import pontosecurity.restful.dto.FuncionarioDto;

public interface IFuncionarioBo extends IOperations<Funcionario> {

	Funcionario loadByCodigo(String string);

	void storesDevicesByCode(List<String> enderecoMacDevices, Funcionario funcionario);

	void removeDevicesByCode(List<String> enderecoMacDevices, Funcionario funcionario);

	boolean checkDevices(List<String> enderecoMacDevices, Funcionario funcionario);

}
