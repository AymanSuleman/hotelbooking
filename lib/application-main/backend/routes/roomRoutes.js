

// module.exports = router;
const express = require("express");
const router = express.Router();
const Room = require("../models/Room");

/**
 * @swagger
 * tags:
 *   name: Rooms
 *   description: API endpoints for room management
 */

/**
 * @swagger
 * /api/rooms:
 *   post:
 *     summary: Add a new room
 *     tags: [Rooms]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - name
 *               - price
 *               - category
 *             properties:
 *               name:
 *                 type: string
 *               description:
 *                 type: string
 *               price:
 *                 type: number
 *               capacity:
 *                 type: number
 *               images:
 *                 type: array
 *                 items:
 *                   type: string
 *               availability:
 *                 type: boolean
 *               category:
 *                 type: string
 *                 enum: [Featured Cards, Popular Stays, Other Stays]
 *     responses:
 *       201:
 *         description: Room added successfully
 *       400:
 *         description: Invalid input data
 */
router.post("/", async (req, res) => {
  try {
    const room = new Room(req.body);
    await room.save();
    res.status(201).json(room);
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
});

/**
 * @swagger
 * /api/rooms/category/{category}:
 *   get:
 *     summary: Get rooms by category
 *     tags: [Rooms]
 *     parameters:
 *       - in: path
 *         name: category
 *         required: true
 *         schema:
 *           type: string
 *           enum: [Featured Cards, Popular Stays, Other Stays]
 *         description: The category of rooms to fetch
 *     responses:
 *       200:
 *         description: A list of rooms for the given category
 *       500:
 *         description: Server error
 */
router.get("/category/:category", async (req, res) => {
  try {
    const { category } = req.params;
    const rooms = await Room.find({ category });
    res.status(200).json(rooms);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});
// ✅ Get a single room by ID (this is what your Flutter code needs!)
router.get("/:id", async (req, res) => {
  try {
    const room = await Room.findById(req.params.id);
    if (!room) {
      return res.status(404).json({ message: "Room not found" });
    }
    res.status(200).json(room);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

module.exports = router;
