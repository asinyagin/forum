package forum.repository;

import forum.model.Post;
import forum.model.Topic;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface PostRepository extends CrudRepository<Post, Long> {

    public List<Post> findByTopic(Topic topic, Pageable pageable);

    public long countByTopic(Topic topic);
}
