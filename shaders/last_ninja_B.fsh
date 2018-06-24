// ---------------------------
//  HUD and other UI elements
// ---------------------------

// ninja health indicator
void Health(inout vec3 color, vec2 p)
{
    uint v = 0u;
    v = p.y == 29. ? (p.x < 16. ? 1431655765u : (p.x < 32. ? 1431655765u : (p.x < 48. ? 1431655765u : 89478485u))) : v;
    v = p.y == 28. ? (p.x < 16. ? 1431655765u : (p.x < 32. ? 1431655765u : (p.x < 48. ? 1431655765u : 89478485u))) : v;
    v = p.y == 27. ? (p.x < 16. ? 2863291045u : (p.x < 32. ? 2863291050u : (p.x < 48. ? 2863291050u : 95050410u))) : v;
    v = p.y == 26. ? (p.x < 16. ? 1521134245u : (p.x < 32. ? 1521134250u : (p.x < 48. ? 1521134250u : 95070890u))) : v;
    v = p.y == 25. ? (p.x < 16. ? 1431655845u : (p.x < 32. ? 1431655765u : (p.x < 48. ? 1431655765u : 94721365u))) : v;
    v = p.y == 24. ? (p.x < 16. ? 1431655845u : (p.x < 32. ? 1431655765u : (p.x < 48. ? 1431655765u : 94721365u))) : v;
    v = p.y == 23. ? (p.x < 16. ? 1445u : (p.x < 32. ? 0u : (p.x < 48. ? 0u : 94699520u))) : v;
    v = p.y == 22. ? (p.x < 16. ? 1445u : (p.x < 32. ? 0u : (p.x < 48. ? 0u : 94699520u))) : v;
    v = p.y == 21. ? (p.x < 16. ? 1431635365u : (p.x < 32. ? 89478485u : (p.x < 48. ? 1431655765u : 94700885u))) : v;
    v = p.y == 20. ? (p.x < 16. ? 1431635365u : (p.x < 32. ? 89478485u : (p.x < 48. ? 1431655765u : 94700885u))) : v;
    v = p.y == 19. ? (p.x < 16. ? 2862941605u : (p.x < 32. ? 95050410u : (p.x < 48. ? 2863291045u : 94700970u))) : v;
    v = p.y == 18. ? (p.x < 16. ? 1520764325u : (p.x < 32. ? 95070890u : (p.x < 48. ? 1521134245u : 94700970u))) : v;
    v = p.y == 17. ? (p.x < 16. ? 1436878245u : (p.x < 32. ? 94721365u : (p.x < 48. ? 1431655845u : 94700965u))) : v;
    v = p.y == 16. ? (p.x < 16. ? 1436878245u : (p.x < 32. ? 94721365u : (p.x < 48. ? 1431655845u : 94700965u))) : v;
    v = p.y == 15. ? (p.x < 16. ? 94700965u : (p.x < 32. ? 94699520u : (p.x < 48. ? 1445u : 94700965u))) : v;
    v = p.y == 14. ? (p.x < 16. ? 94700965u : (p.x < 32. ? 94699520u : (p.x < 48. ? 1445u : 94700965u))) : v;
    v = p.y == 13. ? (p.x < 16. ? 94700965u : (p.x < 32. ? 94700885u : (p.x < 48. ? 89458085u : 94700965u))) : v;
    v = p.y == 12. ? (p.x < 16. ? 1436878245u : (p.x < 32. ? 94700885u : (p.x < 48. ? 1431635365u : 94700965u))) : v;
    v = p.y == 11. ? (p.x < 16. ? 1520764325u : (p.x < 32. ? 94700970u : (p.x < 48. ? 1520764325u : 94700970u))) : v;
    v = p.y == 10. ? (p.x < 16. ? 2862941605u : (p.x < 32. ? 94700970u : (p.x < 48. ? 2862941605u : 94700970u))) : v;
    v = p.y == 9. ? (p.x < 16. ? 1431635365u : (p.x < 32. ? 94700885u : (p.x < 48. ? 1431635365u : 94700885u))) : v;
    v = p.y == 8. ? (p.x < 16. ? 1431635365u : (p.x < 32. ? 94700885u : (p.x < 48. ? 1431635365u : 94700885u))) : v;
    v = p.y == 7. ? (p.x < 16. ? 1445u : (p.x < 32. ? 94699520u : (p.x < 48. ? 1445u : 94699520u))) : v;
    v = p.y == 6. ? (p.x < 16. ? 1445u : (p.x < 32. ? 94699520u : (p.x < 48. ? 1445u : 94699520u))) : v;
    v = p.y == 5. ? (p.x < 16. ? 1431655845u : (p.x < 32. ? 94721365u : (p.x < 48. ? 1431655845u : 94721365u))) : v;
    v = p.y == 4. ? (p.x < 16. ? 1431655845u : (p.x < 32. ? 94721365u : (p.x < 48. ? 1431655845u : 94721365u))) : v;
    v = p.y == 3. ? (p.x < 16. ? 1521134245u : (p.x < 32. ? 95070890u : (p.x < 48. ? 1521134245u : 95070890u))) : v;
    v = p.y == 2. ? (p.x < 16. ? 2863291045u : (p.x < 32. ? 95050410u : (p.x < 48. ? 2863291045u : 95050410u))) : v;
    v = p.y == 1. ? (p.x < 16. ? 1431655765u : (p.x < 32. ? 89478485u : (p.x < 48. ? 1431655765u : 89478485u))) : v;
    v = p.y == 0. ? (p.x < 16. ? 1431655765u : (p.x < 32. ? 89478485u : (p.x < 48. ? 1431655765u : 89478485u))) : v;
    v = p.x >= 0. && p.x < 62. ? v : 0u;

    float i = float((v >> uint(2. * p.x)) & 3u);
    color = i == 1. ? vec3(0.76, 0.51, 0.47) : color;
    color = i == 2. ? vec3(1) : color;
}

// "Power" text
void Power(inout vec3 color, vec2 p)
{
    uint v = 0u;
    v = p.y == 5. ? (p.x < 8. ? 1999831040u : (p.x < 16. ? 1145337719u : (p.x < 24. ? 2000962679u : (p.x < 32. ? 2000945152u : (p.x < 40. ? 2004318020u : (p.x < 48. ? 2004318020u : 0u)))))) : v;
    v = p.y == 4. ? (p.x < 8. ? 1996488704u : (p.x < 16. ? 1996519185u : (p.x < 24. ? 1996519185u : (p.x < 32. ? 1996488704u : (p.x < 40. ? 30464u : (p.x < 48. ? 1997633280u : 0u)))))) : v;
    v = p.y == 3. ? (p.x < 8. ? 1996488704u : (p.x < 16. ? 1996506231u : (p.x < 24. ? 1996519185u : (p.x < 32. ? 1996488704u : (p.x < 40. ? 7829248u : (p.x < 48. ? 578254592u : 0u)))))) : v;
    v = p.y == 2. ? (p.x < 8. ? 1996488772u : (p.x < 16. ? 1996488704u : (p.x < 24. ? 1996519185u : (p.x < 32. ? 2000975684u : (p.x < 40. ? 30464u : (p.x < 48. ? 1996519168u : 1996488704u)))))) : v;
    v = p.y == 1. ? (p.x < 8. ? 1996488704u : (p.x < 16. ? 1996488704u : (p.x < 24. ? 1996519185u : (p.x < 32. ? 2004287607u : (p.x < 40. ? 1140881152u : (p.x < 48. ? 1996519168u : 0u)))))) : v;
    v = p.y == 0. ? (p.x < 8. ? 2002059264u : (p.x < 16. ? 1140850688u : (p.x < 24. ? 1996506231u : (p.x < 32. ? 2000945220u : (p.x < 40. ? 2004317952u : (p.x < 48. ? 1996519168u : 26231u)))))) : v;
    v = p.x >= 0. && p.x < 56. ? v : 0u;

    float i = float((v >> uint(4. * p.x)) & 15u);
    color = i == 1. ? vec3(0) : color;
    color = i == 2. ? vec3(0.34) : color;
    color = i == 3. ? vec3(0.35) : color;
    color = i == 4. ? vec3(0.38) : color;
    color = i == 5. ? vec3(0.44) : color;
    color = i == 6. ? vec3(0.48) : color;
    color = i == 7. ? vec3(0.7) : color;
}

