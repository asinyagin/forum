package forum.service;

import forum.model.Topic;
import forum.model.User;

import java.util.List;

public interface TopicService {

    public Topic get(long id);

    public List<Topic> list(int offset, int limit);

    public long count();

    public Topic save(Topic topic);

    public void delete(long id, User user) throws Exception;
}
