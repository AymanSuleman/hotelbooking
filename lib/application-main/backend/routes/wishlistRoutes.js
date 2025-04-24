const express = require("express");
const mongoose = require("mongoose");
const Wishlist = require("../models/Wishlist");
const Room = require("../models/Room");

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

    const room = await Room.findById(roomId); // ✅ Corrected this line
    if (!room) {
      return res.status(404).json({ error: 'Room not found' });
    }

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
router.get('/:userId', async (req, res) => {
  try {
    const { userId } = req.params;

    if (!mongoose.Types.ObjectId.isValid(userId)) {
      return res.status(400).json({ error: 'Invalid user ID' });
    }

    const wishlist = await Wishlist.find({ userId }).populate('roomId');
    res.json(wishlist);
  } catch (error) {
    console.error('Error fetching wishlist:', error);
    res.status(500).json({ error: 'Server error' });
  }
});

/**
 * @swagger
 * /api/wishlist:
 *   delete:
 *     summary: Remove a room from the user's wishlist
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
 *               roomId:
 *                 type: string
 *     responses:
 *       200:
 *         description: Room removed from wishlist
 *       404:
 *         description: Wishlist item not found
 */
router.delete('/', async (req, res) => {
  try {
    const { userId, roomId } = req.body;

    if (!userId || !roomId) {
      return res.status(400).json({ error: 'Missing userId or roomId' });
    }

    const result = await Wishlist.findOneAndDelete({ userId, roomId });

    if (!result) {
      return res.status(404).json({ error: 'Wishlist item not found' });
    }

    res.status(200).json({ message: 'Removed from wishlist' });
  } catch (error) {
    console.error('Delete error:', error);
    res.status(500).json({ error: 'Server error' });
  }
});

module.exports = router;









