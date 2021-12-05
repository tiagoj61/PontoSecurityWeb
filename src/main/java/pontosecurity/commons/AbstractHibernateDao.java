package pontosecurity.commons;

import com.google.common.base.Preconditions;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import org.apache.commons.lang3.StringUtils;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.CriteriaSpecification;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.springframework.beans.factory.annotation.Autowired;

@SuppressWarnings("unchecked")
public abstract class AbstractHibernateDao<T extends Serializable> implements IOperations<T> {

    private final Class<T> clazz;
    private List<Predicate> predicates = new ArrayList<>();

    @Autowired
    protected SessionFactory sessionFactory;

    public AbstractHibernateDao(Class<T> clazz) {
        this.clazz = Preconditions.checkNotNull(clazz);
    }

    @Override
    public T load(Long id) {
        return (T) getCurrentSession().get(clazz, id);
    }


    @Override
    public List<T> listall() {
        String from = "FROM " + clazz.getName();
        return getCurrentSession().createQuery(from).list();
    }

    @Override
    public List<T> listall(String[] order) {
        CriteriaBuilder cb = getCurrentSession().getCriteriaBuilder();
        CriteriaQuery<T> cq = cb.createQuery(clazz);
        Root<T> root = cq.from(clazz);
        for (String s : order) {
            if (StringUtils.endsWithIgnoreCase(s, " DESC")) {
                s = StringUtils.replaceIgnoreCase(s, " DESC", "");
                cq.orderBy(cb.desc(root.get(s)));
            } else {
                s = StringUtils.replaceIgnoreCase(s, " ASC", "");
                cq.orderBy(cb.asc(root.get(s)));
            }
        }
        return getResultList(cq);
    }

    @Override
    public T persist(T entity) {
        Preconditions.checkNotNull(entity);
        return (T) getCurrentSession().merge(entity);
    }

    @Override
    public List<T> persist(List<T> entities) {
        List<T> list = new ArrayList<>();
        for (T t : entities) {
            Preconditions.checkNotNull(t);
            t = (T) getCurrentSession().merge(t);
            list.add(t);
        }
        return list;
    }

    @Override
    public void delete(final long entityId) {
        final T entity = load(entityId);
        Preconditions.checkState(entity != null);
        Preconditions.checkNotNull(entity);
        getCurrentSession().delete(entity);
    }

    protected final Session getCurrentSession() {
        return sessionFactory.getCurrentSession();
    }

    public T getSingleResultOrNull(CriteriaQuery cq) {
        EntityManager entityManager = null;
        try {
            EntityManagerFactory factory = getCurrentSession().getEntityManagerFactory();
            entityManager = factory.createEntityManager();

            List<T> list = entityManager.createQuery(cq)
                    .setMaxResults(1)
                    .getResultList();
            if (list.isEmpty()) {
                return null;
            }
            return list.get(0);
        } finally {
            if (entityManager != null && entityManager.isOpen()) {
                entityManager.close();
            }
        }
    }

    public List<T> getResultList(CriteriaQuery cq) {
        EntityManager entityManager = null;
        try {
            EntityManagerFactory factory = getCurrentSession().getEntityManagerFactory();
            entityManager = factory.createEntityManager();
            return entityManager.createQuery(cq).getResultList();
        } finally {
            if (entityManager != null && entityManager.isOpen()) {
                entityManager.close();
            }
        }
    }

    public List<T> getResultList(CriteriaQuery cq, int offset, int limit) {
        EntityManager entityManager = null;
        try {
            EntityManagerFactory factory = getCurrentSession().getEntityManagerFactory();
            entityManager = factory.createEntityManager();
            return entityManager.createQuery(cq)
                    .setFirstResult(offset)
                    .setMaxResults(limit)
                    .getResultList();
        } finally {
            if (entityManager != null && entityManager.isOpen()) {
                entityManager.close();
            }
        }
    }

    protected void startPredicate() {
        this.predicates = new ArrayList<>();
        this.predicates.clear();
    }

    /**
     * Adiciona um novo Predicate para uma lista. Iniciar o processo por
     * `startPredicate`
     *
     * @param predicate
     */
    protected void addPredicate(Predicate predicate) {
        this.predicates.add(predicate);
    }

    protected Predicate[] getPredicates() {
        return this.predicates.toArray(new Predicate[this.predicates.size()]);
    }
}
