package pontosecurity.commons;

import java.io.Serializable;
import java.util.List;

import org.springframework.transaction.annotation.Transactional;

@Transactional
public abstract class AbstractService<T extends Serializable> implements IOperations<T> {

    @Override
    public T load(final Long id) {
        return getDao().load(id);
    }

    @Override
    public List<T> listall() {
        return getDao().listall();
    }

    @Override
    public List<T> listall(String[] order) {
        return getDao().listall(order);
    }


    @Override
    public T persist(final T entity) {
        return getDao().persist(entity);
    }

    @Override
    public List<T> persist(List<T> entities) {
        return getDao().persist(entities);
    }

    @Override
    public void delete(final long entityId) {
        getDao().delete(entityId);
    }

    protected abstract IOperations<T> getDao();

}
