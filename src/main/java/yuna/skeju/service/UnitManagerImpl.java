package yuna.skeju.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import yuna.skeju.dao.UnitDAO;
import yuna.skeju.model.unit.Unit;

import java.util.List;

/**
 * Created by ylee on 3/23/2016.
 */

@Service
public class UnitManagerImpl implements UnitManager {
    @Autowired
    UnitDAO dao;

    public List<Unit> getAllUnits() {
        return dao.getAllUnits();
    }

    public void create(Unit unit) {
        dao.create(unit);
    }
}