// Ninja weapons
void Weapons(inout vec3 color, vec2 p)
{
    uint v = 0u;
    v = p.y == 28. ? (p.x < 8. ? 0u : (p.x < 16. ? 0u : (p.x < 24. ? 0u : (p.x < 32. ? 0u : (p.x < 40. ? 0u : (p.x < 48. ? 0u : (p.x < 56. ? 0u : (p.x < 64. ? 85u : 0u)))))))) : v;
    v = p.y == 27. ? (p.x < 8. ? 0u : (p.x < 16. ? 0u : (p.x < 24. ? 0u : (p.x < 32. ? 0u : (p.x < 40. ? 0u : (p.x < 48. ? 0u : (p.x < 56. ? 0u : (p.x < 64. ? 21760u : 0u)))))))) : v;
    v = p.y == 26. ? (p.x < 8. ? 0u : (p.x < 16. ? 0u : (p.x < 24. ? 0u : (p.x < 32. ? 0u : (p.x < 40. ? 0u : (p.x < 48. ? 0u : (p.x < 56. ? 0u : (p.x < 64. ? 21760u : 0u)))))))) : v;
    v = p.y == 25. ? (p.x < 8. ? 0u : (p.x < 16. ? 855638016u : (p.x < 24. ? 2290649224u : (p.x < 32. ? 2290649224u : (p.x < 40. ? 2290649224u : (p.x < 48. ? 2290649224u : (p.x < 56. ? 1435011208u : (p.x < 64. ? 2002081109u : (p.x < 72. ? 1999861555u : (p.x < 80. ? 51u : 0u)))))))))) : v;
    v = p.y == 24. ? (p.x < 8. ? 0u : (p.x < 16. ? 0u : (p.x < 24. ? 858993408u : (p.x < 32. ? 858993459u : (p.x < 40. ? 858993459u : (p.x < 48. ? 858993459u : (p.x < 56. ? 858993459u : (p.x < 64. ? 855659776u : (p.x < 72. ? 858993459u : (p.x < 80. ? 51u : 0u)))))))))) : v;
    v = p.y == 23. ? (p.x < 8. ? 0u : (p.x < 16. ? 0u : (p.x < 24. ? 0u : (p.x < 32. ? 0u : (p.x < 40. ? 0u : (p.x < 48. ? 0u : (p.x < 56. ? 0u : (p.x < 64. ? 21760u : 0u)))))))) : v;
    v = p.y == 22. ? (p.x < 8. ? 0u : (p.x < 16. ? 0u : (p.x < 24. ? 0u : (p.x < 32. ? 0u : (p.x < 40. ? 0u : (p.x < 48. ? 0u : (p.x < 56. ? 0u : (p.x < 64. ? 5570560u : 0u)))))))) : v;
    v = p.y == 21. ? 0u : v;
    v = p.y == 20. ? (p.x < 8. ? 0u : (p.x < 16. ? 2004317952u : (p.x < 24. ? 51u : (p.x < 32. ? 0u : (p.x < 40. ? 0u : (p.x < 48. ? 8704u : (p.x < 56. ? 0u : (p.x < 64. ? 0u : (p.x < 72. ? 0u : (p.x < 80. ? 0u : (p.x < 88. ? 7798784u : 0u))))))))))) : v;
    v = p.y == 19. ? (p.x < 8. ? 0u : (p.x < 16. ? 2004318071u : (p.x < 24. ? 13056u : (p.x < 32. ? 0u : (p.x < 40. ? 0u : (p.x < 48. ? 30464u : (p.x < 56. ? 0u : (p.x < 64. ? 0u : (p.x < 72. ? 0u : (p.x < 80. ? 119u : (p.x < 88. ? 1140850688u : 17u))))))))))) : v;
    v = p.y == 18. ? (p.x < 8. ? 1996488704u : (p.x < 16. ? 863467383u : (p.x < 24. ? 3342336u : (p.x < 32. ? 0u : (p.x < 40. ? 0u : (p.x < 48. ? 2258688u : (p.x < 56. ? 0u : (p.x < 64. ? 0u : (p.x < 72. ? 289669120u : (p.x < 80. ? 0u : (p.x < 88. ? 1140881152u : 17u))))))))))) : v;
    v = p.y == 17. ? (p.x < 8. ? 1996488704u : (p.x < 16. ? 2005436535u : (p.x < 24. ? 0u : (p.x < 32. ? 0u : (p.x < 40. ? 0u : (p.x < 48. ? 2236928u : (p.x < 56. ? 0u : (p.x < 64. ? 0u : (p.x < 72. ? 289669120u : (p.x < 80. ? 30464u : (p.x < 88. ? 1140850688u : 17u))))))))))) : v;
    v = p.y == 16. ? (p.x < 8. ? 2004287488u : (p.x < 16. ? 8947831u : (p.x < 24. ? 0u : (p.x < 32. ? 0u : (p.x < 40. ? 0u : (p.x < 48. ? 7829248u : (p.x < 56. ? 0u : (p.x < 64. ? 0u : (p.x < 72. ? 289669120u : (p.x < 80. ? 0u : (p.x < 88. ? 1140881152u : 4369u))))))))))) : v;
    v = p.y == 15. ? (p.x < 8. ? 2004287488u : (p.x < 16. ? 7833736u : (p.x < 24. ? 0u : (p.x < 32. ? 0u : (p.x < 40. ? 0u : (p.x < 48. ? 7829248u : (p.x < 56. ? 2228224u : (p.x < 64. ? 0u : (p.x < 72. ? 1131520u : (p.x < 80. ? 7798784u : (p.x < 88. ? 0u : 4420u))))))))))) : v;
    v = p.y == 14. ? (p.x < 8. ? 2004287488u : (p.x < 16. ? 30600u : (p.x < 24. ? 855638016u : (p.x < 32. ? 0u : (p.x < 40. ? 570425344u : (p.x < 48. ? 572662391u : (p.x < 56. ? 6710886u : (p.x < 64. ? 0u : (p.x < 72. ? 1131520u : (p.x < 80. ? 0u : (p.x < 88. ? 119u : 4420u))))))))))) : v;
    v = p.y == 13. ? (p.x < 8. ? 2004287488u : (p.x < 16. ? 30600u : (p.x < 24. ? 855651072u : (p.x < 32. ? 0u : (p.x < 40. ? 1998716928u : (p.x < 48. ? 572662391u : (p.x < 56. ? 26214u : (p.x < 64. ? 0u : (p.x < 72. ? 1131520u : (p.x < 80. ? 0u : (p.x < 88. ? 0u : 4420u))))))))))) : v;
    v = p.y == 12. ? (p.x < 8. ? 2004287488u : (p.x < 16. ? 119u : (p.x < 24. ? 855638016u : (p.x < 32. ? 0u : (p.x < 40. ? 2004317952u : (p.x < 48. ? 1998725751u : (p.x < 56. ? 102u : (p.x < 64. ? 0u : (p.x < 72. ? 1131520u : (p.x < 80. ? 0u : (p.x < 88. ? 0u : 1118532u))))))))))) : v;
    v = p.y == 11. ? (p.x < 8. ? 2004287488u : (p.x < 16. ? 13107u : (p.x < 24. ? 855638067u : (p.x < 32. ? 0u : (p.x < 40. ? 8704u : (p.x < 48. ? 7829248u : (p.x < 56. ? 0u : (p.x < 64. ? 0u : (p.x < 72. ? 1131520u : (p.x < 80. ? 0u : (p.x < 88. ? 0u : 1131520u))))))))))) : v;
    v = p.y == 10. ? (p.x < 8. ? 1999831040u : (p.x < 16. ? 119u : (p.x < 24. ? 51u : (p.x < 32. ? 0u : (p.x < 40. ? 0u : (p.x < 48. ? 7829248u : (p.x < 56. ? 0u : (p.x < 64. ? 0u : (p.x < 72. ? 4420u : (p.x < 80. ? 0u : (p.x < 88. ? 0u : 1131520u))))))))))) : v;
    v = p.y == 9. ? (p.x < 8. ? 1996488704u : (p.x < 16. ? 855638135u : (p.x < 24. ? 0u : (p.x < 32. ? 0u : (p.x < 40. ? 0u : (p.x < 48. ? 7829248u : (p.x < 56. ? 0u : (p.x < 64. ? 0u : (p.x < 72. ? 4420u : (p.x < 80. ? 0u : (p.x < 88. ? 0u : 1131520u))))))))))) : v;
    v = p.y == 8. ? (p.x < 8. ? 855638016u : (p.x < 16. ? 119u : (p.x < 24. ? 0u : (p.x < 32. ? 0u : (p.x < 40. ? 0u : (p.x < 48. ? 7807488u : (p.x < 56. ? 0u : (p.x < 64. ? 0u : (p.x < 72. ? 4420u : (p.x < 80. ? 0u : (p.x < 88. ? 0u : 1131520u))))))))))) : v;
    v = p.y == 7. ? (p.x < 8. ? 0u : (p.x < 16. ? 119u : (p.x < 24. ? 3342336u : (p.x < 32. ? 0u : (p.x < 40. ? 0u : (p.x < 48. ? 7798784u : (p.x < 56. ? 0u : (p.x < 64. ? 0u : (p.x < 72. ? 4420u : (p.x < 80. ? 0u : (p.x < 88. ? 0u : 1131520u))))))))))) : v;
    v = p.y == 6. ? (p.x < 8. ? 0u : (p.x < 16. ? 13056u : (p.x < 24. ? 13056u : (p.x < 32. ? 0u : (p.x < 40. ? 0u : (p.x < 48. ? 2228224u : (p.x < 56. ? 0u : (p.x < 64. ? 0u : (p.x < 72. ? 4420u : 0u))))))))) : v;
    v = p.y == 5. ? (p.x < 8. ? 0u : (p.x < 16. ? 858980352u : 0u)) : v;
    v = p.y == 4. ? 0u : v;
    v = p.y == 3. ? 0u : v;
    v = p.y == 2. ? (p.x < 8. ? 1145324612u : (p.x < 16. ? 1144210500u : (p.x < 24. ? 1145324612u : (p.x < 32. ? 1145324595u : (p.x < 40. ? 860111940u : (p.x < 48. ? 1145324612u : (p.x < 56. ? 860111940u : (p.x < 64. ? 1145324612u : (p.x < 72. ? 1145324612u : (p.x < 80. ? 1145320260u : (p.x < 88. ? 1145324612u : 4473924u))))))))))) : v;
    v = p.y == 1. ? (p.x < 8. ? 1145324612u : (p.x < 16. ? 1144210500u : (p.x < 24. ? 1145324612u : (p.x < 32. ? 1145324595u : (p.x < 40. ? 860111940u : (p.x < 48. ? 1145324612u : (p.x < 56. ? 860111940u : (p.x < 64. ? 1145324612u : (p.x < 72. ? 1145324612u : (p.x < 80. ? 1145320260u : (p.x < 88. ? 1145324612u : 4473924u))))))))))) : v;
    v = p.y == 0. ? (p.x < 8. ? 858993459u : (p.x < 16. ? 855651123u : (p.x < 24. ? 858993459u : (p.x < 32. ? 858993408u : (p.x < 40. ? 3355443u : (p.x < 48. ? 858993459u : (p.x < 56. ? 3355443u : (p.x < 64. ? 858993459u : (p.x < 72. ? 858993459u : (p.x < 80. ? 858980403u : (p.x < 88. ? 858993459u : 3355443u))))))))))) : v;
    v = p.x >= 0. && p.x < 94. ? v : 0u;

    float i = float((v >> uint(4. * p.x)) & 15u);
    color = i == 1. ? vec3(0.4, 0.32, 0) : color;
    color = i == 2. ? vec3(0.57, 0.29, 0.25) : color;
    color = i == 3. ? vec3(0.38) : color;
    color = i == 4. ? vec3(0.6, 0.41, 0.18) : color;
    color = i == 5. ? vec3(0.54) : color;
    color = i == 6. ? vec3(0.76, 0.51, 0.47) : color;
    color = i == 7. ? vec3(0.7) : color;
    color = i == 8. ? vec3(1) : color;
}

