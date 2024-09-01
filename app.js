const express = require('express');
const app = express();

app.get('/', (req, res) => {
    const currentTime = new Date().toISOString();
    res.json({ time: currentTime });
});

const port = process.env.PORT || 9792;
app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
});
