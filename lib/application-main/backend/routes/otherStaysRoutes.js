const express = require('express');
const router = express.Router();
const OtherStay = require('../models/OtherStay');

/**
 * @swagger
 * /api/other-stays:
 *   get:
 *     summary: Get all other stays
 *     tags: [Other]
 *     responses:
 *       200:
 *         description: List of other stays
 */
router.get('/', async (req, res) => {
  try {
    const stays = await OtherStay.find();
    res.json(stays);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

/**
 * @swagger
 * /api/other-stays:
 *   post:
 *     summary: Add a new other stay
 *     tags: [Other]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               name:
 *                 type: string
 *                 example: Mountain Breeze
 *               location:
 *                 type: string
 *                 example: Colorado
 *               price:
 *                 type: string
 *                 example: $120/night
 *               rating:
 *                 type: number
 *                 example: 4.6
 *               imageUrl:
 *                 type: string
 *                 example: https://yourimageurl.com/mountain.jpg
 *     responses:
 *       201:
 *         description: Other stay created
 */
router.post('/', async (req, res) => {
  try {
    const { name, location, price, rating, imageUrl } = req.body;

    const stay = new OtherStay({
      name,
      location,
      price,
      rating,
      imageUrl
    });

    await stay.save();
    res.status(201).json(stay);
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
});

module.exports = router;