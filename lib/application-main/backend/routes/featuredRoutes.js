const express = require('express');
const router = express.Router();
const FeaturedCard = require('../models/FeaturedCard');

/**
 * @swagger
 * /api/featured:
 *   get:
 *     summary: Get all featured cards
 *     tags: [Featured]
 *     responses:
 *       200:
 *         description: List of featured cards
 */
router.get('/', async (req, res) => {
  const cards = await FeaturedCard.find();
  res.json(cards);
});

/**
 * @swagger
 * /api/featured:
 *   post:
 *     summary: Add a new featured card
 *     tags: [Featured]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               title:
 *                 type: string
 *                 example: Discover the most popular places
 *               subtitle:
 *                 type: string
 *                  example:Explore Now
 *               imageUrl:
 *                 type: string
 *                  example:https://yourimageurl.com/popular.jpg
 *     responses:
 *       201:
 *         description: Featured card created
 */
router.post('/', async (req, res) => {
  const { title, subtitle, imageUrl } = req.body;
    try {
      const card = new FeaturedCard({
        title,
        subtitle,
        imageUrl
      }
      );
      await card.save();
      res.status(201).json(card);
    } catch (err) {
      res.status(400).json({ error: err.message });
    }
  });
  

module.exports = router;