package yuna.skeju.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.*;
import yuna.skeju.model.unit.Unit;
import yuna.skeju.service.UnitManager;

import javax.validation.Valid;
import java.util.List;

/**
 * Created by ylee on 3/23/2016.
 */
@RestController
@RequestMapping("/unit")
public class UnitController {

    @Autowired
    UnitManager manager;

    @RequestMapping(method = RequestMethod.GET)
    @ResponseBody
    public List<Unit> getAllUnits(Model model) {
        model.addAttribute("unit", manager.getAllUnits());
        return manager.getAllUnits();
    }

    @RequestMapping(method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity addUnit(@Valid @RequestBody Unit unit, Errors errors) { //
        if (errors.hasErrors()) {
            return new ResponseEntity(errors, HttpStatus.BAD_REQUEST);
        }
        manager.create(unit);
        return new ResponseEntity(unit, HttpStatus.CREATED);
    }

}
