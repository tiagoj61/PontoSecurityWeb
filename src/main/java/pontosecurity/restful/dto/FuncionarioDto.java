package pontosecurity.restful.dto;

import java.util.List;

public class FuncionarioDto {
	private String codigo;
	private List<String> enderecoMacDevices;
	public String getCodigo() {
		return codigo;
	}
	public void setCodigo(String codigo) {
		this.codigo = codigo;
	}
	public List<String> getEnderecoMacDevices() {
		return enderecoMacDevices;
	}
	public void setEnderecoMacDevices(List<String> enderecoMacDevices) {
		this.enderecoMacDevices = enderecoMacDevices;
	}
	
}
