package yuna.skeju.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.*;
import yuna.skeju.model.Event;
import yuna.skeju.service.EventManager;

import javax.validation.Valid;
import java.util.List;

/**
 * Created by ylee on 3/7/2016.
 */
@RestController
@RequestMapping("/event")
public class EventController {

    @Autowired
    EventManager manager;

    @RequestMapping(method = RequestMethod.GET)
    @ResponseBody
    public List<Event> getAllEvents(Model model) {
        model.addAttribute("event", manager.getAllEvents());
        return manager.getAllEvents();
    }

    @RequestMapping(method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity addEvents(@Valid @RequestBody Event event, Errors errors) { //
        if (errors.hasErrors()) {
            return new ResponseEntity(errors, HttpStatus.BAD_REQUEST);
        }
        manager.create(event);
        return new ResponseEntity(event, HttpStatus.CREATED);
    }

    @RequestMapping(value = "/{eventId}", method = RequestMethod.GET)
    @ResponseBody
    public String getEvent(@PathVariable String eventId) {
        return String.format("Looking for Event %s\n", eventId);
    }

    @RequestMapping(value = "/unit", method = RequestMethod.GET)
    @ResponseBody
    public String getEventByUnitId(@RequestParam("unitId") String unitId) {
        return String.format("Selected Unit %s\n", unitId);
    }

    @RequestMapping(value = "/series", method = RequestMethod.GET)
    @ResponseBody
    public String getEventBySeriesId(@RequestParam("seriesId") String seriesId) {
        return String.format("Selected Series %s\n", seriesId);
    }
}
