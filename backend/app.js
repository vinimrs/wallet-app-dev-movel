const express = require("express");
const bodyParser = require("body-parser");
const cors = require("cors");

const app = express();
const port = 3000;

let users = initUsers();

app.use(cors());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

app.get("/reset", async (req, res) => {
  console.log("reset");
  users = initUsers();
  res.json({ message: "users reset" });
});

app.post("/login", async (req, res) => {
  const { email, password } = req.body;
  for (b of users) {
    if (b.email === email && b.password === password) {
      console.log("login success" + b);
      res.status(200).json({
        success: true,
        message: "login success",
        data: b,
      });
      return;
    }
  }

  res.status(404).json({
    success: false,
    message: "Usuário não existe ou senha inválida",
    data: null,
  });
});

app.get("/users/:id", async (req, res) => {
  const user = findusers(users, parseInt(req.params.id));
  if (user == null) {
    res.status(404).json({
      success: false,
      message: "user not found",
      data: null,
    });
    return;
  }
  res.status(200).json({
    success: true,
    message: "user found",
    data: user,
  });
});

app.post("/users", async (req, res) => {
  const user = req.body;
  if (findusers(users, user.id) != null) {
    console.log("user already exists");
    res.status(400).json({
      success: false,
      message: "user already exists",
      data: null,
    });
    return;
  }
  users.push(user);
  res.status(200).json({
    success: true,
    message: "user added",
    data: user,
  });
});

app.post("/users/:id/transactions", async (req, res) => {
  const user = findusers(users, parseInt(req.params.id));
  if (user == null) {
    res.status(404).json({
      success: false,
      message: "user not found",
      data: null,
    });
    return;
  }

  const transaction = req.body;
  transaction.id = user.planning.transactions.length + 1;
  user.planning.transactions.push({
    id: transaction.id,
    date: transaction.date,
    description: transaction.description,
    category: transaction.category,
    value: transaction.value,
    expense: transaction.value < 0,
  });
  user.planning.balance += transaction.value;

  res.status(200).json({
    success: true,
    message: "transaction added",
    data: user,
  });
});

app.listen(port, () => {
  console.log("started server...");
});

function findusers(users, iid) {
  for (b of users) {
    if (b.id === iid) {
      return b;
    }
  }
  return null;
}

function initUsers() {
  const u = [
    {
      id: 1,
      name: "João da Silva",
      email: "joao",
      password: "12",
      planning: {
        initBalance: 0,
        transactions: [
          {
            id: 1,
            date: "01/05/2021",
            description: "Salário",
            category: "Receita",
            value: 5000,
            expense: false,
          },
          {
            id: 2,
            date: "02/05/2021",
            description: "Despesa",
            category: "Mercado",
            value: -800,
            expense: true,
          },
        ],
      },
    },
    {
      id: 2,
      name: "Joana da Silva",
      email: "joana@email.com",
      password: "12345678",
      planning: {
        initBalance: 0,
        transactions: [
          {
            id: 1,
            date: "01/05/2021",
            description: "Salário",
            category: "Receita",
            value: 2000,
            expense: false,
          },
          {
            id: 2,
            date: "02/05/2021",
            description: "Despesa",
            category: "Mercado",
            value: -300,
            expense: true,
          },
        ],
      },
    },
  ];

  return u.map((b) => {
    return {
      ...b,
      planning: {
        ...b.planning,
        balance:
          b.planning.initBalance +
          b.planning.transactions.reduce((acc, t) => acc + t.value, 0),
      },
    };
  });
}
