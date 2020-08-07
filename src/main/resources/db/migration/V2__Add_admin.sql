INSERT INTO dt_user (id, username, password, active)
    values (1, 'master', 'master', true);

INSERT INTO dt_user_role (dsid_user, roles)
    values (1, 'USER'), (1, 'ADMIN');