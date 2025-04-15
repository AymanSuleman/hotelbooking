const mongoose = require('mongoose');

const FeaturedCardSchema = new mongoose.Schema({
  title: { type: String, required: true },
  subtitle: { type: String },
  imageUrl: { type: String, required: true }
});

module.exports = mongoose.model('FeaturedCard', FeaturedCardSchema);