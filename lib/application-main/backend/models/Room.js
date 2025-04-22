
const mongoose = require("mongoose");

const roomSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
  },
  description: {
    type: String,
    required: true,
  },
  price: {
    type: Number,
    required: true,
  },
  capacity: {
    type: Number,
    required: true,
  },
  amenities: {
    type: [String], // Array of strings to store different amenities
    required: true,
  },
  images: {
    type: [String], // Array of strings to store URLs or paths to images
    required: true,
  },
  category: {
    type: String,
    enum: ['Featured Cards', 'Popular Stays', 'Other Stays'],
    required: true,
  },
  availability: {
    type: Boolean,
    required: true,
  },
  createdAt: {
    type: Date,
    default: Date.now,
  },
  updatedAt: {
    type: Date,
    default: Date.now,
  },
});

module.exports = mongoose.model("Room", roomSchema);
