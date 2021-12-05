package pontosecurity.commons;

import java.io.Serializable;
import java.util.List;

public interface IOperations<T extends Serializable> {

    T load(Long id);

    List<T> listall();

    List<T> listall(String[] order);

    T persist(final T entity);

    List<T> persist(final List<T> entities);

    void delete(final long entityId);
}
