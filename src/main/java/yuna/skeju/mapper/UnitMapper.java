package yuna.skeju.mapper;

import org.springframework.jdbc.core.RowMapper;
import yuna.skeju.model.unit.Unit;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by ylee on 3/24/2016.
 */
public class UnitMapper implements RowMapper<Unit> {
    public Unit mapRow(ResultSet rs, int rowNum) throws SQLException {
        Unit unit = new Unit();
        unit.setId(rs.getString("Id"));
        unit.setWidth(rs.getInt("Width"));
        unit.setHeight(rs.getInt("Height"));
        unit.setDockzone(rs.getString("Dockzone"));
        unit.setDoorslot(rs.getString("Doorslot"));
        unit.setTransform(rs.getString("Transform"));
        return unit;
    }
}
