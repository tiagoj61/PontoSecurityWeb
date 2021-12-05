package pontosecurity.dao.impl;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.SQLQuery;
import org.hibernate.query.NativeQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import pontosecurity.bean.Device;
import pontosecurity.bean.Funcionario;
import pontosecurity.bo.IDeviceBo;
import pontosecurity.commons.AbstractHibernateDao;
import pontosecurity.dao.IFuncionarioDao;

@Repository
public class FuncionarioDao extends AbstractHibernateDao<Funcionario> implements IFuncionarioDao {
	@Autowired
	private IDeviceBo deviceBo;

	public FuncionarioDao() {
		super(Funcionario.class);
	}

	@Override
	public Funcionario loadByCodigo(String codigo) {
		StringBuilder sql = new StringBuilder("SELECT id FROM funcionario WHERE codigo=:codigo");
		SQLQuery query = getCurrentSession().createSQLQuery(sql.toString());
		query.setParameter("codigo", codigo);
		List result = query.list();
		for (Object obj : result) {
			return load(((BigInteger) obj).longValue());
		}
		return null;
	}

	@Override
	public void storesDevicesByCode(List<String> enderecoMacDevices, Funcionario funcionario) {
		StringBuilder sql = new StringBuilder();
		sql.append("INSERT INTO device( ");
		for (int i = 0; i < enderecoMacDevices.size(); i++) {
			if(i==0) {
				sql.append(":id" + i );
			}else {
				sql.append(" , "+":id" + i );
			}
			
		}
		sql.append(" )");
		System.out.println(sql);
		NativeQuery query = getCurrentSession().createSQLQuery(sql.toString());
		for (int i = 0; i < enderecoMacDevices.size(); i++) {
			query.setParameter("id" + i, enderecoMacDevices.get(i));
		}
		query.executeUpdate();
	}

	@Override
	public void removeDevicesByCode(List<String> enderecoMacDevices, Funcionario funcionario) {
		StringBuilder sql = new StringBuilder();
		sql.append("DELETE FROM device WHERE funcionario_id=:id");
		SQLQuery query = getCurrentSession().createSQLQuery(sql.toString());
		query.setParameter("id", funcionario.getId());
		query.executeUpdate();
	}

	@Override
	public List<Device> devicesByFuncionario(Long id) {
		List<Device> devices =new ArrayList<>();
		StringBuilder sql = new StringBuilder("SELECT id FROM device WHERE funcionario_id=:id");
		SQLQuery query = getCurrentSession().createSQLQuery(sql.toString());
		query.setParameter("id", id);
		List result = query.list();
		for (Object obj : result) {
			devices.add(deviceBo.load(((BigInteger) obj).longValue()));
		}
		return devices;
	}
}
