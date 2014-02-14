package forum.service;

import forum.model.Topic;
import forum.model.User;
import forum.repository.TopicRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class TopicServiceImpl implements TopicService {

    @Autowired
    private TopicRepository topicRepository;

    @Override
    public Topic get(long id) {
        return topicRepository.findOne(id);
    }

    @Override
    @Transactional
    public List<Topic> list(int offset, int limit) {
        return topicRepository.findAll(
                new PageRequest(offset, limit, new Sort(new Sort.Order("id")))
        ).getContent();
    }

    @Override
    public long count() {
        return topicRepository.count();
    }

    @Override
    @Transactional
    public Topic save(Topic topic) {
        return topicRepository.save(topic);
    }

    @Override
    @Transactional
    public void delete(long id, User user) throws Exception {
        Topic topic = topicRepository.findOne(id);
        if (topic.getUser().getId() == user.getId()) {
            topicRepository.delete(topic);
        } else {
            throw new Exception();
        }
    }
}
