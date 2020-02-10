create table communities
(
    id           bigint unsigned auto_increment,
    name         varchar(150) null,
    number_users int          not null,
    constraint id
        unique (id)
);

create index idx_communities_name
    on communities (name);

alter table communities
    add primary key (id);

create table media_types
(
    id   bigint unsigned auto_increment,
    name varchar(150) null,
    constraint id
        unique (id)
);

alter table media_types
    add primary key (id);

create table users
(
    id            bigint unsigned auto_increment,
    firstname     varchar(50)                       null,
    lastname      varchar(50)                       null,
    email         varchar(120)                      null,
    password_hash varchar(150)                      null,
    phone         varchar(12)                       null,
    is_deleted    tinyint(1)   default 0            not null,
    created_at    datetime                          null,
    updated_at    datetime                          null,
    main_photo    varchar(100) default 'main_photo' null,
    city          varchar(100) default 'city'       null,
    constraint email
        unique (email),
    constraint id
        unique (id)
);

create index idx_users_name_idx
    on users (firstname, lastname);

create index idx_users_phone
    on users (phone);

alter table users
    add primary key (id);

create table friend_requests
(
    initiator_user_id bigint unsigned                                          not null,
    target_user_id    bigint unsigned                                          not null,
    status            enum ('requested', 'approved', 'unfriended', 'declined') null,
    requested_at      datetime default CURRENT_TIMESTAMP                       null,
    confirmed_at      datetime                                                 null,
    primary key (initiator_user_id, target_user_id),
    constraint fk_initiator_user_id
        foreign key (initiator_user_id) references users (id),
    constraint fk_target_user_id
        foreign key (target_user_id) references users (id)
);

create index idx_initiator_user_id
    on friend_requests (initiator_user_id);

create index idx_target_user_id
    on friend_requests (target_user_id);

create table media
(
    id            bigint unsigned auto_increment,
    media_type_id bigint unsigned                    not null,
    user_id       bigint unsigned                    not null,
    body          text                               null,
    filename      varchar(225)                       null,
    size          int                                null,
    metadata      json                               null,
    created_at    datetime default CURRENT_TIMESTAMP null,
    updated_at    datetime default CURRENT_TIMESTAMP null on update CURRENT_TIMESTAMP,
    constraint id
        unique (id),
    constraint media_ibfk_1
        foreign key (user_id) references users (id),
    constraint media_ibfk_2
        foreign key (media_type_id) references media_types (id)
);

create index media_type_id
    on media (media_type_id);

create index user_id
    on media (user_id);

alter table media
    add primary key (id);

create table likes
(
    id         bigint unsigned auto_increment,
    user_id    bigint unsigned                    not null,
    media_id   bigint unsigned                    not null,
    created_at datetime default CURRENT_TIMESTAMP null,
    constraint id
        unique (id),
    constraint likes_ibfk_1
        foreign key (user_id) references users (id),
    constraint likes_ibfk_2
        foreign key (media_id) references media (id)
);

create index media_id
    on likes (media_id);

create index user_id
    on likes (user_id);

alter table likes
    add primary key (id);

create table messages
(
    id           bigint unsigned auto_increment,
    from_user_id bigint unsigned                    not null,
    to_user_id   bigint unsigned                    not null,
    body         text                               null,
    created_at   datetime default CURRENT_TIMESTAMP null,
    constraint id
        unique (id),
    constraint fk_from_user_id
        foreign key (from_user_id) references users (id),
    constraint fk_to_user_id
        foreign key (to_user_id) references users (id)
);

create index idx_from_user_id
    on messages (from_user_id);

create index idx_to_user_id
    on messages (to_user_id);

alter table messages
    add primary key (id);

create table music
(
    id         bigint unsigned auto_increment,
    user_id    bigint unsigned not null,
    title      varchar(120)    not null,
    singer     varchar(120)    not null,
    album      varchar(120)    null,
    year       year            null,
    genre      varchar(120)    null,
    music_file blob            not null,
    constraint id
        unique (id),
    constraint music_ibfk_1
        foreign key (user_id) references users (id)
);

create index idx_album
    on music (album);

create index idx_signer
    on music (singer);

create index idx_title
    on music (title);

create index user_id
    on music (user_id);

alter table music
    add primary key (id);

create table photo_albums
(
    id      bigint unsigned auto_increment,
    name    varchar(255)    null,
    user_id bigint unsigned null,
    constraint id
        unique (id),
    constraint photo_albums_ibfk_1
        foreign key (user_id) references users (id)
);

create index user_id
    on photo_albums (user_id);

alter table photo_albums
    add primary key (id);

create table photos
(
    id       bigint unsigned auto_increment,
    album_id bigint unsigned null,
    media_id bigint unsigned not null,
    constraint id
        unique (id),
    constraint photos_ibfk_1
        foreign key (album_id) references photo_albums (id),
    constraint photos_ibfk_2
        foreign key (media_id) references media (id)
);

create index album_id
    on photos (album_id);

create index media_id
    on photos (media_id);

alter table photos
    add primary key (id);

create table profiles
(
    user_id    bigint unsigned auto_increment,
    gender     char                               null,
    birthday   date                               null,
    photo_id   bigint unsigned                    null,
    hometown   varchar(100)                       null,
    created_at datetime default CURRENT_TIMESTAMP null,
    is_active  bit      default b'1'              null,
    constraint user_id
        unique (user_id),
    constraint fk_user_id
        foreign key (user_id) references users (id)
            on update cascade,
    constraint `profiles_media(id)__fk`
        foreign key (photo_id) references media (id)
);

alter table profiles
    add primary key (user_id);

create table users_communities
(
    user_id      bigint unsigned not null,
    community_id bigint unsigned not null,
    primary key (user_id, community_id),
    constraint users_communities_ibfk_1
        foreign key (user_id) references users (id),
    constraint users_communities_ibfk_2
        foreign key (community_id) references communities (id)
);

create index community_id
    on users_communities (community_id);

create table video
(
    id               bigint unsigned auto_increment,
    user_id          bigint unsigned                    not null,
    filename         varchar(225)                       not null,
    file_description varchar(1000)                      null,
    video_file       mediumblob                         not null,
    created_at       datetime default CURRENT_TIMESTAMP null,
    constraint id
        unique (id),
    constraint video_ibfk_1
        foreign key (user_id) references users (id)
);

create index idx_filename
    on video (filename);

create index user_id
    on video (user_id);

alter table video
    add primary key (id);

create table video_add
(
    video_id bigint unsigned                    not null,
    user_id  bigint unsigned                    not null,
    added_at datetime default CURRENT_TIMESTAMP null,
    constraint video_add_ibfk_1
        foreign key (video_id) references video (id),
    constraint video_add_ibfk_2
        foreign key (user_id) references users (id)
);

create index user_id
    on video_add (user_id);

create index video_id
    on video_add (video_id);