// "Weaponry" text
void Weaponry(inout vec3 color, vec2 p)
{
    uint v = 0u;
    v = p.y == 5. ? (p.x < 8. ? 1999831040u : (p.x < 16. ? 2004287488u : (p.x < 24. ? 2004318020u : (p.x < 32. ? 1148666880u : (p.x < 40. ? 1719105399u : (p.x < 48. ? 1148671232u : (p.x < 56. ? 1148680004u : (p.x < 64. ? 1148680004u : (p.x < 72. ? 1997633280u : 0u))))))))) : v;
    v = p.y == 4. ? (p.x < 8. ? 1996488704u : (p.x < 16. ? 1996488704u : (p.x < 24. ? 30481u : (p.x < 32. ? 1997633280u : (p.x < 40. ? 1997633297u : (p.x < 48. ? 1997633280u : (p.x < 56. ? 1997633297u : (p.x < 64. ? 1997633297u : (p.x < 72. ? 1997633280u : 0u))))))))) : v;
    v = p.y == 3. ? (p.x < 8. ? 1996488704u : (p.x < 16. ? 1996488704u : (p.x < 24. ? 7829316u : (p.x < 32. ? 2004317952u : (p.x < 40. ? 1148679953u : (p.x < 48. ? 1997633280u : (p.x < 56. ? 1997633297u : (p.x < 64. ? 7829265u : (p.x < 72. ? 1997633280u : 0u))))))))) : v;
    v = p.y == 2. ? (p.x < 8. ? 1996488823u : (p.x < 16. ? 2000975684u : (p.x < 24. ? 30481u : (p.x < 32. ? 1997633280u : (p.x < 40. ? 30481u : (p.x < 48. ? 1997633280u : (p.x < 56. ? 1997633297u : (p.x < 64. ? 1997633297u : (p.x < 72. ? 578241536u : 7798784u))))))))) : v;
    v = p.y == 1. ? (p.x < 8. ? 1996488704u : (p.x < 16. ? 2004291959u : (p.x < 24. ? 1140881169u : (p.x < 32. ? 1997633280u : (p.x < 40. ? 30481u : (p.x < 48. ? 1997633280u : (p.x < 56. ? 1997633297u : (p.x < 64. ? 1997633297u : (p.x < 72. ? 7798784u : 0u))))))))) : v;
    v = p.y == 0. ? (p.x < 8. ? 1996488704u : (p.x < 16. ? 2000949572u : (p.x < 24. ? 2004318020u : (p.x < 32. ? 1997633280u : (p.x < 40. ? 30532u : (p.x < 48. ? 1148666880u : (p.x < 56. ? 1997633297u : (p.x < 64. ? 1997633348u : (p.x < 72. ? 7816192u : 0u))))))))) : v;
    v = p.x >= 0. && p.x < 78. ? v : 0u;

    float i = float((v >> uint(4. * p.x)) & 15u);
    color = i == 1. ? vec3(0) : color;
    color = i == 2. ? vec3(0.35) : color;
    color = i == 3. ? vec3(0.36) : color;
    color = i == 4. ? vec3(0.38) : color;
    color = i == 5. ? vec3(0.44) : color;
    color = i == 6. ? vec3(0.51) : color;
    color = i == 7. ? vec3(0.7) : color;
}

