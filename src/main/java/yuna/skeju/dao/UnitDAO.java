package yuna.skeju.dao;

import yuna.skeju.model.unit.Unit;

import javax.sql.DataSource;
import java.util.List;

/**
 * Created by ylee on 3/23/2016.
 */
public interface UnitDAO {
    List<Unit> getAllUnits();

    void setDataSource(DataSource ds);

    void create(Unit unit);
}
