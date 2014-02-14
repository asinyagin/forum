package forum.web;

import forum.config.UserDetailsServiceImpl;
import forum.model.User;
import forum.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.persistence.PersistenceException;
import javax.servlet.http.HttpServletRequest;
import java.util.Collections;

@Controller
@RequestMapping("/register")
public class RegisterController {

    @Autowired
    private UserService userService;

    @Autowired
    private UserDetailsServiceImpl userDetailsService;

    @RequestMapping(method = RequestMethod.GET)
    public String page() {
        return "register";
    }

    @RequestMapping(method = RequestMethod.POST)
    public String register(User user, HttpServletRequest request,
                           ModelMap model) {
        try {
            userService.save(user);
            UserDetails details = userDetailsService
                    .loadUserByUsername(user.getUsername());
            SecurityContextHolder.getContext().setAuthentication(
                    new UsernamePasswordAuthenticationToken(
                            details, null,
                            Collections.singletonList(
                                    new SimpleGrantedAuthority("USER")
                            )
                    )
            );
            return "redirect:/";
        } catch (PersistenceException e) {
            model.addAttribute("error", true);
            return "register";
        }
    }
}
