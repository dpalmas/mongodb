<h1 align="center">
  MongoDB: Uma alternativa aos banco relacionais tradicionais
</h1>

<p align="center">Atividades MongoDB Alura.</a>
</p>

<p align="center">
  
  <img alt="GitHub language count" src="https://img.shields.io/github/languages/count/dpalmas/mongodb?color=0000FF">

  <img alt="License" src="https://img.shields.io/github/license/dpalmas/mongodb?color=0000FF&logo=MIT">
  
  <a href="https://github.com/dpalmas/redis2/commits/master">
    <img alt="GitHub last commit" src="https://img.shields.io/github/last-commit/dpalmas/mongodb?color=0000FF">
  </a>
</p>

**1- Acesse o cliente MongoDB (mongo) e crie uma coleção chamada alunos. :pencil:**

```
mongo
db.createCollection("alunos")
```

**2 - Insira um aluno com as seguintes informações. :pencil:**

Nome: Felipe
Data de nascimento: 26/02/1994
Notas: [10, 9, 4.5]
Nome do curso: Sistemas de informação
Nome da habilidade : Inglês
Nível da habilidade: Avançado

``` 
db.alunos.insert({
    "nome": "Felipe",
    "data_nascimento": new Date(1994, 02, 26),
    "notas": [10, 9, 4.5],
    "curso": {
        "nome": "Sistemas de informação"
    },
    "habilidades": [
        {
            "nome": "Inglês",
            "nível": "Avançado"
        }
    ] 
})
```

**3 - Cite alguns cenários vantajosos e desvantajosos para o uso do MongoDB. :pencil:**

Uma situação onde o MongoDB é bastante usado é quando precisamos realizar buscas por proximidade, como, por exemplo, localizar a pizzaria mais próxima de você.
Situações onde o uso do MongoDB não é indicado são cenários onde precisamos fazer muitas operações de agregação em uma única query, isso tem muito custo para o MongoDB.

**4 - Insira os alunos com as seguintes informações. :pencil:**

Aluno 1:

Nome: Paulo
Data de nascimento: 31/12/1979
Notas: [10, 9, 7]
Nome do curso: Ciências da computação
Nome da habilidade : Inglês
Nível da habilidade: Avançado
Nome da habilidade : Francês
Nível da habilidade: Avançado
Aluno 2:

Nome: Daniela
Data de nascimento: 17/07/1995
Notas: [10, 9, 7]
Nome do curso: Moda
Nome da habilidade : Alemão
Nível da habilidade: Básico

```
db.alunos.insert({
    "nome": "Paulo",
    "data_nascimento": new Date(1979, 12, 31),
    "notas": [10, 9, 7],
    "curso": {
        "nome": "Ciências da computação"
    },
    "habilidades": [
        {
            "nome": "Inglês",
            "nível": "Avançado"
        },
        {
            "nome": "Francês",
            "nível": "Avançado"
        }
    ] 
})

db.alunos.insert({
    "nome": "Daniela",
    "data_nascimento": new Date(1995, 07, 17),
    "notas": [10, 9, 7],
    "curso": {
        "nome": "Moda"
    },
    "habilidades": [
        {
            "nome": "Alemão",
            "nível": "Básico"
        }
    ] 
})
```

**5 - Qual é o comando para listar todos os alunos inseridos até agora? :pencil:**

```
db.alunos.find()
```

**6 - Como faremos para remover um aluno? :pencil:**

db.alunos.remove({"_id": ObjectId("578b87a7239a421f908ed46b")})
Trazer os alunos cujo os cursos sejam Sistemas de Informação ou Engenharia Química:

Não conseguimos obter o resultado porque o segundo sobrescreveu o primeiro e como estavamos utilizando Javascript, isso é um objeto Javascript não é possível utilizar o mesmo dicionário para as duas informações, porque temos chave e valor e é por esse motivo que o resultado foi o segundo curso. db.alunos.find({ "curso.nome" : "Sistemas de Informação", "curso.nome" : "Engenharia Quimica" })

Solução utlizar um array em Javascript: db.alunos.find({ $or: [ {"curso.nome" : "Sistemas de Informação"}, {"curso.nome" : "Engenharia Quimica"} ], "nome" : "Daniela" })

