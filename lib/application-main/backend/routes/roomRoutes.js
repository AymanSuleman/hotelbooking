// const express = require("express");
// const mongoose = require("mongoose");
// const router = express.Router();
// const Room = require("../models/Room");
// const PopularStay = require("../models/PopularStay");
// const OtherStay = require("../models/OtherStay");

// /**
//  * @swagger
//  * tags:
//  *   name: Rooms
//  *   description: API endpoints for room management
//  */

// /**
//  * @swagger
//  * /api/rooms:
//  *   post:
//  *     summary: Add a new room
//  *     tags: [Rooms]
//  *     requestBody:
//  *       required: true
//  *       content:
//  *         application/json:
//  *           schema:
//  *             type: object
//  *             required:
//  *               - name
//  *               - price
//  *               - category
//  *             properties:
//  *               name:
//  *                 type: string
//  *               description:
//  *                 type: string
//  *               price:
//  *                 type: number
//  *               capacity:
//  *                 type: number
//  *               
//  *               images:
//  *                 type: array
//  *                 items:
//  *                   type: string
//  *               availability:
//  *                 type: boolean
//  *               category:
//  *                 type: string
//  *                 enum: [Featured Cards, Popular Stays, Other Stays]
//  *     responses:
//  *       201:
//  *         description: Room added successfully
//  *       400:
//  *         description: Invalid input data
//  */
// router.post("/", async (req, res) => {
//   try {
//     const { name, price, images, category } = req.body;

//     const room = new Room({
//       ...req.body,
//       category
//     });

//     await room.save();

//     if (category === "Popular Stays") {
//       const popularStay = new PopularStay({
//         name,
//         rating: 4.8,
//         imageUrl: images?.[0] || ""
//       });
//       await popularStay.save();
//     } else if (category === "Other Stays") {
//       const otherStay = new OtherStay({
//         name,
//         location: "Unknown",
//         price: `$${price}/night`,
//         rating: 4.2,
//         imageUrl: images?.[0] || ""
//       });
//       await otherStay.save();
//     }

//     res.status(201).json(room);
//   } catch (error) {
//     res.status(400).json({ message: error.message });
//   }
// });

// /**
//  * @swagger
//  * /api/rooms:
//  *   get:
//  *     summary: Fetch all available rooms
//  *     tags: [Rooms]
//  *     responses:
//  *       200:
//  *         description: List of rooms
//  *       500:
//  *         description: Server error
//  */
// router.get("/", async (req, res) => {
//   try {
//     const rooms = await Room.find({}, "_id name price");
//     res.status(200).json(rooms);
//   } catch (error) {
//     res.status(500).json({ message: error.message });
//   }
// });

// /**
//  * @swagger
//  * /api/rooms/category/{category}:
//  *   get:
//  *     summary: Get rooms by category
//  *     tags: [Rooms]
//  *     parameters:
//  *       - in: path
//  *         name: category
//  *         required: true
//  *         schema:
//  *           type: string
//  *           enum: [Featured Cards, Popular Stays, Other Stays]
//  *         description: The category of rooms to fetch
//  *     responses:
//  *       200:
//  *         description: A list of rooms for the given category
//  *       500:
//  *         description: Server error
//  */
// router.get("/category/:category", async (req, res) => {
//   try {
//     const { category } = req.params;
//     const rooms = await Room.find({ category });
//     res.status(200).json(rooms);
//   } catch (error) {
//     res.status(500).json({ message: error.message });
//   }
// });

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
router.get("/category/:category/:id", async (req, res) => {
  try {
    const { category } = req.params;
    const rooms = await Room.find({ category });
    res.status(200).json(rooms);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

module.exports = router;
