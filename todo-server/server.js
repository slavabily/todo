let bodyParser = require('body-parser');
let app = require('express')();
let port = 3003;

app.use(bodyParser.json());

let todos = [
    {item: "Take out trash", priority: 0},
    {item: "Buy eggs", priority: 1},
    {item: "Clean the house", priority: 2}
]

app.get('/', (request, response) => {
    response.send({items: todos});
    console.log(todos);
})

app.post('/add', function (request, response) {
        if (request.body && request.body.item !== "") {
            todos.push(request.body);
            console.log(todos);
            response.send({ items: todos });
        } else {
            response.status(400).send({ message: "Todo item must have a title" });
        }

    });

app.delete('/delete', function (request, response) {
    if (request.body && request.body.index !== "") {
        todos.splice(request.body.index, 1)
        console.log(todos);
        response.send({ items: todos });
    } else {
        response.status(400).send({ message: "Todo item not found" });
    }
})

app.put('/put', function(request, response) {
    if (request.body && request.body.index && request.body.item !== "") {
        todos.splice(request.body.index, 1);
        todos.push(request.body);
        console.log(todos);
        response.send({ items: todos })
    } else {
        response.status(400).send({ message: "Todo item not found" })
    }
})

app.listen(port, () => console.log(`Example app listening on port ${port}!`))
