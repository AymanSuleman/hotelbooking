const express = require("express");
const mongoose = require("mongoose");
const Wishlist = require("../models/Wishlist");
const Room = require("../models/Room");
// const PopularStay = require("../models/PopularStay"); // Import Room Model

const router = express.Router();

/**
 * @swagger
 * /api/wishlist:
 *   post:
 *     summary: Add a room to the user's wishlist
 *     tags: [User Preferences]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               userId:
 *                 type: string
 *                 description: User's MongoDB ID
 *               roomId:
 *                 type: string
 *                 description: Room's MongoDB ID
 *     responses:
 *       201:
 *         description: Room added to wishlist
 *       400:
 *         description: Invalid userId or roomId
 */
router.post('/', async (req, res) => {
  try {
    const { userId, roomId } = req.body;

    // ✅ Use PopularStay model to check room
    const room = await PopularStay.findById(roomId);
    if (!room) {
      return res.status(404).json({ error: 'Room not found' });
    }

    // ✅ Check if already added
    const existing = await Wishlist.findOne({ userId, roomId });
    if (existing) {
      return res.status(400).json({ error: 'Already in wishlist' });
    }

    const wishlist = new Wishlist({ userId, roomId });
    await wishlist.save();
    res.status(201).json({ message: 'Added to wishlist' });
  } catch (error) {
    console.error('Error adding to wishlist:', error);
    res.status(500).json({ error: 'Server error' });
  }
});

/**
 * @swagger
 * /api/wishlist/{userId}:
 *   get:
 *     summary: Get wishlist of a user
 *     tags: [User Preferences]
 *     parameters:
 *       - in: path
 *         name: userId
 *         required: true
 *         schema:
 *           type: string
 *         description: User's MongoDB ID
 *     responses:
 *       200:
 *         description: User's wishlist fetched successfully
 *       400:
 *         description: Invalid userId
 */


// Get wishlist by userId
router.get('/:userId', async (req, res) => {
  try {
    const { userId } = req.params;
    const wishlist = await Wishlist.find({ userId }).populate('roomId');
    res.json(wishlist);
  } catch (error) {
    console.error('Error fetching wishlist:', error);
    res.status(500).json({ error: 'Server error' });
  }
});

module.exports = router;