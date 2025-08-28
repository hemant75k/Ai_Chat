import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppConstant{
  static final List<Map<String, dynamic>> defaultQues = [
    {
    "tittle" : "Most Popular",
    "questions" : [
      {
        "icon": Icons.ac_unit,
        'color': Colors.primaries[Random().nextInt(Colors.primaries.length)],
        "question": "What is Ai"
      },
      {
        "icon": Icons.emoji_emotions_rounded,
        'color': Colors.primaries[Random().nextInt(Colors.primaries.length -1)],
        "question": "Tell me a jock"
      },
      {
        "icon": Icons.computer,
        'color': Colors.primaries[Random().nextInt(Colors.primaries.length -1)],
        "question": "Explain me the concept of computer"
      },
      {
        "icon": Icons.cloud,
        'color': Colors.primaries[Random().nextInt(Colors.primaries.length -1)],
        "question": "Tell me about the weather"
      },
    ]
    },
    {
      "tittle" : "Trending",
      "questions" : [
        {
          "icon": Icons.question_mark,
          'color': Colors.primaries[Random().nextInt(Colors.primaries.length -1)],
          "question": "Explain me the theory of relativity im simple"
        },
        {
          "icon": Icons.swap_horizontal_circle_outlined,
          'color': Colors.primaries[Random().nextInt(Colors.primaries.length -1)],
          "question": "What is blockchain technology"
        },
        {
          "icon": Icons.equalizer,
          'color': Colors.primaries[Random().nextInt(Colors.primaries.length -1)],
          "question": "Tell me about the future of AI"
        },
      ]
    },
    {
      "tittle" : "Instagram",
      "questions" : [
        {
          "icon": Icons.trending_up_rounded,
          'color': Colors.primaries[Random().nextInt(Colors.primaries.length -1)],
          "question": "What are the latest trends in instagram"
        },
        {
          "icon": Icons.align_horizontal_center,
          'color': Colors.primaries[Random().nextInt(Colors.primaries.length -1)],
          "question": "How does the Instagram app work"
        },
        {
          "icon": Icons.video_collection,
          'color': Colors.primaries[Random().nextInt(Colors.primaries.length -1)],
          "question": "How can i make a video on instagram"
        },
        {
          "icon": Icons.monetization_on_outlined,
          'color': Colors.primaries[Random().nextInt(Colors.primaries.length -1)],
          "question": "How do i make money on instagram"
        },
      ]
    }
  ];
}