package yuna.skeju.service;


import yuna.skeju.model.unit.Unit;

import java.util.List;

/**
 * Created by ylee on 3/23/2016.
 */
public interface UnitManager {
    List<Unit> getAllUnits();

    void create(Unit unit);
}
