package pontosecurity.bo.impl;

import java.util.Iterator;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import pontosecurity.bean.Device;
import pontosecurity.bean.Funcionario;
import pontosecurity.bo.IDeviceBo;
import pontosecurity.bo.IFuncionarioBo;
import pontosecurity.commons.AbstractService;
import pontosecurity.commons.IOperations;
import pontosecurity.dao.IFuncionarioDao;

@Service
public class FuncionarioBo extends AbstractService<Funcionario> implements IFuncionarioBo {

	@Autowired
	private IFuncionarioDao dao;
	@Autowired
	private IDeviceBo deviceBo;

	@Override
	protected IOperations<Funcionario> getDao() {
		return dao;
	}

	@Override
	public Funcionario loadByCodigo(String codigo) {
		return dao.loadByCodigo(codigo);
	}

	@Override
	public void storesDevicesByCode(List<String> enderecoMacDevices, Funcionario funcionario) {
		funcionario.setLogado(true);
		dao.persist(funcionario);
		enderecoMacDevices.forEach(device->{
			Device d = new Device();
			d.setEnderecoMac(device);
			d.setFuncionario(funcionario);
			deviceBo.persist(d);
		});
		//dao.storesDevicesByCode(enderecoMacDevices, funcionario);
	}

	@Override
	public void removeDevicesByCode(List<String> enderecoMacDevices, Funcionario funcionario) {
		dao.removeDevicesByCode(enderecoMacDevices, funcionario);
	}

	@Override
	public boolean checkDevices(List<String> enderecoMacDevices, Funcionario funcionario) {
		List<Device> devices = dao.devicesByFuncionario(funcionario.getId());
System.out.println(enderecoMacDevices.size());
		List<String> macs = devices.stream().map(Device::getEnderecoMac).collect(Collectors.toList());
		System.out.println(macs.size());
		enderecoMacDevices.forEach(a->{
			System.out.println(a);
		});
		macs.forEach(a->{
			System.out.println(a);
		});
		System.out.println(macs.stream().anyMatch(enderecoMacDevices::contains));
		return macs.stream().anyMatch(enderecoMacDevices::contains);
	}

}
