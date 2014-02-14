package forum.config;

import forum.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.Collections;

@Service
public class UserDetailsServiceImpl implements UserDetailsService {

    @Autowired
    private UserService userService;

    @Override
    public UserDetails loadUserByUsername(String username)
            throws UsernameNotFoundException {
        forum.model.User user = userService.findByUsername(username);
        System.out.println("User: " + user.getUsername());

        if (user == null) {
            throw new UsernameNotFoundException("User not found");
        }

        return new User(
                user.getUsername(), user.getPassword(),
                true, true, true, true,
                Collections.singletonList(new SimpleGrantedAuthority("USER"))
        );
    }
}
