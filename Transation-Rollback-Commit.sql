# Transações 
-- Prorpriedades ACID
-- Atomicidade
-- Consistência
-- Isolamento
-- Durabilidade

set @@autocommit = off;
select @@autocommit;

-- Criando uma tabela com os campos e valores de uma tabela original.
create table dados_Livro
select numero, titulo, preco
from livros;

select*from dados_Livro;

-- Transação com rollback
start transaction;
	delete from dados_Livro;
    insert into dados_Livro(titulo, numero, preco)
		values ('Ciência de Dados com Python', '98765322', 69.90);
	select * from dados_Livro;
rollback; -- Use rollback para resolver erros.

select * from dados_Livro;

-- Transação com commit
start transaction;
	delete from dados_Livro;
    insert into dados_Livro(titulo, numero, preco)
		values ('Ciência de Dados com Python', '98765322', 69.90);
	select * from dados_Livro;
commit; -- Use commit para consolidar a operação

select * from dados_Livro;

## Uso adequado onde os dois são ultilizado juntos
-- Exemplo com Stored Procedure
DELIMITER //
create procedure insere_dados()
begin
	declare erro tinyint default false;
    declare continue handler for sqlexception set erro = true;
    start transaction;
		insert into dados_Livro(numero, titulo, preco)
			values('12321498', 'Bela e a Fera', 30.90);
        insert into dados_Livro(numero, titulo, preco)
			values('85044391', 'As seis lições de Mises', 100.20);
        if erro = false then
			select 'Transação efetuada com sucesso.' as 'Resultado';
		else 
			rollback;
            select 'Erro na transação.' as 'Resultado';
		end if;
end //
DELIMITER ;

call insere_dados();
select*from dados_Livro;