db.alunos.find({ "curso.nome" : { $in : ["Sistemas de informação", "Engenharia Quimica"] } })

**7 - Liste todos os alunos com o nome Felipe. :pencil:**

```
db.alunos.find(
    {
        "nome" : "Felipe"
    }
).pretty()
```

**8 - Liste todos os alunos com o nome Felipe e com a data de nascimento de 26/02/1994. :pencil:**

```
db.alunos.find({
    "nome" : "Felipe",
    "data_nascimento" : new Date(1194, 02, 26)
}).pretty()
```

**9 - Liste todos alunos que têm habilidades em inglês. :pencil:**

```
db.alunos.find({
    "habilidades.nome" : "Inglês"
})
```

**10 - Busque todos os alunos dos cursos de Sistemas de informação ou de Ciências da computação. :pencil:**

```
db.alunos.find({$or:
    [
        {"curso.nome": "Sistemas de informação"},
        {"curso.nome": "Ciências da computação"}

    ]
}).pretty()
```
 
Ou:

```
db.alunos.find({"curso.nome": {$in:
    [
        "Sistemas de informação",
        "Ciências da computação"
    ]
}}).pretty()
``` 
 
Cuidado com UPDATE no banco de dados não é igual no SQL(quero setar esse campo para este, os outros ficam intocáveis):

```
db.alunos.update(
    {
        "curso.nome" : "Sistema de Informação"
    },
    {
        "nome" : "Sistemas de Informação"
    }
)
```

Solução utilizar o $set que é "quase" o mesmo no SQL:

```
db.alunos.update(
    {
        "curso.nome" : "Sistema de Informação"
    },
    $set : {
        "curso.nome" : "Sistemas de Informação"
    }
)
```

O update por padrão só vai atualizar o primeiro elemento que ele encontra no documento, também permite fazer operações.

```
db.alunos.update(
    {
        "curso.nome" : "Sistemas de informação"
    },
    {
        $set : {
            "curso.nome" : "Sistemas de Informação"
        }
    }
)
```

Solução executar utilizando o comando multi para atuliazar várias linhas.

```
db.alunos.update(
    {
        "curso.nome" : "Sistemas de informação"
    },
    {
        $set : {
            "curso.nome" : "Sistemas de Informação"
        }
    }, {
        multi : true
    }
)
```

Fazendo update para adicionar um valor na tabela de notas:

```
db.alunos.udpate(
    {
        "_id": ObjectId("60af9ff62549b0113cac42de")
    },
    {
        $push: {
            notas: 8.5
        }
    }
)
```

No caso anterior é adicionado o valor 8.5 uma vez, mas se executarmos novamente, irá adicionar 8.5 de novo, com o comando $addset que adiciona elementos que não existam, no caso é um conjunto matemático que não possui elementos repetidos diferente do $set que é um array e pode ter elementos repetidos.

Situação bizarra que não deve ser utilizada:

```
db.alunos.udpate(
    {
        "_id": ObjectId("60af9ff62549b0113cac42de")
    },
    {
        $push: {
            notas: [8.5, 3]
        }
    }
)
```

Solução utilizar o comando $each:

```
db.alunos.udpate(
    {
        "_id": ObjectId("60af9ff62549b0113cac42de")
    },
    {
        $push: {
            notas:  { 
                        $each: [8.5, 3]
                    }
        }
    }
)
```

**11 - Substitua as informações de um documento pelas suas próprias informações: seu nome, o curso que você gostaria de fazer, etc. :pencil:**

```
db.alunos.update({"_id": ObjectId("1234567891")}, 
{
    "nome": "Fulano",
    "data_nascimento": new Date(1994, 01, 11),
    "notas": [10, 9, 4],
    "curso": {
        "nome": "Ciência da Computação"
    },
    "habilidades": [
        {
            "nome": "Japonês",
            "nível": "Básico"
        }
    ] 
})
```

**12 - Altere o curso de um aluno para o curso que desejar. :pencil:**

```
db.alunos.update(
    {
        "curso.nome": "Design"
    }, 
    {
        $set:
            {
                "curso.nome": "Turismo"
            }
    }
})
```

