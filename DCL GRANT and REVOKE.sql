## Linguagem DCL - Data Control Lenguage ##
# premissões de acesso #
-- ALL [PRIVILEGES] EVENT, AFTER, EXECUT, CREATE, FILE, 
-- CREATE USER, INDEX, CREATE VIEW, INSERT, DELETE, 
-- SELECT, DROP, TRIGGER, UPDATE

# 01 - Criar usuário
create user aluno@localhost identified by '.localhost#13';

# 02 - Comando GRANT
-- Atribui um determinado privilégio ao usuario.
grant insert, delete, select on biblioteca.* to aluno@'localhost';
-- conceder todos os privilégios, e que ele possa atribuir privilégios a outros usuários
grant all on biblioteca.* to aluno@'localhost' with grant option;

flush privileges; -- Comando obrigatorio logo após a inserção de privilégios

# 03 - Criando REVOKE
-- Remove um determinado privilégio de um usuário
revoke insert, delete, select on biblioteca.* from aluno@'localhost';

revoke all on biblioteca.* from aluno@'localhost';

flush privileges;
show grants for 'aluno'@'localhost';

# 04 - Roles
create role 'app_developer'@'localhost', 'app_read'@'localhost', 'app_write'@'localhost';

grant all on biblioteca.* to 'app_developer'@'localhost';
grant select on biblioteca.* to 'app_write'@'localhost';
grant insert, update on biblioteca.* to 'app_read'@'localhost';

create user 'dev1'@'localhost' identified by '.localhost#13';
create user 'read_user1'@'localhost' identified by '.localhost#13';
create user 'read_user2'@'localhost' identified by '.localhost#13';
create user 'rw_user3'@'localhost' identified by '.localhost#13';

grant 'app_developer'@'localhost' to 'dev1'@'localhost';
grant 'app_read'@'localhost' to 'read_user1'@'localhost';
grant 'app_read'@'localhost' to 'read_user2'@'localhost';
grant 'app_read'@'localhost', 'app_write'@'localhost' to 'rw_user3'@'localhost';

flush privileges;

# 05 - Modificar o perfil de acesso do usuário aluno, limitando seus recurso.
alter user 'aluno'@'localhost' with max_queries_per_hour 20
max_updates_per_hour 10 max_connections_per_hour 5
max_user_connections 2;
