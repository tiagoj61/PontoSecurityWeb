package pontosecurity.dao.impl;

import org.springframework.stereotype.Repository;

import pontosecurity.bean.Device;
import pontosecurity.commons.AbstractHibernateDao;
import pontosecurity.dao.IDeviceDao;

@Repository
public class DeviceDao extends AbstractHibernateDao<Device> implements IDeviceDao {

	public DeviceDao() {
		super(Device.class);
	}
}
