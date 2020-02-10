USE vk;

SELECT COUNT(*)
FROM media
WHERE user_id = 36;


SELECT
       COUNT(*),
       MONTH(created_at),
       MONTHNAME(created_at)
FROM media
GROUP BY MONTH(created_at),
         MONTHNAME(created_at)
ORDER BY MONTH(created_at);


SELECT
       COUNT(id) as cnt,
       media_type_id,
       (SELECT name FROM media_types where id = media.media_type_id)
FROM media
GROUP BY media_type_id
ORDER BY cnt DESC;


SELECT
       COUNT(id) as cnt,
       (SELECT firstname FROM users WHERE id = media.user_id) as user
FROM media
GROUP BY user
ORDER BY cnt DESC;