// "The Last Ninja" bottom right sprite
void TheLastNinja(inout vec3 color, vec2 p)
{
    uint v = 0u;
    v = p.y == 51. ? (p.x < 8. ? 0u : (p.x < 16. ? 0u : (p.x < 24. ? 0u : (p.x < 32. ? 0u : (p.x < 40. ? 0u : (p.x < 48. ? 0u : (p.x < 56. ? 0u : (p.x < 64. ? 0u : (p.x < 72. ? 1114112u : 0u))))))))) : v;
    v = p.y == 50. ? (p.x < 8. ? 0u : (p.x < 16. ? 0u : (p.x < 24. ? 0u : (p.x < 32. ? 0u : (p.x < 40. ? 0u : (p.x < 48. ? 0u : (p.x < 56. ? 0u : (p.x < 64. ? 0u : (p.x < 72. ? 3342336u : 0u))))))))) : v;
    v = p.y == 49. ? (p.x < 8. ? 0u : (p.x < 16. ? 0u : (p.x < 24. ? 0u : (p.x < 32. ? 0u : (p.x < 40. ? 2004318003u : (p.x < 48. ? 2004318071u : (p.x < 56. ? 2004318071u : (p.x < 64. ? 2004318071u : (p.x < 72. ? 858980403u : (p.x < 80. ? 2004287607u : 51u)))))))))) : v;
    v = p.y == 48. ? (p.x < 8. ? 0u : (p.x < 16. ? 0u : (p.x < 24. ? 0u : (p.x < 32. ? 0u : (p.x < 40. ? 0u : (p.x < 48. ? 0u : (p.x < 56. ? 0u : (p.x < 64. ? 0u : (p.x < 72. ? 1999831040u : (p.x < 80. ? 856765235u : 51u)))))))))) : v;
    v = p.y == 47. ? (p.x < 8. ? 0u : (p.x < 16. ? 0u : (p.x < 24. ? 0u : (p.x < 32. ? 0u : (p.x < 40. ? 0u : (p.x < 48. ? 0u : (p.x < 56. ? 0u : (p.x < 64. ? 1431633920u : (p.x < 72. ? 3342387u : (p.x < 80. ? 3364181u : 0u)))))))))) : v;
    v = p.y == 46. ? (p.x < 8. ? 0u : (p.x < 16. ? 0u : (p.x < 24. ? 0u : (p.x < 32. ? 0u : (p.x < 40. ? 0u : (p.x < 48. ? 0u : (p.x < 56. ? 0u : (p.x < 64. ? 1431633920u : (p.x < 72. ? 13107u : (p.x < 80. ? 21845u : 0u)))))))))) : v;
    v = p.y == 45. ? (p.x < 8. ? 0u : (p.x < 16. ? 0u : (p.x < 24. ? 0u : (p.x < 32. ? 0u : (p.x < 40. ? 0u : (p.x < 48. ? 0u : (p.x < 56. ? 0u : (p.x < 64. ? 1431655680u : (p.x < 72. ? 3355443u : (p.x < 80. ? 3364147u : 0u)))))))))) : v;
    v = p.y == 44. ? (p.x < 8. ? 0u : (p.x < 16. ? 0u : (p.x < 24. ? 0u : (p.x < 32. ? 0u : (p.x < 40. ? 0u : (p.x < 48. ? 0u : (p.x < 56. ? 0u : (p.x < 64. ? 1431655680u : (p.x < 72. ? 3355443u : (p.x < 80. ? 859002112u : 0u)))))))))) : v;
    v = p.y == 43. ? (p.x < 8. ? 0u : (p.x < 16. ? 0u : (p.x < 24. ? 0u : (p.x < 32. ? 0u : (p.x < 40. ? 0u : (p.x < 48. ? 0u : (p.x < 56. ? 0u : (p.x < 64. ? 286348544u : (p.x < 72. ? 3355409u : (p.x < 80. ? 859002112u : 0u)))))))))) : v;
    v = p.y == 42. ? (p.x < 8. ? 0u : (p.x < 16. ? 0u : (p.x < 24. ? 0u : (p.x < 32. ? 0u : (p.x < 40. ? 0u : (p.x < 48. ? 0u : (p.x < 56. ? 0u : (p.x < 64. ? 1427199232u : (p.x < 72. ? 3346705u : (p.x < 80. ? 859002112u : 0u)))))))))) : v;
    v = p.y == 41. ? (p.x < 8. ? 0u : (p.x < 16. ? 0u : (p.x < 24. ? 0u : (p.x < 32. ? 0u : (p.x < 40. ? 6710886u : (p.x < 48. ? 6684774u : (p.x < 56. ? 6710886u : (p.x < 64. ? 2004309248u : (p.x < 72. ? 858993459u : (p.x < 80. ? 859002112u : 0u)))))))))) : v;
    v = p.y == 40. ? (p.x < 8. ? 0u : (p.x < 16. ? 0u : (p.x < 24. ? 0u : (p.x < 32. ? 0u : (p.x < 40. ? 26112u : (p.x < 48. ? 6684774u : (p.x < 56. ? 102u : (p.x < 64. ? 1431655799u : (p.x < 72. ? 3355443u : (p.x < 80. ? 859002112u : 0u)))))))))) : v;
    v = p.y == 39. ? (p.x < 8. ? 0u : (p.x < 16. ? 0u : (p.x < 24. ? 0u : (p.x < 32. ? 0u : (p.x < 40. ? 26112u : (p.x < 48. ? 6710886u : (p.x < 56. ? 26214u : (p.x < 64. ? 861230387u : (p.x < 72. ? 858993459u : (p.x < 80. ? 859002112u : 0u)))))))))) : v;
    v = p.y == 38. ? (p.x < 8. ? 0u : (p.x < 16. ? 0u : (p.x < 24. ? 0u : (p.x < 32. ? 0u : (p.x < 40. ? 26112u : (p.x < 48. ? 6684774u : (p.x < 56. ? 102u : (p.x < 64. ? 861221632u : (p.x < 72. ? 3355443u : (p.x < 80. ? 859002112u : 0u)))))))))) : v;
    v = p.y == 37. ? (p.x < 8. ? 0u : (p.x < 16. ? 0u : (p.x < 24. ? 0u : (p.x < 32. ? 0u : (p.x < 40. ? 26112u : (p.x < 48. ? 6684774u : (p.x < 56. ? 6710886u : (p.x < 64. ? 1429418837u : (p.x < 72. ? 3355443u : (p.x < 80. ? 859002197u : 0u)))))))))) : v;
    v = p.y == 36. ? (p.x < 8. ? 0u : (p.x < 16. ? 0u : (p.x < 24. ? 0u : (p.x < 32. ? 0u : (p.x < 40. ? 0u : (p.x < 48. ? 0u : (p.x < 56. ? 858993408u : (p.x < 64. ? 1429418803u : (p.x < 72. ? 13107u : (p.x < 80. ? 859002197u : 0u)))))))))) : v;
    v = p.y == 35. ? (p.x < 8. ? 0u : (p.x < 16. ? 0u : (p.x < 24. ? 0u : (p.x < 32. ? 0u : (p.x < 40. ? 0u : (p.x < 48. ? 0u : (p.x < 56. ? 858993459u : (p.x < 64. ? 858993459u : (p.x < 72. ? 1430458675u : (p.x < 80. ? 858993493u : 0u)))))))))) : v;
    v = p.y == 34. ? (p.x < 8. ? 0u : (p.x < 16. ? 0u : (p.x < 24. ? 0u : (p.x < 32. ? 0u : (p.x < 40. ? 0u : (p.x < 48. ? 855638016u : (p.x < 56. ? 858993459u : (p.x < 64. ? 858993459u : (p.x < 72. ? 1431647027u : (p.x < 80. ? 858993493u : 0u)))))))))) : v;
    v = p.y == 33. ? (p.x < 8. ? 0u : (p.x < 16. ? 0u : (p.x < 24. ? 0u : (p.x < 32. ? 102u : (p.x < 40. ? 1711276032u : (p.x < 48. ? 858980352u : (p.x < 56. ? 859006566u : (p.x < 64. ? 861230421u : (p.x < 72. ? 1431647027u : (p.x < 80. ? 858993459u : 0u)))))))))) : v;
    v = p.y == 32. ? (p.x < 8. ? 0u : (p.x < 16. ? 0u : (p.x < 24. ? 0u : (p.x < 32. ? 102u : (p.x < 40. ? 1711276032u : (p.x < 48. ? 1714631424u : (p.x < 56. ? 862335795u : (p.x < 64. ? 859002163u : (p.x < 72. ? 858993459u : (p.x < 80. ? 858993459u : 0u)))))))))) : v;
    v = p.y == 31. ? (p.x < 8. ? 0u : (p.x < 16. ? 0u : (p.x < 24. ? 0u : (p.x < 32. ? 102u : (p.x < 40. ? 1711276032u : (p.x < 48. ? 1714631475u : (p.x < 56. ? 858993459u : (p.x < 64. ? 859006515u : (p.x < 72. ? 858993459u : (p.x < 80. ? 3355443u : 0u)))))))))) : v;
    v = p.y == 30. ? (p.x < 8. ? 0u : (p.x < 16. ? 0u : (p.x < 24. ? 0u : (p.x < 32. ? 102u : (p.x < 40. ? 862322688u : (p.x < 48. ? 1714631526u : (p.x < 56. ? 858984721u : (p.x < 64. ? 859006515u : (p.x < 72. ? 858993459u : (p.x < 80. ? 3355443u : 0u)))))))))) : v;
    v = p.y == 29. ? (p.x < 8. ? 0u : (p.x < 16. ? 0u : (p.x < 24. ? 0u : (p.x < 32. ? 102u : (p.x < 40. ? 291897344u : (p.x < 48. ? 288568166u : (p.x < 56. ? 858993510u : (p.x < 64. ? 859006515u : (p.x < 72. ? 858993459u : (p.x < 80. ? 13107u : 0u)))))))))) : v;
    v = p.y == 28. ? (p.x < 8. ? 0u : (p.x < 16. ? 0u : (p.x < 24. ? 0u : (p.x < 32. ? 102u : (p.x < 40. ? 291897344u : (p.x < 48. ? 286331238u : (p.x < 56. ? 859006515u : (p.x < 64. ? 859006515u : (p.x < 72. ? 858993459u : (p.x < 80. ? 13107u : 0u)))))))))) : v;
    v = p.y == 27. ? (p.x < 8. ? 0u : (p.x < 16. ? 0u : (p.x < 24. ? 0u : (p.x < 32. ? 102u : (p.x < 40. ? 1717986816u : (p.x < 48. ? 856778342u : (p.x < 56. ? 862335795u : (p.x < 64. ? 859006515u : (p.x < 72. ? 858993459u : (p.x < 80. ? 51u : 0u)))))))))) : v;
    v = p.y == 26. ? (p.x < 8. ? 21845u : (p.x < 16. ? 0u : (p.x < 24. ? 0u : (p.x < 32. ? 102u : (p.x < 40. ? 286352896u : (p.x < 48. ? 859006481u : (p.x < 56. ? 862335795u : (p.x < 64. ? 859006515u : (p.x < 72. ? 858993459u : 0u))))))))) : v;
    v = p.y == 25. ? (p.x < 8. ? 13107u : (p.x < 16. ? 0u : (p.x < 24. ? 0u : (p.x < 32. ? 858993510u : (p.x < 40. ? 856778291u : (p.x < 48. ? 1714644531u : (p.x < 56. ? 862335795u : (p.x < 64. ? 859006515u : (p.x < 72. ? 858993459u : 0u))))))))) : v;
    v = p.y == 24. ? (p.x < 8. ? 5583667u : (p.x < 16. ? 0u : (p.x < 24. ? 858993476u : (p.x < 32. ? 1717986918u : (p.x < 40. ? 859006515u : (p.x < 48. ? 859006515u : (p.x < 56. ? 859006566u : (p.x < 64. ? 859006515u : (p.x < 72. ? 3355443u : 0u))))))))) : v;
    v = p.y == 23. ? (p.x < 8. ? 858993459u : (p.x < 16. ? 1431655765u : (p.x < 24. ? 858993459u : (p.x < 32. ? 858993459u : (p.x < 40. ? 858993459u : (p.x < 48. ? 858993459u : (p.x < 56. ? 858993459u : (p.x < 64. ? 858993459u : (p.x < 72. ? 13107u : 0u))))))))) : v;
    v = p.y == 22. ? (p.x < 8. ? 858993408u : (p.x < 16. ? 858993459u : (p.x < 24. ? 858993459u : (p.x < 32. ? 858993459u : (p.x < 40. ? 858993459u : (p.x < 48. ? 858993459u : (p.x < 56. ? 858993459u : (p.x < 64. ? 858993459u : (p.x < 72. ? 13107u : 0u))))))))) : v;
    v = p.y == 21. ? (p.x < 8. ? 858980352u : (p.x < 16. ? 858993459u : (p.x < 24. ? 858993459u : (p.x < 32. ? 858993459u : (p.x < 40. ? 858993459u : (p.x < 48. ? 858993459u : (p.x < 56. ? 858993459u : (p.x < 64. ? 858993459u : (p.x < 72. ? 51u : 0u))))))))) : v;
    v = p.y == 20. ? (p.x < 8. ? 1717986816u : (p.x < 16. ? 1714631526u : (p.x < 24. ? 6710886u : (p.x < 32. ? 1717986918u : (p.x < 40. ? 1717986816u : (p.x < 48. ? 1714631526u : (p.x < 56. ? 862348902u : (p.x < 64. ? 1717986918u : (p.x < 72. ? 51u : (p.x < 80. ? 6710886u : 0u)))))))))) : v;
    v = p.y == 19. ? (p.x < 8. ? 1717960704u : (p.x < 16. ? 858993510u : (p.x < 24. ? 26214u : (p.x < 32. ? 6710784u : (p.x < 40. ? 1717960704u : (p.x < 48. ? 286339942u : (p.x < 56. ? 859006566u : (p.x < 64. ? 862348851u : (p.x < 72. ? 51u : (p.x < 80. ? 6710886u : 0u)))))))))) : v;
    v = p.y == 18. ? (p.x < 8. ? 1717960704u : (p.x < 16. ? 859006566u : (p.x < 24. ? 26214u : (p.x < 32. ? 6710784u : (p.x < 40. ? 1717960704u : (p.x < 48. ? 859006566u : (p.x < 56. ? 859006566u : (p.x < 64. ? 862348851u : (p.x < 72. ? 855638067u : (p.x < 80. ? 862348902u : 0u)))))))))) : v;
    v = p.y == 17. ? (p.x < 8. ? 1717960704u : (p.x < 16. ? 859006566u : (p.x < 24. ? 26214u : (p.x < 32. ? 6710784u : (p.x < 40. ? 1717960704u : (p.x < 48. ? 859006566u : (p.x < 56. ? 859006566u : (p.x < 64. ? 862348851u : (p.x < 72. ? 855638067u : (p.x < 80. ? 862348902u : 0u)))))))))) : v;
    v = p.y == 16. ? (p.x < 8. ? 1717960704u : (p.x < 16. ? 862348902u : (p.x < 24. ? 26214u : (p.x < 32. ? 6710784u : (p.x < 40. ? 1717960704u : (p.x < 48. ? 862348902u : (p.x < 56. ? 856778342u : (p.x < 64. ? 862348851u : (p.x < 72. ? 1711276083u : (p.x < 80. ? 1717986918u : 0u)))))))))) : v;
    v = p.y == 15. ? (p.x < 8. ? 1717960704u : (p.x < 16. ? 862348902u : (p.x < 24. ? 26214u : (p.x < 32. ? 6710784u : (p.x < 40. ? 1717960704u : (p.x < 48. ? 862348902u : (p.x < 56. ? 288581222u : (p.x < 64. ? 862348851u : (p.x < 72. ? 1711276083u : (p.x < 80. ? 1717986918u : 0u)))))))))) : v;
    v = p.y == 14. ? (p.x < 8. ? 1717960704u : (p.x < 16. ? 1717986867u : (p.x < 24. ? 26214u : (p.x < 32. ? 6710784u : (p.x < 40. ? 1717960704u : (p.x < 48. ? 1717986867u : (p.x < 56. ? 288581222u : (p.x < 64. ? 862348851u : (p.x < 72. ? 1714618419u : (p.x < 80. ? 1717986918u : 51u)))))))))) : v;
    v = p.y == 13. ? (p.x < 8. ? 1717960704u : (p.x < 16. ? 1717986816u : (p.x < 24. ? 26214u : (p.x < 32. ? 6710784u : (p.x < 40. ? 1717960704u : (p.x < 48. ? 1717986816u : (p.x < 56. ? 859006566u : (p.x < 64. ? 862348817u : (p.x < 72. ? 1714618419u : (p.x < 80. ? 1717986918u : 51u)))))))))) : v;
    v = p.y == 12. ? (p.x < 8. ? 1717960704u : (p.x < 16. ? 1717973760u : (p.x < 24. ? 26214u : (p.x < 32. ? 6710784u : (p.x < 40. ? 1717960704u : (p.x < 48. ? 1717973760u : (p.x < 56. ? 859006566u : (p.x < 64. ? 862348851u : (p.x < 72. ? 1717960755u : (p.x < 80. ? 1717965107u : 102u)))))))))) : v;
    v = p.y == 11. ? (p.x < 8. ? 1717960704u : (p.x < 16. ? 1717960704u : (p.x < 24. ? 26214u : (p.x < 32. ? 6710784u : (p.x < 40. ? 1717960704u : (p.x < 48. ? 1717960704u : (p.x < 56. ? 859006566u : (p.x < 64. ? 862348851u : (p.x < 72. ? 1717960755u : (p.x < 80. ? 1717965073u : 102u)))))))))) : v;
    v = p.y == 10. ? (p.x < 8. ? 1717960704u : (p.x < 16. ? 1714618368u : (p.x < 24. ? 26214u : (p.x < 32. ? 6710784u : (p.x < 40. ? 1717960704u : (p.x < 48. ? 1714618368u : (p.x < 56. ? 859006566u : (p.x < 64. ? 862348851u : (p.x < 72. ? 1717973811u : (p.x < 80. ? 1717965073u : 13158u)))))))))) : v;
    v = p.y == 9. ? (p.x < 8. ? 1717960704u : (p.x < 16. ? 1711276032u : (p.x < 24. ? 26214u : (p.x < 32. ? 6710784u : (p.x < 40. ? 1717960704u : (p.x < 48. ? 1711276032u : (p.x < 56. ? 855664230u : (p.x < 64. ? 862348851u : (p.x < 72. ? 1717973811u : (p.x < 80. ? 1717986918u : 13158u)))))))))) : v;
    v = p.y == 8. ? (p.x < 8. ? 1717960704u : (p.x < 16. ? 855638016u : (p.x < 24. ? 26214u : (p.x < 32. ? 6710784u : (p.x < 40. ? 1717960704u : (p.x < 48. ? 855638016u : (p.x < 56. ? 855664230u : (p.x < 64. ? 862348851u : (p.x < 72. ? 1717986867u : (p.x < 80. ? 1717986918u : 26214u)))))))))) : v;
    v = p.y == 7. ? (p.x < 8. ? 2004287488u : (p.x < 16. ? 0u : (p.x < 24. ? 30583u : (p.x < 32. ? 7829248u : (p.x < 40. ? 2004287488u : (p.x < 48. ? 0u : (p.x < 56. ? 30583u : (p.x < 64. ? 863467315u : (p.x < 72. ? 863467315u : (p.x < 80. ? 1996488704u : 30583u)))))))))) : v;
    v = p.y == 6. ? (p.x < 8. ? 2004287488u : (p.x < 16. ? 0u : (p.x < 24. ? 30515u : (p.x < 32. ? 7829248u : (p.x < 40. ? 2004287488u : (p.x < 48. ? 0u : (p.x < 56. ? 30515u : (p.x < 64. ? 863467315u : (p.x < 72. ? 7829265u : (p.x < 80. ? 855638016u : 3372919u)))))))))) : v;
    v = p.y == 5. ? (p.x < 8. ? 2004317952u : (p.x < 16. ? 119u : (p.x < 24. ? 30464u : (p.x < 32. ? 2004318071u : (p.x < 40. ? 2004317952u : (p.x < 48. ? 119u : (p.x < 56. ? 30464u : (p.x < 64. ? 7829248u : (p.x < 72. ? 863467383u : (p.x < 80. ? 1996488704u : 7829367u)))))))))) : v;
    v = p.y == 4. ? (p.x < 8. ? 0u : (p.x < 16. ? 0u : (p.x < 24. ? 0u : (p.x < 32. ? 0u : (p.x < 40. ? 0u : (p.x < 48. ? 0u : (p.x < 56. ? 0u : (p.x < 64. ? 7829248u : 0u)))))))) : v;
    v = p.y == 3. ? (p.x < 8. ? 0u : (p.x < 16. ? 0u : (p.x < 24. ? 0u : (p.x < 32. ? 0u : (p.x < 40. ? 0u : (p.x < 48. ? 0u : (p.x < 56. ? 0u : (p.x < 64. ? 3372834u : 0u)))))))) : v;
    v = p.y == 2. ? (p.x < 8. ? 0u : (p.x < 16. ? 0u : (p.x < 24. ? 0u : (p.x < 32. ? 0u : (p.x < 40. ? 0u : (p.x < 48. ? 0u : (p.x < 56. ? 0u : (p.x < 64. ? 3372919u : 0u)))))))) : v;
    v = p.y == 1. ? (p.x < 8. ? 0u : (p.x < 16. ? 0u : (p.x < 24. ? 0u : (p.x < 32. ? 0u : (p.x < 40. ? 0u : (p.x < 48. ? 0u : (p.x < 56. ? 0u : (p.x < 64. ? 1144627u : 0u)))))))) : v;
    v = p.y == 0. ? (p.x < 8. ? 0u : (p.x < 16. ? 0u : (p.x < 24. ? 0u : (p.x < 32. ? 0u : (p.x < 40. ? 0u : (p.x < 48. ? 0u : (p.x < 56. ? 285212672u : (p.x < 64. ? 1127287u : 0u)))))))) : v;
    v = p.x >= 0. && p.x < 86. ? v : 0u;

    float i = float((v >> uint(4. * p.x)) & 15u);
    color = i == 1. ? vec3(0) : color;
    color = i == 2. ? vec3(0.34) : color;
    color = i == 3. ? vec3(0.38) : color;
    color = i == 4. ? vec3(0.48) : color;
    color = i == 5. ? vec3(0.54) : color;
    color = i == 6. ? vec3(0.53, 0.48, 0.87) : color;
    color = i == 7. ? vec3(0.7) : color;
}

