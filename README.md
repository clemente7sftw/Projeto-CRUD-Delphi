# 📚  Projeto CRUD Delphi
## Por Gabrielle Clemente. 
Este projeto é um sistema de gerenciamento acadêmico desenvolvido em Delphi, com foco nas operações CRUD (Create, Read, Update, Delete) para as principais entidades de um ambiente escolar. 
## 💡 Descrição do Projeto
O sistema oferece uma interface administrativa simples e funcional, permitindo Incluir, Listar, Atualizar e Excluir dados das seguintes entidades: \
👨‍🎓 Estudantes \
👩‍🏫 Professores \
🏫 Turmas \
📘 Disciplinas \
📝 Matrículas \
Todos os dados são armazenados em arquivos .txt.
## ✨ Descrição do Sistema
🚀 Funcionalidades \
A Tela inicial possui opções para acessar o CRUD de qualquer entidade, as operações são completas, possuem Inserção, Consulta, Edição e Exclusão, validação de dados como código, CPF, e existência relacional, Controle de navegação entre as telas e geração automática de códigos para novas entradas. 
## 🧩 Entidades Relacionais 
As entidades do sistema possuem relações entre si. Por Exemplo:
Cada Matrícula está vinculada a um Estudante e a uma Turma; \
Cada Turma pode conter várias Disciplinas e Estudantes; \
Professores estão relacionados às Disciplinas que ministram. \
E o sistema possui uma Unit chamada UFunçoes,ela define uma classe base TFunções, que fornece funcionalidades genéricas para manipulação de dados visuais (como TStringGrid e TListBox). Ela serve como uma superclasse para outras unidades (como UEstudantes, UProfessores, etc.), que herdam dessa base e implementam funcionalidades específicas.



