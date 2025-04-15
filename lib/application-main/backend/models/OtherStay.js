const mongoose = require('mongoose');

const OtherStaySchema = new mongoose.Schema({
  name: { type: String, required: true },
  location: { type: String, required: true },
  price: { type: String },
  rating: { type: Number },
  imageUrl: { type: String, required: true }
});

module.exports = mongoose.model('OtherStay', OtherStaySchema);