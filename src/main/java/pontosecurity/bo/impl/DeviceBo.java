package pontosecurity.bo.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import pontosecurity.bean.Device;
import pontosecurity.bo.IDeviceBo;
import pontosecurity.commons.AbstractService;
import pontosecurity.commons.IOperations;
import pontosecurity.dao.IDeviceDao;

@Service
public class DeviceBo extends AbstractService<Device> implements IDeviceBo {

	@Autowired
	private IDeviceDao dao;

	@Override
	protected IOperations<Device> getDao() {
		return dao;
	}

}
