package forum.web;

import forum.model.Post;
import forum.model.User;
import forum.service.PostService;
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
@RequestMapping("/topics/{topicId}/posts")
public class PostController {

    @Autowired
    private PostService postService;

    @Autowired
    private UserService userService;

    @RequestMapping(method = RequestMethod.GET)
    public @ResponseBody List<Post> list(@PathVariable long topicId,
                                         @RequestParam int offset,
                                         @RequestParam int limit,
                                         HttpServletResponse response) {
        response.setHeader("X-Total-Count",
                String.valueOf(postService.countByTopic(topicId)));
        return postService.findByTopic(topicId, offset, limit);
    }

    @PreAuthorize("isAuthenticated()")
    @RequestMapping(method = RequestMethod.POST)
    @ResponseStatus(HttpStatus.OK)
    public @ResponseBody Post save(@PathVariable long topicId,
                                   @RequestBody Post post) {
        UserDetails details = (UserDetails)SecurityContextHolder.getContext()
                .getAuthentication().getPrincipal();
        post.setUser(userService.findByUsername(details.getUsername()));
        postService.save(topicId, post);
        return post;
    }

    @PreAuthorize("isAuthenticated()")
    @RequestMapping(method = RequestMethod.DELETE, value = "/{id}")
    public ResponseEntity delete(@PathVariable long id) {
        UserDetails details = (UserDetails)SecurityContextHolder.getContext()
                .getAuthentication().getPrincipal();
        User user = userService.findByUsername(details.getUsername());

        try {
            postService.delete(id, user);
            return new ResponseEntity<Long>(id, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<String>(HttpStatus.FORBIDDEN);
        }
    }
}
