package forum.web;

import forum.model.Post;
import forum.model.Topic;
import forum.model.User;
import forum.service.TopicService;
import forum.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

@Controller
@RequestMapping("/topics")
public class TopicController {

    @Autowired
    private TopicService topicService;

    @Autowired
    private UserService userService;

    @RequestMapping(method = RequestMethod.GET)
    public @ResponseBody List<Topic> list(@RequestParam int offset,
                                          @RequestParam int limit,
                                          HttpServletResponse response) {
        response.setHeader("X-Total-Count",
                String.valueOf(topicService.count()));
        return topicService.list(offset, limit);
    }

    @PreAuthorize("isAuthenticated()")
    @RequestMapping(method = RequestMethod.POST)
    @ResponseStatus(HttpStatus.OK)
    public @ResponseBody Topic save(@RequestBody Topic topic) {
        UserDetails details = (UserDetails)SecurityContextHolder.getContext()
                .getAuthentication().getPrincipal();
        User user = userService.findByUsername(details.getUsername());
        topic.setUser(user);
        for (Post post : topic.getPosts()) {
            post.setUser(user);
        }
        topicService.save(topic);
        return topic;
    }

    @PreAuthorize("isAuthenticated()")
    @RequestMapping(method = RequestMethod.DELETE, value = "/{id}")
    public ResponseEntity delete(@PathVariable long id) {
        UserDetails details = (UserDetails)SecurityContextHolder.getContext()
                .getAuthentication().getPrincipal();
        User user = userService.findByUsername(details.getUsername());

        try {
            topicService.delete(id, user);
            return new ResponseEntity<Long>(id, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<String>(HttpStatus.FORBIDDEN);
        }
    }
}
