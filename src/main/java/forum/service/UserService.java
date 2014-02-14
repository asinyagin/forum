package forum.service;

import forum.model.User;

public interface UserService {

    public User findByUsername(String username);

    public User save(User user);
}
