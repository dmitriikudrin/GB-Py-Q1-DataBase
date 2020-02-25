USE vk;


DROP PROCEDURE IF EXISTS friendship_offers;
DELIMITER //
CREATE PROCEDURE friendship_offers(IN for_users_id BIGINT)
BEGIN
    -- общий город
    SELECT p2.user_id
    FROM profiles p1
    JOIN profiles p2
        ON p1.hometown = p2.hometown
    WHERE p1.user_id = for_users_id AND p2.user_id <> for_users_id

        UNION

    -- общие группы
    SELECT uc2.user_id
    FROM users_communities uc1
    JOIN users_communities uc2
        ON uc1.community_id = uc2.community_id
    WHERE uc1.user_id = for_users_id AND uc2.user_id <> for_users_id

        UNION

    -- друзья друзей
    select fr3.target_user_id
	from friend_requests fr1
		join friend_requests fr2
		    on (fr1.target_user_id = fr2.initiator_user_id
		        or fr1.initiator_user_id = fr2.target_user_id)
		join friend_requests fr3
		    on (fr3.target_user_id = fr2.initiator_user_id
		        or fr3.initiator_user_id = fr2.target_user_id)
	where (fr1.initiator_user_id = for_users_id or fr1.target_user_id = for_users_id)
	 	and fr2.status = 'approved' -- оставляем только подтвержденную дружбу
	 	and fr3.status = 'approved'
		and fr3.target_user_id <> for_users_id -- исключим себя

	order by rand() -- будем брать всегда случайные записи
	limit 5; -- ограничим всю выборку до 5 строк
END//
DELIMITER ;


CALL friendship_offers(37);

SELECT TRUNCATE(friendship_deirection(37), 2) AS rating;