// "Holding" text
void Holding(inout vec3 color, vec2 p)
{
    uint v = 0u;
    v = p.y == 5. ? (p.x < 8. ? 291923456u : (p.x < 16. ? 1714618470u : (p.x < 24. ? 6684740u : (p.x < 32. ? 1717986816u : (p.x < 40. ? 1432769877u : (p.x < 48. ? 5596774u : (p.x < 56. ? 5596757u : 0u))))))) : v;
    v = p.y == 4. ? (p.x < 8. ? 291897344u : (p.x < 16. ? 291897446u : (p.x < 24. ? 6684774u : (p.x < 32. ? 291897344u : (p.x < 40. ? 6684774u : (p.x < 48. ? 6689126u : (p.x < 56. ? 6684774u : 0u))))))) : v;
    v = p.y == 3. ? (p.x < 8. ? 1717960704u : (p.x < 16. ? 291897446u : (p.x < 24. ? 6684774u : (p.x < 32. ? 291897344u : (p.x < 40. ? 6684774u : (p.x < 48. ? 6689126u : (p.x < 56. ? 102u : 0u))))))) : v;
    v = p.y == 2. ? (p.x < 8. ? 291897446u : (p.x < 16. ? 291897446u : (p.x < 24. ? 6684774u : (p.x < 32. ? 291897344u : (p.x < 40. ? 6684774u : (p.x < 48. ? 6689126u : (p.x < 56. ? 6684774u : 102u))))))) : v;
    v = p.y == 1. ? (p.x < 8. ? 291897344u : (p.x < 16. ? 291897446u : (p.x < 24. ? 6684774u : (p.x < 32. ? 291897344u : (p.x < 40. ? 6684774u : (p.x < 48. ? 6689126u : (p.x < 56. ? 6684774u : 0u))))))) : v;
    v = p.y == 0. ? (p.x < 8. ? 291927808u : (p.x < 16. ? 1713504358u : (p.x < 24. ? 1717982549u : (p.x < 32. ? 1717982566u : (p.x < 40. ? 6684757u : (p.x < 48. ? 6689126u : (p.x < 56. ? 5596757u : 0u))))))) : v;
    v = p.x >= 0. && p.x < 58. ? v : 0u;

    float i = float((v >> uint(4. * p.x)) & 15u);
    color = i == 1. ? vec3(0) : color;
    color = i == 2. ? vec3(0.32) : color;
    color = i == 3. ? vec3(0.33) : color;
    color = i == 4. ? vec3(0.35) : color;
    color = i == 5. ? vec3(0.38) : color;
    color = i == 6. ? vec3(0.7) : color;
    color = i == 7. ? vec3(1) : color;
}

