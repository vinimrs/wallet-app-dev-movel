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

app.get("/login", async (req, res) => {
  console.log("login");
  const email = req.query.email;
  const password = req.query.password;
  for (b of users) {
    if (b.email === email && b.password === password) {
      res.status(200).json({
        success: true,
        message: "login success",
      });
      return;
    }
  }

  res.status(404).send("users not found");
});

app.get("/users", async (req, res) => {
  console.log("get users");
  res.json(users);
});

app.get("/users/:id", async (req, res) => {
  const id = parseInt(req.params.id);
  console.log("get users " + id);
  for (b of users) {
    if (b.id === id) {
      res.json(b);
      return;
    }
  }

  res.status(404).send("users not found");
});

app.get("/users/:id/messages", async (req, res) => {
  const id = parseInt(req.params.id);
  console.log(`get users ${id} messages`);
  bb = findusers(users, id);
  if (bb != null) {
    res.json(bb.messages);
    return;
  }

  res.status(404).send("users not found");
});

app.post("/users", async (req, res) => {
  const user = req.body;
  console.log("post users: " + user);
  if (findusers(users, user.id) != null) {
    res.status(400).send("user already exists");
    return;
  }
  users.push(user);
  res.status(204).json(user);
});

app.post("/users/:iid/messages", async (req, res) => {
  const iid = parseInt(req.params.iid);
  console.log(`post message to users ${iid}`);
  bb = findusers(users, iid);
  if (bb != null) {
    const msg = req.body;
    msg.timestamp = new Date().toString();
    bb.messages.push(msg);
    res.json({ message: "Message added to users " + bb.name });
    return;
  }

  res.status(404).send("users not found");
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
  return [
    {
      id: 1,
      name: "João da Silva",
      email: "joao@email.com",
      password: "12345678",
      planning: {
        initBalance: 5000,
        balance: 4200.21,
        transactions: [
          {
            id: 1,
            date: "2021-05-01",
            description: "Salário",
            value: 5000,
          },
          {
            id: 2,
            date: "2021-05-02",
            description: "Aluguel",
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
        balance: -1000,
        transactions: [
          {
            id: 1,
            date: "2021-05-01",
            description: "Salário",
            value: 2000,
          },
          {
            id: 2,
            date: "2021-05-02",
            description: "Aluguel",
            value: -300,
          },
        ],
      },
    },
  ];
}
