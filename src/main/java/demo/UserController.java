package demo;

import org.springframework.web.bind.annotation.*;

@RestController
public class UserController
{

    @RequestMapping("/")
    public String index() {
        return "Yuna says Hi\n";
    }

//	@RequestMapping("/error")
//	public String error() {
//		return "This is an error\n";
//	}

    @RequestMapping(value="/user/{userId}", method= RequestMethod.GET)
    public String user(@PathVariable String userId) {
        return String.format("Logged In as User %s\n", userId);
    }

	@RequestMapping(value="/login", method=RequestMethod.GET)
	public String login(@RequestParam("userId") String userId) {
		return String.format("Validate User %s", userId);
	}

	@RequestMapping(value="/login", method=RequestMethod.POST)
	public String loginNew(@RequestParam("userId") String userId) {
		return String.format("New User %s", userId);
	}

}