// "Collect" text
void Collect(inout vec3 color, vec2 p)
{
    uint v = 0u;
    v = p.y == 5. ? (p.x < 16. ? 1348096000u : (p.x < 32. ? 2768282970u : (p.x < 48. ? 1353360640u : 11183530u))) : v;
    v = p.y == 4. ? (p.x < 16. ? 2695208960u : (p.x < 32. ? 2684395680u : (p.x < 48. ? 2684395520u : 655525u))) : v;
    v = p.y == 3. ? (p.x < 16. ? 2684395520u : (p.x < 32. ? 2684395680u : (p.x < 48. ? 2685052160u : 655360u))) : v;
    v = p.y == 2. ? (p.x < 16. ? 2684396810u : (p.x < 32. ? 2684395680u : (p.x < 48. ? 2768281600u : 2685009920u))) : v;
    v = p.y == 1. ? (p.x < 16. ? 2695208960u : (p.x < 32. ? 2684395680u : (p.x < 48. ? 2684395520u : 655525u))) : v;
    v = p.y == 0. ? (p.x < 16. ? 1348096000u : (p.x < 32. ? 2779424090u : (p.x < 48. ? 1353360810u : 675930u))) : v;
    v = p.x >= 0. && p.x < 64. ? v : 0u;

    float i = float((v >> uint(2. * p.x)) & 3u);
    color = i == 1. ? vec3(0.38) : color;
    color = i == 2. ? vec3(0.7) : color;
}

