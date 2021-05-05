import 'package:flutter/material.dart';

class Question {
  final String question;
  final List<String> options;
  final String rightanswer;
  final String pathImage;
  final String pathVideo;
  Question({
    @required this.question,
    @required this.options,
    @required this.rightanswer,
    this.pathImage,
    this.pathVideo,
  });
}

final List dataquestionseasy = [
  {
    "question": "Quantos pontos vale uma queda?",
    "options": ['2', '3', '4', '5'],
    "rightanswer": "2"
  },
  {
    "question": "Qual faixa vem antes da marrom?",
    "options": ['Roxa', 'Azul', 'Verde', 'Preta'],
    "rightanswer": "Roxa"
  },
  {
    "question": "Quem luta Jiu-Jitsu é denominado como?",
    "options": ['lutador', 'Jiujiteiro', 'Jiujitsuka', 'judoca'],
    "rightanswer": "Jiujitsuka"
  },
  {
    "question": "O que significa Jiu-jitsu?",
    "options": ['Arte suave', 'Arte da luta', 'Mãos vazias', 'Arte do combate'],
    "rightanswer": "Arte suave"
  },
  {
    "question": "Qual faixa vem depois da marrom?",
    "options": ['Roxa', 'Azul', 'Verde', 'Preta'],
    "rightanswer": "Preta"
  },
  {
    "question": "Em qual pais o jiu-jitsu teve origem?",
    "options": ['Japão', 'Brasil', 'India', 'Austrália'],
    "rightanswer": "India"
  },
  {
    "question": "Qual a ultima faixa do Jiu-Jitsu?",
    "options": ['Preta', 'Vermelha', 'Coral', 'Prata'],
    "rightanswer": "Vermelha"
  },
  {
    "question": "Qual família teve inicio no jiu-jitsu no brasil?",
    "options": [
      'Família Gracie',
      'Família Machida',
      'Família Fadda',
      'Família Machado'
    ],
    "rightanswer": "Família Gracie",
  },
  {
    "question": "Quantos pontos vale uma passagem de guarda?",
    "options": ['2', '3', '4', '5'],
    "rightanswer": "3",
  },
  {
    "question": "Qual o nome dessa finalização?",
    "options": ['Armlock', 'Kimura', 'Americana', 'Triângulo'],
    "rightanswer": "Armlock",
    "pathImage": "assets/images/quiz/quizArmllock.png"
  }
];

final List dataquestionsmedium = [
  {
    "question":
        "Qual lutador brasileiro que conseguiu ultrapassar Royce Gracie em finalizações no UFC?",
    "options": [
      'Conor McGregor',
      'Anderson Silva',
      'Charles do Bronx',
      'Demian Maia'
    ],
    "rightanswer": "Charles do Bronx"
  },
  {
    "question":
        "Qual o Nome do estilo de jiu jitsu cuja luta é feita sem kimono?",
    "options": ['Submission', 'Subjitsu', 'Jiu-Jitsu sem kimono', 'Absoluto'],
    "rightanswer": "Submission"
  },
  {
    "question": "Qual desses ataques é proibido na faixa azul?",
    "options": ['Chave de pé reta', 'Leg lock', 'kimura', 'Americana'],
    "rightanswer": "Leg lock"
  },
  {
    "question": "Qual desses é um dos criadores do UFC?",
    "options": [
      'Hélio Gracie',
      'Mitsuyo Maeda',
      'Oswaldo Fadda',
      'Rorion Gracie'
    ],
    "rightanswer": "Rorion Gracie"
  },
  {
    "question": "Qual a idade miníma para pegar a faixa preta?",
    "options": ['18', '19', '20', '21'],
    "rightanswer": "19"
  },
  {
    "question":
        "Qual desses movimentos é proibido no jiu-jitsu segundo as regras da CBJJ?",
    "options": [
      'Bate estaca',
      'Omoplata',
      'Chave de bíceps',
      'Chave de panturrilha'
    ],
    "rightanswer": "Bate estaca"
  },
];

final List dataquestionshard = [
  {
    "question": "Qual foi a primeira fámilia a desafiar a fámilia gracie?",
    "options": [
      'Família Almeida',
      'Família Machida',
      'Família Fadda',
      'Família Machado'
    ],
    "rightanswer": "Família Fadda"
  },
  {
    "question": "Qual ano que o jiu-jitsu chegou ao brasil?",
    "options": ['1914', '1913', '1915', '1910'],
    "rightanswer": "1914"
  },
  {
    "question": "Em qual ano a CBJJ foi fundada?",
    "options": ['1994', '1993', '1992', '1990'],
    "rightanswer": "1994"
  },
  {
    "question": "Qual foi a primeira mulher a pegar a faixa preta?",
    "options": [
      'Beatriz Mesquita',
      'Yvone Duarte',
      'Bianca Basílio',
      'kyra Graice'
    ],
    "rightanswer": "Yvone Duarte"
  },
  {
    "question": "Em que ano foi o primeiro mundial de Jiu-jitsu?",
    "options": ['1995', '1996', '1997', '1998'],
    "rightanswer": "1996"
  },
  {
    "question":
        "Em que ano foi o primeiro mundial de Jiu-jitsu fora do Brasil?",
    "options": ['2004', '2005', '2006', '2007'],
    "rightanswer": "2007"
  },
];
