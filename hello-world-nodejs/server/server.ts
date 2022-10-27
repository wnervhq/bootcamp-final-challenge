import express from "express";
// Create a new express app instance
const port = parseInt(process.env.PORT || '3000');
const app: express.Application = express();
app.get("/hello", function (req, res) {
  res.send("Hello World!");
});
app.listen(port, "0.0.0.0", function () {
  console.log(`App is listening on port ${port}!`);
});