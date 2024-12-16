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