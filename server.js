const express = require('express');
const mysql = require('mysql');

const app = express();
app.use(express.json());
const cors = require('cors');
app.use(cors());

const db = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "",
    database: "cryptex"
});

// Verify database connection
db.connect((err) => {
    if (err) {
        console.error('Error connecting to the database:', err);
        return;
    }
    console.log('Connected to the database');
});

app.post('/login', (req, res) => {
    const sql = "SELECT * FROM Account WHERE email = ? AND password = ?";

    db.query(sql, [req.body.email, req.body.password], (err, data) => {
        if (err) return res.json("Error");
        if (data.length > 0) {
            return res.json("Login Successfully");
        } else {
            return res.json("No Record");
        }
    });
});

app.post('/signup', (req, res) => {
    const { username, email, password, name, bankDetails } = req.body;
    // console.log(req.body);

    const sql = "INSERT INTO Account (username, email, password, name, iban) VALUES (?, ?, ?, ?, ?)";

    db.query(sql, [username, email, password, name, bankDetails], (err, data) => {
        if (err) {
            console.log(err)
            return res.json("Error inserting data into the database");
        }

        // Check if the insertion was successful
        if (data.affectedRows > 0) {
            return res.json("Registration Successful");
        } else {
            return res.json("Registration Failed");
        }
    });


});

app.post('/wallet', (req, res) => {
    const { userId } = req.body;

    const sql = "SELECT * FROM Wallet WHERE WalletId = ?";

    db.query(sql, [userId], (err, data) => {
        if (err) {
            console.error(err);
            return res.status(500).json({ error: "Error querying the database" });
        }

        if (data.length > 0) {
            return res.json({ data: data });
        } else {
            return res.json({ data: [] }); // Return an empty array if no data found
        }
    });
});


app.listen(8081, () => {
    console.log("Listening...");
});