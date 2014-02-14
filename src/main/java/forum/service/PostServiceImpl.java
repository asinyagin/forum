package forum.service;

import forum.model.Post;
import forum.model.User;
import forum.repository.PostRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class PostServiceImpl implements PostService {

    @Autowired
    private PostRepository postRepository;

    @Autowired
    private TopicService topicService;

    @Override
    @Transactional
    public List<Post> findByTopic(long topicId, int offset, int limit) {
        return postRepository.findByTopic(topicService.get(topicId),
                new PageRequest(offset, limit));
    }

    @Override
    @Transactional
    public long countByTopic(long topicId) {
        return postRepository.countByTopic(topicService.get(topicId));
    }

    @Override
    @Transactional
    public Post save(long topicId, Post post) {
        post.setTopic(topicService.get(topicId));
        return postRepository.save(post);
    }

    @Override
    @Transactional
    public void delete(long id, User user) throws Exception {
        Post post = postRepository.findOne(id);
        if (post.getUser().getId() == user.getId()) {
            postRepository.delete(post);
        } else {
            throw new Exception();
        }
    }
}
