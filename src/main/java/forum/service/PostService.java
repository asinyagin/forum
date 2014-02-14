package forum.service;

import forum.model.Post;
import forum.model.Topic;
import forum.model.User;

import java.util.List;

public interface PostService {

    public List<Post> findByTopic(long topicId, int offset, int limit);

    public long countByTopic(long topicId);

    public Post save(long topicId, Post post);

    public void delete(long id, User user) throws Exception;
}
