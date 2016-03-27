package yuna.skeju.controller;

import org.springframework.web.bind.annotation.*;

@RestController
public class MainController
{
    @ResponseBody
    public String index() {
        return "index()\n";
    }

    @RequestMapping(value="/user/{userId}", method= RequestMethod.GET)
    @ResponseBody
    public String user(@PathVariable String userId) {
        return String.format("Logged In as User %s\n", userId);
    }

	@RequestMapping(value="/generate", method=RequestMethod.GET)
    @ResponseBody
	public String login() {
		return String.format("Success: SVG XML Generated");
	} // @RequestParam("userId") String userId

	@RequestMapping(value="/login", method=RequestMethod.POST)
    @ResponseBody
	public String loginNew(@RequestParam("userId") String userId) {
		return String.format("New User %s", userId);
	}

}