// "Wounds" text
void Wounds(inout vec3 color, vec2 p)
{
    uint v = 0u;
    v = p.y == 5. ? (p.x < 8. ? 7829248u : (p.x < 16. ? 293041920u : (p.x < 24. ? 289699686u : (p.x < 32. ? 1148653943u : (p.x < 40. ? 2002089847u : (p.x < 48. ? 4487031u : (p.x < 56. ? 7829367u : 0u))))))) : v;
    v = p.y == 4. ? (p.x < 8. ? 7798784u : (p.x < 16. ? 293011456u : (p.x < 24. ? 293015927u : (p.x < 32. ? 293015927u : (p.x < 40. ? 293015927u : (p.x < 48. ? 7803255u : (p.x < 56. ? 119u : 0u))))))) : v;
    v = p.y == 3. ? (p.x < 8. ? 7798784u : (p.x < 16. ? 293011456u : (p.x < 24. ? 293015927u : (p.x < 32. ? 293015927u : (p.x < 40. ? 293015927u : (p.x < 48. ? 7803255u : (p.x < 56. ? 4486980u : 0u))))))) : v;
    v = p.y == 2. ? (p.x < 8. ? 578224247u : (p.x < 16. ? 293028983u : (p.x < 24. ? 293015927u : (p.x < 32. ? 293015927u : (p.x < 40. ? 293015927u : (p.x < 48. ? 7803255u : (p.x < 56. ? 7798784u : 119u))))))) : v;
    v = p.y == 1. ? (p.x < 8. ? 2004287488u : (p.x < 16. ? 293041937u : (p.x < 24. ? 293015927u : (p.x < 32. ? 293015927u : (p.x < 40. ? 293015927u : (p.x < 48. ? 7803255u : (p.x < 56. ? 7798903u : 0u))))))) : v;
    v = p.y == 0. ? (p.x < 8. ? 1148649472u : (p.x < 16. ? 293028881u : (p.x < 24. ? 289699652u : (p.x < 32. ? 289699652u : (p.x < 40. ? 1148653943u : (p.x < 48. ? 4487031u : (p.x < 56. ? 7829299u : 0u))))))) : v;
    v = p.x >= 0. && p.x < 58. ? v : 0u;

    float i = float((v >> uint(4. * p.x)) & 15u);
    color = i == 1. ? vec3(0) : color;
    color = i == 2. ? vec3(0.34) : color;
    color = i == 3. ? vec3(0.36) : color;
    color = i == 4. ? vec3(0.38) : color;
    color = i == 5. ? vec3(0.4) : color;
    color = i == 6. ? vec3(0.41) : color;
    color = i == 7. ? vec3(0.7) : color;
}

