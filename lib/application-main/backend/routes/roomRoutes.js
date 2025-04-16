const express = require("express");
const router = express.Router();
const Room = require("../models/Room");
const PopularStay = require("../models/PopularStay");
const OtherStay = require("../models/OtherStay");

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
 *             properties:
 *               name:
 *                 type: string
 *               description:
 *                 type: string
 *               price:
 *                 type: number
 *               capacity:
 *                 type: number
 *               amenities:
 *                 type: array
 *                 items:
 *                   type: string
 *               images:
 *                 type: array
 *                 items:
 *                   type: string
 *               availability:
 *                 type: boolean
 *               isPopular:
 *                 type: boolean
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

    const { name, price, isPopular, images } = req.body;

    if (isPopular) {
      const popularStay = new PopularStay({
        name,
        rating: 4.8,
        imageUrl: images?.[0] || ""
      });
      await popularStay.save();
    } else {
      const otherStay = new OtherStay({
        name,
        location: "Unknown",
        price: `$${price}/night`,
        rating: 4.2,
        imageUrl: images?.[0] || ""
      });
      await otherStay.save();
    }

    res.status(201).json(room);
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
});

/**
 * @swagger
 * /api/rooms:
 *   get:
 *     summary: Fetch all available rooms
 *     tags: [Rooms]
 *     responses:
 *       200:
 *         description: List of rooms
 *       500:
 *         description: Server error
 */
router.get("/", async (req, res) => {
  try {
    const rooms = await Room.find({}, "_id name price");
    res.status(200).json(rooms);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

module.exports = router;