USE vk;

-- CROSS JOIN
SELECT *
FROM users, messages
ORDER BY users.id;