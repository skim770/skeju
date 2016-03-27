package yuna.skeju.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import yuna.skeju.mapper.UnitMapper;
import yuna.skeju.model.unit.Unit;

import javax.sql.DataSource;
import java.util.List;

@Repository("unitDAO")
public class UnitDAOImpl implements UnitDAO {

    private JdbcTemplate jdbcTemplate;

    @Autowired
    public void setDataSource(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    public List<Unit> getAllUnits() {
        String query = "SELECT * FROM unit"; //  where id = ?"
        List<Unit> units = jdbcTemplate.query(query, new UnitMapper());
        return units;
    }

    public List<Unit> getUnitBySeries(String dockzone, int index) {
        String query = String.format("SELECT * FROM unit WHERE id LIKE 'slot_%s_%d_%'", dockzone, index); //  where id = ?"
        List<Unit> units = jdbcTemplate.query(query, new UnitMapper());
        return units;
    }

    public void create(Unit unit) {
        String query = "INSERT INTO unit VALUES(?,?,?,?,?,?,?,?)";
        this.jdbcTemplate.update(query, "Event", unit.getId(), unit.getSid(), unit.getWidth(), unit.getHeight(), unit.getDockzone(), unit.getDoorslot(), unit.getTransform());
    }
}
