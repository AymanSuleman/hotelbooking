const express = require('express');
const router = express.Router();
const PopularStay = require('../models/PopularStay');

/**
 * @swagger
 * /api/popular-stays:
 *   get:
 *     summary: Get all popular stays
 *     tags: [Popular]
 *     responses:
 *       200:
 *         description: List of popular stays
 */
router.get('/', async (req, res) => {
  try {
    const stays = await PopularStay.find();
    res.json(stays);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

/**
 * @swagger
 * /api/popular-stays:
 *   post:
 *     summary: Add a new popular stay
 *     tags: [Popular]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               name:
 *                 type: string
 *                 example: The Reefs
 *               rating:
 *                 type: number
 *                 example: 4.9
 *               imageUrl:
 *                 type: string
 *                 example: https://yourimageurl.com/reefs.jpg
 *     responses:
 *       201:
 *         description: Popular stay created
 */
router.post('/', async (req, res) => {
  try {
    const { name, rating, imageUrl } = req.body;

    const stay = new PopularStay({
      name,
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