// "Enemy" text
void Enemy(inout vec3 color, vec2 p)
{
    uint v = 0u;
    v = p.y == 6. ? (p.x < 16. ? 0u : (p.x < 32. ? 0u : (p.x < 48. ? 1342177280u : 0u))) : v;
    v = p.y == 5. ? (p.x < 16. ? 2779424000u : (p.x < 32. ? 2779424170u : (p.x < 48. ? 2694883930u : 0u))) : v;
    v = p.y == 4. ? (p.x < 16. ? 2684395520u : (p.x < 32. ? 2684395680u : (p.x < 48. ? 2694881440u : 0u))) : v;
    v = p.y == 3. ? (p.x < 16. ? 2685052170u : (p.x < 32. ? 2685052320u : (p.x < 48. ? 2778767520u : 2560u))) : v;
    v = p.y == 2. ? (p.x < 16. ? 2684395520u : (p.x < 32. ? 2684395680u : (p.x < 48. ? 1515233440u : 0u))) : v;
    v = p.y == 1. ? (p.x < 16. ? 2684395520u : (p.x < 32. ? 2684395680u : (p.x < 48. ? 167813280u : 0u))) : v;
    v = p.y == 0. ? (p.x < 16. ? 2779424000u : (p.x < 32. ? 2695538080u : (p.x < 48. ? 167813200u : 0u))) : v;
    v = p.x >= 0. && p.x < 54. ? v : 0u;

    float i = float((v >> uint(2. * p.x)) & 3u);
    color = i == 1. ? vec3(0.38) : color;
    color = i == 2. ? vec3(0.7) : color;
}

// Enemy health bar
void EnemyHealth(inout vec3 color, vec2 p)
{
    vec3 EHCOL1 = vec3(.7, .92, .56);
    vec3 EHCOL2 = vec3(.52, .47, .87);
    
    if(p.x > -5. && p.x < 62. && p.y > -17. && p.y < -8.)
        color = EHCOL1;
    if(p.x > -3. && p.x < 60. && p.y > -16. && p.y < -9.)
        color = EHCOL2;
}

// Vertical borders
void BorderV(inout vec3 color, vec2 p)
{
    vec3 BCOL1 = vec3(.7, .7, .7);
    vec3 BCOL2 = vec3(.376, .376, .376);
    vec2 bo = vec2(0., 2.);

    if(p.x < 2. || p.x > 318.) return;
    if(p.y == bo.y || p.y == bo.y - 1.) { color = BCOL1; return; }  
    if(p.y == bo.y + 1. || p.y == bo.y - 2.) { color = BCOL2; return; }   
    
    bo.y += 51.;
    if(p.y == bo.y || p.y == bo.y - 1.) { color = BCOL1; return; }  
    if(p.y == bo.y + 1. || p.y == bo.y - 2.) { color = BCOL2; return; } 
    
    bo.y += 150.;
    if(p.x < 245.) return;
    if(p.y == bo.y || p.y == bo.y - 1.) { color = BCOL1; return; }  
    if(p.y == bo.y + 1. || p.y == bo.y - 2.) { color = BCOL2; return; }
    
    bo.y -= 55.;
    if(p.x < 245.) return;
    if(p.y == bo.y || p.y == bo.y - 1.) { color = BCOL1; return; }  
    if(p.y == bo.y + 1. || p.y == bo.y - 2.) { color = BCOL2; return; }   
}

// Horizontal borders
void BorderH(inout vec3 color, vec2 p)
{
    vec3 BCOL1 = vec3(.7, .7, .7);
    vec3 BCOL2 = vec3(.376, .376, .376);
    vec2 bo = vec2(318., 2.);

    if(p.y < 1. || p.y > 203.) return;
    if(p.x == bo.x || p.x == bo.x - 1.) { color = BCOL1; return; }  
    if(p.x == bo.x + 1. || p.x == bo.x + 2. || p.x == bo.x - 2. || p.x == bo.x - 3.) { color = BCOL2; return; }
    
    bo.x -= 72.;
    if(p.x > 10. && (p.y < 54. || p.y > 203.)) return;
    if(p.x == bo.x || p.x == bo.x - 1.) { color = BCOL1; return; }  
    if(p.x == bo.x + 1. || p.x == bo.x + 2. || p.x == bo.x - 2. || p.x == bo.x - 3.) { color = BCOL2; return; }
    
    bo.x -= 243.;
    if(p.y < 1. || p.y > 53.) return;
    if(p.x == bo.x || p.x == bo.x - 1.) { color = BCOL1; return; }  
    if(p.x == bo.x + 1. || p.x == bo.x + 2. || p.x == bo.x - 2. || p.x == bo.x - 3.) { color = BCOL2; return; } 
}

// final touches to the rendered border (smoothing, pixel fixes etc.)
void BorderFinish(inout vec3 color, vec2 p)
{
    vec3 BCOL1 = vec3(.7, .7, .7);
    if(p.x > 3. && p.x < 6. && p.y > 51. && p.y < 54.)
        color = BCOL1;

    if(p.x > 3. && p.x < 6. && p.y > 0. && p.y < 3.)
        color = BCOL1;
    
    if(p.x > 314. && p.x < 317. && p.y > 51. && p.y < 54.)
        color = BCOL1;

    if(p.x > 314. && p.x < 317. && p.y > 0. && p.y < 3.)
        color = BCOL1;
    
    if(p.x > 314. && p.x < 317. && p.y > 146. && p.y < 149.)
        color = BCOL1;
    
    if(p.x > 314. && p.x < 317. && p.y > 201. && p.y < 204.)
        color = BCOL1;
    
    if(p.x > 246. && p.x < 249. && p.y > 146. && p.y < 149.)
        color = BCOL1;
    
    if(p.x > 246. && p.x < 249. && p.y > 201. && p.y < 204.)
        color = BCOL1;
}

// render entire border
void Border(inout vec3 color, vec2 p)
{
    BorderV(color, p);
    BorderH(color, p);
    BorderFinish(color, p);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec3 color = vec3(0);

    vec2 borderOffset = vec2(SPLASH_OFFSET_X, SPLASH_OFFSET_Y);
    vec2 healthOffset = vec2(borderOffset.x + 10., borderOffset.y + 18.);
    vec2 powerOffset  = vec2(healthOffset.x + 3., healthOffset.y - 11.);
    vec2 weaponsOffset  = vec2(healthOffset.x + 90., healthOffset.y + 1.);
    vec2 weaponryOffset = vec2(weaponsOffset.x + 12., powerOffset.y);
    vec2 theLastNinjaOffset = vec2(weaponsOffset.x + 125., weaponsOffset.y - 19.);
    vec2 holdingOffset = vec2(theLastNinjaOffset.x + 28., theLastNinjaOffset.y + 95.);
    vec2 collectOffset = vec2(holdingOffset.x - 4., holdingOffset.y + 40.);
    vec2 woundsOffset = vec2(collectOffset.x + 2., collectOffset.y + 20.);
    vec2 enemyOffset  = vec2(woundsOffset.x + 2., woundsOffset.y + 32.);
    vec2 enemyHealthOffset = vec2(enemyOffset.x, enemyOffset.y);

    vec2 scale = iResolution.xy / SCALE;
    vec2 pixel = floor(fragCoord / max(min(scale.x, scale.y), 1.));

    // render
    Border(color, pixel - borderOffset);
    Health(color, pixel - healthOffset);
    Power(color, pixel - powerOffset);
    Weapons(color, pixel - weaponsOffset);
    Weaponry(color, pixel - weaponryOffset);
    TheLastNinja(color, pixel - theLastNinjaOffset);
    Holding(color, pixel - holdingOffset);
    Collect(color, pixel - collectOffset);
    Wounds(color, pixel - woundsOffset);
    Enemy(color, pixel - enemyOffset);
    EnemyHealth(color, pixel - enemyHealthOffset);

    fragColor = vec4(color, 1.);
}