**13 - Atualize o mesmo campo de todos os alunos com as informações que quiser. :pencil:**

```
db.alunos.update(
    {
        "curso.nome" : "Turismo"
    },
    {
        $set : {
            "curso.nome" : "Hotelaria"
        }
    }, {
        multi : true
    }
)
```

**14 - Adicione mais uma nota para o aluno Felipe. :pencil:**

```
db.alunos.udpate(
    {
        "nome" : "Felipe"
    },
    {
        $push: {
            notas: 8.5
        }
    }
)
```

**15 - Adicione duas notas para o aluno Guilherme. :pencil:**

```
db.alunos.udpate(
    {
        "nome" : "Guilherme"
    },
    {
        $push: {
            notas:  { 
                        $each: [6.9, 8.6]
                    }
        }
    }
)
```

Procurar uma nota maior que 5.

```
db.alunos.find({
    notas : { $gt : 5 }
})
```

Ou:

```
db.alunos.findOne({
    notas : { $gt : 5 }
})
```

Traz os resultados em ordem alfabética

```
db.alunos.find().sort({"nome" : 1})
```

Traz os resultados em ordem alfabética limitando o resultado

```
db.alunos.find().sort({"nome" : 1}).limit(3)
```

**16 - Busque todos os alunos com notas menores que 5. :pencil:**

```
db.alunos.find({
    notas : { $gt : 5 }
})
```

**17 - Busque apenas um aluno do curso de Sistemas de informação. :pencil:**

```
db.alunos.findOne({
        "curso.nome" : "Sistemas de informação"
})
```

Ou

```
db.alunos.find({
    "curso.nome":"Sistemas de informação"
}).limit(1)
```

**18 - Ordene os alunos em ordem alfabética crescente. :pencil:**

```
db.alunos.find().sort({"nome" : 1})
```

Trabalhando com coordenadas, busca por proximidade numa esfera no planeta terra:

```
db.alunos.update(
    {
        "_id : ObjectId("60af9ff62549b0113cac42de")"
    },
    {
        $set : {
            localizacao : {
                endereco : "Rua Vergueiro, 3185",
                cidade : "São Paulo", 
                pais : "Brasil",
                coordenadas : [-23.588213, -46.632356],
                type : "Point"
            }
        }
    }
)
```

Procura quem esta mais proximo de tal usuario:

```
db.alunos.aggregate([
    {
        $geoNear : {
            near: {
                coordinates: [-23.5640265, -466527128],
                type : "Point"
            }
        },
        distanceField :  "distancia.calculada",
        spherical : true,
        num : 4
    },
    { $skip : 1 }
])
```

```
db.alunos.createIndex({
    localizacao : "2dsphere"
})
```

**19 - Crie um índice do 2dsphereno campo localizaçãoda coleção alunos. :pencil:**

```
db.alunos.createIndex(
    {
        "localizacao": "2dsphere"
    }
)
```

**20 - Busque os alunos mais próximos ao Marcelo. :pencil:**

```
db.alunos.aggregate([{
    $geoNear:{
        "near": {
            "coordinates":[-23.588055, -46.632403],
            "type":"Point"
},
"distanceField": "distancia.calculada",
"spherical": true
}
}])
```

**21 - Limite a quantidade de dados retornados em 4. :pencil:**

```
db.alunos.aggregate([{
    "$geoNear":{
        "near": {
            "coordinates":[-23.588055, -46.632403],
            "type":"Point"
},
"distanceField": "distancia.calculada",
"spherical": true,
"num":4
}
}])
```

**22 - Ignore o documento que tem o campo distancia.calculada com o valor 0. :pencil:**

```
db.alunos.aggregate([{
    "$geoNear": {
      "near": {
        "coordinates":[-23.588055, -46.632403],
        "type":"Point"
      },
    "distanceField": "distancia.calculada",
    "spherical": true
    }
  },
  { $skip: 1 }
]);
```

Como criar um banco de dados MongoDB e que não se comporta como um banco de dados MySQL por exemplo, conseguimos manipular os dados de forma diferente, alterar, pesquisar dados. Busca por proximidade, mas o MongoDB não se limita a so isso.
