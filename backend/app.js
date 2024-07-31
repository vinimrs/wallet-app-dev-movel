const express = require("express");
const bodyParser = require("body-parser");
const cors = require("cors");

const app = express();
const port = 3000;

// initial data
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
  console.log("login");
  const { email, password } = req.body;
  for (b of users) {
    console.log(b.email + " " + b.password);
    console.log(email + " " + password);
    if (b.email === email && b.password === password) {
      console.log("login success" + b);
      res.status(200).json({
        success: true,
        message: "login success",
        user: b,
      });
      return;
    }
  }

  console.log("Usuário não existe ou senha inválida");

  res.status(404).json({
    success: false,
    message: "Usuário não existe ou senha inválida",
  });
});

app.post("/users", async (req, res) => {
  const user = req.body;
  console.log("post users: " + user);
  if (findusers(users, user.id) != null) {
    console.log("user already exists");
    res.status(400).json({
      success: false,
      message: "user already exists",
      user: null,
    });
    return;
  }
  console.log("user added");
  users.push(user);
  res.status(200).json({
    success: true,
    message: "user added",
    user: user,
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
            value: 5000,
          },
          {
            id: 2,
            date: "02/05/2021",
            description: "Despesa",
            value: -800,
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
            value: 2000,
          },
          {
            id: 2,
            date: "02/05/2021",
            description: "Despesa",
            value: -300,
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
